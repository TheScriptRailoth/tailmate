import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/pet_cubit.dart';
import '../models/pet.dart';
import '../screens/details_page.dart';


Widget buildPetTile(Pet pet, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DetailsPage(pet: pet)),
      );
    },
    child: Container(
      margin: const EdgeInsets.only( right:16, top : 8, bottom:8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),

      ),
      child: Row(
        children: [
          Hero(
            tag: pet.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                pet.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[300],
                    alignment: Alignment.center,
                    child: Icon(Icons.pets, color: Colors.grey[600]), // or any fallback
                  );
                },
              )

            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pet.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${pet.price} • 2.5 km away',
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${pet.age} YRS',
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              pet.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: pet.isFavorite ? Color(0xff9188E5) : Colors.grey,
            ),
            onPressed: () => context.read<PetCubit>().toggleFavorite(pet.id),
          ),
        ],
      ),
    ),
  );
}

