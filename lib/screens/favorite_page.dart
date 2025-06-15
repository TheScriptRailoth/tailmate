import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/pet_cubit.dart';
import '../models/pet.dart';
import 'details_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Pets')),
      body: BlocBuilder<PetCubit, List<Pet>>(
        builder: (context, pets) {
          final favoritePets = pets.where((pet) => pet.isFavorite).toList();

          if (favoritePets.isEmpty) {
            return const Center(
              child: Text(
                'No favorite pets yet ❤️',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: favoritePets.length,
            itemBuilder: (context, index) {
              final pet = favoritePets[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: ListTile(
                  leading: Hero(
                    tag: pet.id,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(pet.imageUrl),
                    ),
                  ),
                  title: Text(pet.name),
                  subtitle: Text('Age: ${pet.age} • ₹${pet.price}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailsPage(pet: pet),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
