import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../models/pet.dart';

class PetCubit extends Cubit<List<Pet>> {
  PetCubit() : super([]);

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
}

