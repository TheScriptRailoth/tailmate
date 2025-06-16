import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../models/pet.dart';
import '../repository/pet_repository.dart';

class PetCubit extends Cubit<List<Pet>> {
  PetCubit() : super([]);

  void searchPets(String query) {
    final allPets = Hive.box<Pet>('pets').values.toList();
    final filtered = allPets.where((pet) => pet.name.toLowerCase().contains(query.toLowerCase())).toList();
    emit(filtered);
  }

  void loadPets(List<Pet> pets) {
    emit(pets);
  }

  void adoptPet(String petId) {

    final box = Hive.box<Pet>('pets');
    final updatedPets = state.map((pet){
      if (pet.id == petId) {
        final updatedPet = pet.copyWith(isAdopted: true);
        box.put(updatedPet.id, updatedPet); 
        return updatedPet;
      }
      return pet;
    }).toList();

    emit(updatedPets);
  }

  void toggleFavorite(String petId) {
    final box=Hive.box<Pet>('pets');

    final updatedPets = state.map((pet){
      if(pet.id == petId){
        final updatedPets = pet.copyWith(isFavorite: !pet.isFavorite);
        box.put(updatedPets.id, updatedPets);
        return updatedPets;
      }
      return pet;
    }).toList();

    emit(updatedPets);
  }

  void clearAdoptionHistory() {
    emit(state.map((pet) => pet.copyWith(isAdopted: false)).toList());
  }

  Future<void> fetchAndCachePets(PetRepository repository) async {
    if (await repository.isCacheEmpty()) {
      final pets = await repository.fetchPetsFromApi();
      await repository.savePetsToCache(pets);
      emit(pets);
    } else {
      final cachedPets = await repository.loadPetsFromCache();
      emit(cachedPets);
    }
  }


}

