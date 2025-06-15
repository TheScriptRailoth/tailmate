import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/pet.dart';
import '../cubits/pet_cubit.dart';

class DetailsPage extends StatelessWidget {
  final Pet pet;

  const DetailsPage({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    final isAdopted = pet.isAdopted;

    return Scaffold(
      appBar: AppBar(
        title: Text(pet.name),
        actions: [
          IconButton(
            icon: Icon(
              pet.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: pet.isFavorite ? Colors.red : null,
            ),
            onPressed: () => context.read<PetCubit>().toggleFavorite(pet.id),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Hero(
              tag: pet.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: InteractiveViewer(
                  panEnabled: true,
                  minScale: 1,
                  maxScale: 4,
                  child: Image.network(
                    pet.imageUrl,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              pet.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text("Age: ${pet.age} years • ₹${pet.price}",
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Text(
              "This lovely pet is looking for a new home. If you think you're the right person, adopt them now and give them a loving family!",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Spacer(),
            if (isAdopted)
              const Text(
                'Already Adopted',
                style: TextStyle(color: Colors.grey, fontSize: 18),
              )
            else
              ElevatedButton.icon(
                onPressed: () {
                  context.read<PetCubit>().adoptPet(pet.id);
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('🎉 Adoption Success!'),
                      content: Text('You’ve now adopted ${pet.name}.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.pets),
                label: const Text('Adopt Me'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.teal,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
