import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/pet_cubit.dart';
import '../models/pet.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final adoptedPets = context.watch<PetCubit>().state.where((pet) => pet.isAdopted).toList().reversed.toList();
    return Scaffold(
      floatingActionButton: ElevatedButton(onPressed: (){}, child: Text("Clear History")),
      appBar: AppBar(title: const Text('Adoption History')),
      body: BlocBuilder<PetCubit, List<Pet>>(
        builder: (context, pets) {
          final adoptedPets = pets.where((pet) => pet.isAdopted).toList();

          if (adoptedPets.isEmpty) {
            return const Center(child: Text('No pets adopted yet'));
          }

          return ListView.builder(
            itemCount: adoptedPets.length,
            itemBuilder: (context, index) {
              final pet = adoptedPets[index];
              return ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage(pet.imageUrl)),
                title: Text(pet.name),
                subtitle: Text('Age: ${pet.age}, ₹${pet.price}'),
              );
            },
          );
        },
      ),
    );
  }
}
