// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../cubits/pet_cubit.dart';
// import '../models/pet.dart';
//
// class HistoryPage extends StatelessWidget {
//   const HistoryPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Adoption History')),
//       body: BlocBuilder<PetCubit, List<Pet>>(
//         builder: (context, pets) {
//           final adoptedPets = pets.where((pet) => pet.isAdopted).toList().reversed.toList();
//
//           if (adoptedPets.isEmpty) {
//             return const Center(child: Text('No pets adopted yet'));
//           }
//
//           return Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: adoptedPets.length,
//                   itemBuilder: (context, index) {
//                     final pet = adoptedPets[index];
//                     return ListTile(
//                       leading: CircleAvatar(backgroundImage: NetworkImage(pet.imageUrl)),
//                       title: Text(pet.name),
//                       subtitle: Text('Age: ${pet.age}, ₹${pet.price}'),
//                     );
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: ElevatedButton.icon(
//                   onPressed: () {
//                     context.read<PetCubit>().clearAdoptionHistory();
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text("Adoption history cleared")),
//                     );
//                   },
//                   icon: const Icon(Icons.delete),
//                   label: const Text("Clear History"),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,
//                     foregroundColor: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/pet_cubit.dart';
import '../models/pet.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adoption History'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
      ),
      body: BlocBuilder<PetCubit, List<Pet>>(
        builder: (context, pets) {
          final adoptedPets = pets
              .where((pet) => pet.isAdopted)
              .toList()
              .reversed
              .toList();

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
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 80), // bottom space for button
            itemCount: adoptedPets.length,
            itemBuilder: (context, index) {
              final pet = adoptedPets[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8),
                color: colorScheme.surface,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(pet.imageUrl),
                    radius: 28,
                    backgroundColor: colorScheme.primary.withOpacity(0.2),
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
              );
            },
          );
        },
      ),
    );
  }
}
