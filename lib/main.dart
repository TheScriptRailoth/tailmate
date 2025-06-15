import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tailmate/models/pet.dart';
import 'package:tailmate/screens/navbar.dart';
import 'package:tailmate/screens/splash_screen.dart';
import 'cubits/pet_cubit.dart';
import 'repository/pet_repository.dart';
import 'screens/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PetAdapter());
  await Hive.openBox<Pet>('pets');
  runApp(const PetAdoptionApp());
}

class PetAdoptionApp extends StatelessWidget {
  const PetAdoptionApp({super.key});

  @override
  Widget build(BuildContext context) {
    final PetRepository repository = PetRepository(baseUrl: 'https://tailmate-backend.vercel.app/');

    return MultiBlocProvider(
      providers: [
        BlocProvider<PetCubit>(create: (_) => PetCubit()),
      ],
      child: MaterialApp(
        title: 'Pet Adoption App',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.teal,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.teal,
        ),
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
