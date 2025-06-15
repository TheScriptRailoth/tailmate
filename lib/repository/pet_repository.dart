import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../models/pet.dart';

class PetRepository {
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
}
