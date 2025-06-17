import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:confetti/confetti.dart';
import '../cubits/pet_cubit.dart';
import '../models/pet.dart';
import 'details_page.dart';
import 'dart:math';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Adoption History",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        //foregroundColor: colorScheme.onPrimary,
        elevation: 0,
      ),
      body: BlocBuilder<PetCubit, List<Pet>>(
        builder: (context, pets) {
          final adoptedPets = pets.where((pet) => pet.isAdopted).toList().reversed.toList();

          if (adoptedPets.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history_toggle_off, size: 80, color: colorScheme.primary.withOpacity(0.3)),
                  const SizedBox(height: 16),
                  Text(
                    'No pets adopted yet',
                    style: TextStyle(
                      fontSize: 16,
                      color: colorScheme.onBackground.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            );
          }

          // Trigger confetti only once on first adoption
          if (adoptedPets.length == 1) {
            _confettiController.play();
          }

          return Stack(
            children: [
              ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                itemCount: adoptedPets.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        "You've adopted ${adoptedPets.length} pet${adoptedPets.length > 1 ? 's' : ''} ❤️",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    );
                  }

                  final pet = adoptedPets[index - 1];
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(_createPetRoute(pet)),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      color: colorScheme.surface,
                      elevation: 3,
                      shadowColor: colorScheme.shadow.withOpacity(0.2),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: Hero(
                          tag: 'petImage_${pet.id}',
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: colorScheme.primary.withOpacity(0.2),
                            backgroundImage: pet.imageBytes != null
                                ? MemoryImage(pet.imageBytes!)
                                : NetworkImage(pet.imageUrl) as ImageProvider,
                          ),
                        ),
                        title: Text(
                          pet.name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        subtitle: Text(
                          'Age: ${pet.age} • ₹${pet.price}',
                          style: TextStyle(
                            color: colorScheme.onSurface.withOpacity(0.6),
                            fontSize: 13.5,
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right_rounded),
                      ),
                    ),
                  );
                },
              ),

              // Confetti animation
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirection: pi / 2,
                  emissionFrequency: 0.05,
                  numberOfParticles: 30,
                  gravity: 0.1,
                  colors: [
                    colorScheme.primary,
                    Colors.green,
                    Colors.pink,
                    Colors.orange,
                    Colors.blue,
                  ],
                ),
              ),
            ],
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
