import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/pet_cubit.dart';
import '../models/pet.dart';
import 'details_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        title: const Text(
          "Favorites",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<PetCubit, List<Pet>>(
        builder: (context, pets) {
          final favoritePets = pets.where((pet) => pet.isFavorite).toList();

          if (favoritePets.isEmpty) {
            return const Center(
              child: Text(
                'You have no favorites yet ❤️',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: favoritePets.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final pet = favoritePets[index];

              return Material(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                elevation: 3,
                shadowColor: Colors.black12,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailsPage(pet: pet),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Hero(
                              tag: pet.id,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: pet.imageBytes != null
                                    ? Image.memory(
                                  pet.imageBytes!,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                )
                                    : Image.network(
                                  pet.imageUrl,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, _, __) => Container(
                                    width: 70,
                                    height: 70,
                                    color: Colors.grey[300],
                                    alignment: Alignment.center,
                                    child: Icon(Icons.pets, color: Colors.grey[600]),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 3,
                                    )
                                  ],
                                ),
                                child: Icon(Icons.favorite, size: 14, color: Colors.redAccent),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pet.name,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Age: ${pet.age} yrs',
                                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Price: ₹${pet.price}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: Colors.grey),
                      ],
                    ),
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

