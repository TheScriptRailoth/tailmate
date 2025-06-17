import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:tailmate/screens/search/search_route.dart';
import 'package:tailmate/widgets/pet_tile.dart';
import '../cubits/pet_cubit.dart';
import '../models/pet.dart';
import '../repository/pet_repository.dart';
import '../widgets/category_clip.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final PetRepository repository;
  final VoidCallback toggleDrawer;

  const HomePage({Key? key, required this.repository, required this.toggleDrawer}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPets();
    context.read<PetCubit>().fetchAndCachePets(widget.repository);
  }

  Future<void> _fetchPets() async {
    final petCubit = context.read<PetCubit>();
    final box = Hive.box<Pet>('pets');

    try {
      if (box.isNotEmpty) {
        petCubit.loadPets(box.values.toList());
      } else {
        final pets = await widget.repository.fetchPetsFromApi();

        for (final pet in pets) {
          try {
            final response = await http.get(Uri.parse(pet.imageUrl));
            if (response.statusCode == 200) {
              pet.imageBytes = response.bodyBytes;
            }
          } catch (e) {
            debugPrint('Image download failed for ${pet.name}: $e');
          }
          await box.put(pet.id, pet);
        }

        petCubit.loadPets(pets);
      }
    } catch (e) {
      debugPrint('Error fetching pets: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load pets')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _refreshPetsFromApi() async {
    final petCubit = context.read<PetCubit>();
    final box = Hive.box<Pet>('pets');

    try {
      final pets = await widget.repository.fetchPetsFromApi(forceRefresh: true);

      await box.clear();
      for (final pet in pets) {
        box.put(pet.id, pet);
      }
      petCubit.loadPets(pets);

      for (final pet in pets) {
        _cachePetImage(pet, box);
      }

    } catch (e) {
      debugPrint('Error refreshing pets: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to refresh pets')),
      );
    }
  }

// Background image caching
  Future<void> _cachePetImage(Pet pet, Box<Pet> box) async {
    try {
      final response = await http.get(Uri.parse(pet.imageUrl));
      if (response.statusCode == 200) {
        pet.imageBytes = response.bodyBytes;
        await box.put(pet.id, pet); // Update Hive with imageBytes
      }
    } catch (e) {
      print('Error caching image for ${pet.name}: $e');
    }
  }

  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(onPressed: widget.toggleDrawer, icon: Icon(Icons.grid_view_rounded, color: Color(0xff9188E5),)),
        title: Row(
          children: [
            Text("Welcome", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(createSearchRoute());
            },
            child: Hero(
              tag: 'searchHero',
              flightShuttleBuilder: flightBuilder,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  height: 44,
                  width: 160,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.centerLeft,
                  child: const Icon(Icons.search, color: Colors.black),
                ),
              ),
            ),
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: _refreshPetsFromApi,
        child: BlocBuilder<PetCubit, List<Pet>>(
          builder: (context, pets) {

            final filteredPets = selectedCategory == "All"
                ? pets
                : pets.where((pet) => pet.category.toLowerCase() == selectedCategory.toLowerCase()).toList();

            if (pets.isEmpty) return const Center(child: Text('No pets found'));
            return ListView(
              padding: const EdgeInsets.only(left: 20, top: 20),
              children: [
                Text('Pet Category',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                const SizedBox(height: 12),
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(right: 16),
                    children: [
                      CategoryChip(
                        label: "Dogs",
                        emoji: "🐶",
                        isSelected: selectedCategory == "Dog",
                        onTap: () => setState(() {
                          selectedCategory = selectedCategory == "Dog" ? "All" : "Dog";
                        }),
                      ),
                      CategoryChip(
                        label: "Cats",
                        emoji: "🐱",
                        isSelected: selectedCategory == "Cat",
                        onTap: () => setState((){
                          selectedCategory = selectedCategory == "Cat" ? "All" : "Cat";
                        }),
                      ),
                      CategoryChip(
                        label: "Birds",
                        emoji: "🐦",
                        isSelected: selectedCategory == "Bird",
                        onTap: () => setState(() {
                          selectedCategory = selectedCategory == "Bird" ? "All" : "Bird";
                        }),
                      ),
                      CategoryChip(
                        label: "Rabbits",
                        emoji: "🐰",
                        isSelected: selectedCategory == "Rabbit",
                        onTap: () => setState(() {
                          selectedCategory = selectedCategory == "Rabbit" ? "All" : "Rabbit";
                        }),
                      ),
                      CategoryChip(
                        label: "Turtle",
                        emoji: "🐢",
                        isSelected: selectedCategory == "Rabbit",
                        onTap: () => setState(() {
                          selectedCategory = selectedCategory == "Rabbit" ? "All" : "Rabbit";
                        }),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                GridView.builder(
                  padding: const EdgeInsets.only(right: 16, top: 16, bottom: 16),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.72,
                  ),
                  itemCount: filteredPets.length,
                  itemBuilder: (context, index) => buildPetTile(filteredPets[index], context),
                ),
                SizedBox(height: 70,)
              ],
            );
            },
        ),
      ),
    );
  }
}



