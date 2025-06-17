// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../cubits/pet_cubit.dart';
// import '../models/pet.dart';
// import '../screens/details_page.dart';
//
//
// Widget buildPetTile(Pet pet, BuildContext context) {
//   return GestureDetector(
//     onTap: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (_) => DetailsPage(pet: pet)),
//       );
//     },
//     child: Container(
//       margin: const EdgeInsets.only( right:16, top : 8, bottom:8),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Theme.of(context).colorScheme.surface,
//         borderRadius: BorderRadius.circular(16),
//
//       ),
//       child: Row(
//         children: [
//           Hero(
//             tag: pet.id,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: pet.imageBytes != null
//                   ? Image.memory(
//                 pet.imageBytes!,
//                 width: 80,
//                 height: 80,
//                 fit: BoxFit.cover,
//               )
//                   : Image.network(
//                 pet.imageUrl,
//                 width: 80,
//                 height: 80,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Container(
//                     width: 80,
//                     height: 80,
//                     color: Colors.grey[300],
//                     alignment: Alignment.center,
//                     child: Icon(Icons.pets, color: Colors.grey[600]),
//                   );
//                 },
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   pet.name,
//                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   '₹${pet.price} • 2.5 km away',
//                   style: const TextStyle(color: Colors.grey, fontSize: 13),
//                 ),
//                 const SizedBox(height: 6),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: Colors.red[50],
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Text(
//                     '${pet.age} YRS',
//                     style: const TextStyle(
//                       color: Colors.red,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           IconButton(
//             icon: Icon(
//               pet.isFavorite ? Icons.favorite : Icons.favorite_border,
//               color: pet.isFavorite ? Color(0xff9188E5) : Colors.grey,
//             ),
//             onPressed: () => context.read<PetCubit>().toggleFavorite(pet.id),
//           ),
//         ],
//       ),
//     ),
//   );
// }
//


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/pet_cubit.dart';
import '../models/pet.dart';
import '../screens/details_page.dart';

Widget buildPetTile(Pet pet, BuildContext context) {
  final isNew = pet.age <= 2;

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DetailsPage(pet: pet)),
      );
    },
    child: Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Hero(
                tag: pet.id,
                child: ClipPath(
                  clipper: ThreeCornerRoundedClipper(),
                  child: pet.imageBytes != null
                      ? Image.memory(
                    pet.imageBytes!,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                      : Image.network(
                    pet.imageUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 180,
                        width: double.infinity,
                        color: Colors.grey[300],
                        alignment: Alignment.center,
                        child: Icon(Icons.pets, size: 40, color: Colors.grey[600]),
                      );
                    },
                  ),

                ),
              ),
              // Favorite Icon
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () => context.read<PetCubit>().toggleFavorite(pet.id),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      pet.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: pet.isFavorite ? const Color(0xff9188E5) : Colors.grey,
                      size: 20,
                    ),
                  ),
                ),
              ),

              // Price Badge
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '₹${pet.price}',
                    style: const TextStyle(
                      color: Color(0xff9188E5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              if (isNew)
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'NEW',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          // Pet Info
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(pet.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('Age: ${pet.age} yrs', style: TextStyle(color: Colors.grey[700], fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}



class ThreeCornerRoundedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const radius = 16.0;
    final path = Path()
      ..moveTo(0, radius)
      ..quadraticBezierTo(0, 0, radius, 0)
      ..lineTo(size.width - radius, 0)
      ..quadraticBezierTo(size.width, 0, size.width, radius)
      ..lineTo(size.width, size.height)
      ..lineTo(radius, size.height)
      ..quadraticBezierTo(0, size.height, 0, size.height - radius);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

