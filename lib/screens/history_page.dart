import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/pet_cubit.dart';
import '../models/pet.dart';
import 'details_page.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Adoption History", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
      ),
      body: BlocBuilder<PetCubit, List<Pet>>(
        builder: (context, pets) {
          final adoptedPets = pets.where((pet) => pet.isAdopted).toList().reversed.toList();

          if (adoptedPets.isEmpty) {
            return Center(
              child: Text(
                'No pets adopted yet',
                style: TextStyle(
                  fontSize: 16,
                  color: colorScheme.onBackground.withOpacity(0.6),
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
            itemCount: adoptedPets.length,
            itemBuilder: (context, index) {
              final pet = adoptedPets[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(_createPetRoute(pet));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  color: colorScheme.surface,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: Hero(
                      tag: 'petImage_${pet.id}',
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                        backgroundImage: pet.imageBytes != null
                            ? MemoryImage(pet.imageBytes!)
                            : NetworkImage(pet.imageUrl) as ImageProvider,
                      ),
                    ),
                    title: Text(
                      pet.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    subtitle: Text(
                      'Age: ${pet.age} | ₹${pet.price}',
                      style: TextStyle(
                        color: colorScheme.onSurface.withOpacity(0.7),
                      ),
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

  Route _createPetRoute(Pet pet) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 600),
      pageBuilder: (context, animation, secondaryAnimation) => DetailsPage(pet: pet),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curve = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
        return FadeTransition(
          opacity: curve,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.95, end: 1.0).animate(curve),
            child: child,
          ),
        );
      },
    );
  }

}
