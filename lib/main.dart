import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tailmate/models/pet.dart';
import 'package:tailmate/screens/splash_screen.dart';
import 'package:tailmate/utils/theme_notifier.dart';
import 'cubits/pet_cubit.dart';
import 'cubits/theme_cubit.dart';
import 'repository/pet_repository.dart';

final themeNotifier = ThemeNotifier();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PetAdapter());
  await Hive.openBox<Pet>('pets');
  runApp(
      const PetAdoptionApp()
  );
}

class PetAdoptionApp extends StatelessWidget {
  const PetAdoptionApp({super.key});

  @override
  Widget build(BuildContext context) {
    final PetRepository repository = PetRepository(baseUrl: 'https://tailmate-backend.vercel.app/');

    return MultiBlocProvider(
      providers: [
        BlocProvider<PetCubit>(
          create: (_) => PetCubit()..fetchAndCachePets(repository),
        ),
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'Pet Adoption App',
            themeMode: themeMode,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Color(0xFF9188E5),
                brightness: Brightness.light,
                background: Color(0xFFF7F7F7),
              ),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Color(0xFF9188E5),
                brightness: Brightness.dark,
                background: Color(0xFF121212),

              ),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
