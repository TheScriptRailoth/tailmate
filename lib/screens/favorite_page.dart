// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../cubits/pet_cubit.dart';
// import '../models/pet.dart';
// import 'details_page.dart';
//
// class FavoritesPage extends StatelessWidget {
//   const FavoritesPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Favorite Pets')),
//       body: BlocBuilder<PetCubit, List<Pet>>(
//         builder: (context, pets) {
//           final favoritePets = pets.where((pet) => pet.isFavorite).toList();
//
//           if (favoritePets.isEmpty) {
//             return const Center(
//               child: Text(
//                 'No favorite pets yet ❤️',
//                 style: TextStyle(fontSize: 18),
//               ),
//             );
//           }
//
//           return ListView.builder(
//             itemCount: favoritePets.length,
//             itemBuilder: (context, index) {
//               final pet = favoritePets[index];
//               return Card(
//                 margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 child: ListTile(
//                   leading: Hero(
//                     tag: pet.id,
//                     child: CircleAvatar(
//                       radius: 28,
//                       backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
//                       backgroundImage: pet.imageBytes != null
//                           ? MemoryImage(pet.imageBytes!)
//                           : NetworkImage(pet.imageUrl) as ImageProvider,
//                     ),
//                   ),
//                   title: Text(pet.name),
//                   subtitle: Text('Age: ${pet.age} • ₹${pet.price}'),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.chevron_right),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => DetailsPage(pet: pet),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               );
//             },
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
import 'details_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: BlocBuilder<PetCubit, List<Pet>>(
        builder: (context, pets) {
          final favoritePets = pets.where((pet) => pet.isFavorite).toList();

          if (favoritePets.isEmpty) {
            return const Center(
              child: Text(
                'You have no favorites yet.',
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
                borderRadius: BorderRadius.circular(16),
                color: colorScheme.surface,
                elevation: 2,
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
                        Hero(
                          tag: pet.id,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor:
                            colorScheme.primary.withOpacity(0.1),
                            backgroundImage: pet.imageBytes != null
                                ? MemoryImage(pet.imageBytes!)
                                : NetworkImage(pet.imageUrl) as ImageProvider,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pet.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Age: ${pet.age}  •  ₹${pet.price}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right),
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

