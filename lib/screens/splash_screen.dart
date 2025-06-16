import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tailmate/repository/pet_repository.dart';
import 'package:tailmate/screens/main_navigation.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //late TextEditingController _controller;
  final PetRepository pet_repository = PetRepository(baseUrl: 'https://tailmate-backend.vercel.app/');
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => MainNavigation(repository: pet_repository)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const Center(
        child: Text(
          '🐾 TailMate',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
