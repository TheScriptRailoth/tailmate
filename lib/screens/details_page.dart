// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../models/pet.dart';
// import '../cubits/pet_cubit.dart';
//
// class DetailsPage extends StatelessWidget {
//   final Pet pet;
//
//   const DetailsPage({super.key, required this.pet});
//
//   @override
//   Widget build(BuildContext context) {
//     final isAdopted = pet.isAdopted;
//
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         title: Text(pet.name),
//         actions: [
//           IconButton(
//             icon: Icon(
//               pet.isFavorite ? Icons.favorite : Icons.favorite_border,
//               color: pet.isFavorite ? Colors.red : null,
//             ),
//             onPressed: () => context.read<PetCubit>().toggleFavorite(pet.id),
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               Hero(
//                 tag: pet.id,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(16),
//                   child: InteractiveViewer(
//                     panEnabled: true,
//                     minScale: 1,
//                     maxScale: 4,
//                     child: Image.network(
//                       pet.imageUrl,
//                       width: double.infinity,
//                       height: 250,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 pet.name,
//                 style: Theme.of(context).textTheme.headlineMedium,
//               ),
//               Text("Age: ${pet.age} years • ₹${pet.price}",
//                   style: Theme.of(context).textTheme.titleMedium),
//               const SizedBox(height: 10),
//               const Divider(),
//               const SizedBox(height: 10),
//               Text(
//                 "This lovely pet is looking for a new home. If you think you're the right person, adopt them now and give them a loving family!",
//                 style: Theme.of(context).textTheme.bodyLarge,
//               ),
//               const Spacer(),
//               if (isAdopted)
//                 const Text(
//                   'Already Adopted',
//                   style: TextStyle(color: Colors.grey, fontSize: 18),
//                 )
//               else
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     context.read<PetCubit>().adoptPet(pet.id);
//                     showDialog(
//                       context: context,
//                       builder: (_) => AlertDialog(
//                         title: const Text('🎉 Adoption Success!'),
//                         content: Text('You’ve now adopted ${pet.name}.'),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.pop(context),
//                             child: const Text('OK'),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                   icon: const Icon(Icons.pets),
//                   label: const Text('Adopt Me'),
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: const Size.fromHeight(50),
//                     backgroundColor: Colors.teal,
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_to_act/slide_to_act.dart';
import '../cubits/pet_cubit.dart';
import '../models/pet.dart';

class DetailsPage extends StatefulWidget {
  final Pet pet;
  const DetailsPage({Key? key,required this.pet}) : super(key: key);
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}
class _DetailsPageState extends State<DetailsPage>{
  late final Pet pet;
  bool isFavorite = false;

  late ConfettiController confettiController;

  @override
  void initState() {
    super.initState();
    pet = widget.pet;
    confettiController = ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pet = widget.pet;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _buildImageSection(context),
                Expanded(child: _buildBottomDetails(context)),
              ],
            ),

            Align(
              alignment: Alignment.topLeft,
              child: ConfettiWidget(
                confettiController: confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                emissionFrequency: 0.2,
                numberOfParticles: 50,
                maxBlastForce: 50,
                minBlastForce: 30,
                gravity: 0.2,
                colors: const [
                  Colors.red,
                  Colors.green,
                  Colors.blue,
                  Colors.orange,
                  Colors.pink,
                  Colors.purple
                ],
                shouldLoop: false,
              )
            ),
            Align(
              alignment: Alignment.topRight,
              child: ConfettiWidget(
                confettiController: confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                emissionFrequency: 0.2,
                numberOfParticles: 50,
                maxBlastForce: 50,
                minBlastForce: 30,
                gravity: 0.2,
                colors: const [
                  Colors.red,
                  Colors.green,
                  Colors.blue,
                  Colors.orange,
                  Colors.pink,
                  Colors.purple
                ],
                shouldLoop: false,
              )
            ),

          ],
        ),
      ),
    );
  }


  Widget _infoChip(String label, String value) {
    return Chip(
      label: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      ),
      backgroundColor: label == "Gender"
          ? Colors.pink[100]
          : label == "Weight"
          ? Colors.red[100]
          : Colors.amber[100],
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: pet.id,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            child: Image.network(
              pet.imageUrl,
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: IconButton(
            icon: Icon(
              widget.pet.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: widget.pet.isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () {
              context.read<PetCubit>().toggleFavorite(widget.pet.id);
              setState(() {
                widget.pet.isFavorite = !widget.pet.isFavorite;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBottomDetails(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(pet.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Text('₹${pet.price}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Colors.grey),
              Text(" 1.6 km away", style: TextStyle(color: Colors.grey[600])),
            ],
          ),
          const SizedBox(height: 16),

          // Chips
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _infoChip("Age", pet.age.toString()),
              _infoChip("Gender", "Male"),
              _infoChip("Weight", "2.5Kg"),
            ],
          ),

          const SizedBox(height: 20),
          const Text("About", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          const Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit...kjh dfihsdgfuygsdufygusfgusudyfgausddyfguasfguasgfugsufgusdgfuasgfugufguasgfudysgfusgfugasuyfgudys",
            style: TextStyle(color: Colors.black87),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),

          // Slide to Adopt
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: !pet.isAdopted
                ? SlideAction(
              borderRadius: 12,
              elevation: 0,
              innerColor: Colors.white,
              outerColor: Theme.of(context).colorScheme.primary,
              sliderButtonIcon: const Icon(Icons.pets, color: Colors.purple),
              text: "Slide to Adopt",
              textStyle: const TextStyle(color: Colors.white, fontSize: 16),
              onSubmit: () {
                setState(() {
                  pet.isAdopted = true;
                });
                context.read<PetCubit>().adoptPet(pet.id);
                confettiController.play();

                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("🎉 You’ve Found a Forever Friend!"),
                    content: Text("You’ve adopted ${pet.name}. Thank you for giving them loving home! 🐶🐾"),
                    actions: [
                      ElevatedButton(onPressed: (){
                        Navigator.pop(ctx);
                      }, child: const Text("Yay!"))
                    ],
                  ),
                );
              },
            )
                : Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 8),
                  Text("Already Adopted", style: TextStyle(color: Colors.green)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }



}
