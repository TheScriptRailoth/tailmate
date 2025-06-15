import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../models/pet.dart';

class PetRepository {
  final String hiveBoxName = 'petsBox';
  final String baseUrl;

  PetRepository({required this.baseUrl});

  Future<List<Pet>> fetchPetsFromApi({bool forceRefresh = false}) async {
    final box = Hive.box<Pet>('pets');
    if(box.isEmpty) {
      final response = await http.get(Uri.parse('$baseUrl/api/pets'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final pets= data.map((json) => Pet.fromJson(json)).toList();

        for(final pet in pets){
          box.put(pet.id, pet);
        }
        return pets;

      } else {
        throw Exception('Failed to fetch pets');
      }
    }else{
      return box.values.toList();
    }
  }

  Future<void> savePetsToCache(List<Pet> pets) async {
    final box = await Hive.openBox(hiveBoxName);
    await box.put('cachedPets', pets.map((pet) => pet.toJson()).toList());
  }

  Future<List<Pet>> loadPetsFromCache() async {
    final box = await Hive.openBox(hiveBoxName);
    final cachedData = box.get('cachedPets') as List?;
    if (cachedData == null) return [];
    return cachedData.map((json) => Pet.fromJson(Map<String, dynamic>.from(json))).toList();
  }

  Future<bool> isCacheEmpty() async {
    final box = await Hive.openBox(hiveBoxName);
    return !(box.containsKey('cachedPets'));
  }

}
