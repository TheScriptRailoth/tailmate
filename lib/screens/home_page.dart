import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:tailmate/screens/details_page.dart';
import 'package:tailmate/screens/search/search_route.dart';
import 'package:tailmate/widgets/pet_tile.dart';
import '../cubits/pet_cubit.dart';
import '../models/pet.dart';
import '../repository/pet_repository.dart';
import '../widgets/category_clip.dart';

class HomePage extends StatefulWidget {
  final PetRepository repository;
  const HomePage({Key? key, required this.repository}) : super(key: key);

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
      if(box.isNotEmpty){
        petCubit.loadPets(box.values.toList());
      }else{
        final pets = await widget.repository.fetchPetsFromApi();
        petCubit.loadPets(pets);
      }

    } catch (e) {
      debugPrint('Error fetching pets: $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to load pets')));
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
    } catch (e) {
      debugPrint('Error refreshing pets: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to refresh pets')),
      );
    }
  }

  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xffF7F7F7),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.grid_view_rounded, color: Colors.black,)),
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
                  height: kToolbarHeight - 12,
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
        child: Expanded(
          child: BlocBuilder<PetCubit, List<Pet>>(
            builder: (context, pets) {
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
                          imageUrl: "https://cdn-icons-png.flaticon.com/512/616/616408.png",
                          isSelected: selectedCategory == "Dogs",
                          onTap: () => setState(() => selectedCategory = "Dogs"),
                        ),
                        CategoryChip(
                          label: "Cats",
                          imageUrl: "https://cdn-icons-png.flaticon.com/512/616/616408.png",
                          isSelected: selectedCategory == "Cats",
                          onTap: () => setState(() => selectedCategory = "Cats"),
                        ),
                        CategoryChip(
                          label: "Birds",
                          imageUrl: "https://cdn-icons-png.flaticon.com/512/616/616554.png",
                          isSelected: selectedCategory == "Birds",
                          onTap: () => setState(() => selectedCategory = "Birds"),
                        ),
                        CategoryChip(
                          label: "Birds",
                          imageUrl: "https://cdn-icons-png.flaticon.com/512/616/616554.png",
                          isSelected: selectedCategory == "Birds",
                          onTap: () => setState(() => selectedCategory = "Birds"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: pets.length,
                    itemBuilder: (context, index) {
                      return buildPetTile(pets[index], context);
                    },
                  )

                ],
              );

              // return ListView.builder(
              //   itemCount: pets.length,
              //   itemBuilder: (context, index) {
              //     final pet = pets[index];
              //     return ListTile(
              //       onTap: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(builder: (_) => DetailsPage(pet: pet)),
              //         );
              //       },
              //       leading: Hero(
              //         tag: pet.id,
              //         child: CircleAvatar(backgroundImage: NetworkImage(pet.imageUrl)),
              //       ),
              //       title: Text(pet.name),
              //       subtitle: Text('Age: ${pet.age}, ₹${pet.price}'),
              //       trailing: Row(
              //         mainAxisSize: MainAxisSize.min,
              //         children: [
              //           IconButton(
              //             icon: Icon(
              //               pet.isFavorite ? Icons.favorite : Icons.favorite_border,
              //               color: pet.isFavorite ? Colors.red : null,
              //             ),
              //             onPressed: () => context.read<PetCubit>().toggleFavorite(pet.id),
              //           ),
              //           pet.isAdopted
              //               ? const Text("Adopted", style: TextStyle(color: Colors.grey))
              //               : ElevatedButton(
              //             onPressed: () {
              //               context.read<PetCubit>().adoptPet(pet.id);
              //               ScaffoldMessenger.of(context).showSnackBar(
              //                 SnackBar(content: Text("You’ve now adopted ${pet.name}")),
              //               );
              //             },
              //             child: const Text('Adopt Me'),
              //           ),
              //         ],
              //       ),
              //     );
              //   },
              // );
            },
          ),
        ),
      ),
      //     : RefreshIndicator(
      //   onRefresh: _refreshPetsFromApi,
      //   child: BlocBuilder<PetCubit, List<Pet>>(
      //     builder: (context, pets) {
      //       if (pets.isEmpty) return const Center(child: Text('No pets found'));
      //
      //       return ListView.builder(
      //
      //         itemCount: pets.length,
      //         itemBuilder: (context, index) {
      //           final pet = pets[index];
      //           return ListTile(
      //             onTap: (){
      //               Navigator.push(context, MaterialPageRoute(builder: (_)=> DetailsPage(pet: pet,),),);
      //             },
      //             leading: Hero(
      //               tag: pet.id,
      //               child: CircleAvatar(
      //                 backgroundImage: NetworkImage(pet.imageUrl),
      //               ),
      //             ),
      //             title: Text(pet.name),
      //             subtitle: Text('Age: ${pet.age}, ₹${pet.price}'),
      //             trailing: Row(
      //               mainAxisSize: MainAxisSize.min,
      //               children: [
      //                 IconButton(
      //                   icon: Icon(
      //                     pet.isFavorite ? Icons.favorite : Icons.favorite_border,
      //                     color: pet.isFavorite ? Colors.red : null,
      //                   ),
      //                   onPressed: () => context.read<PetCubit>().toggleFavorite(pet.id),
      //                 ),
      //                 pet.isAdopted
      //                     ? const Text("Adopted", style: TextStyle(color: Colors.grey))
      //                     : ElevatedButton(
      //                   onPressed: () {
      //                     context.read<PetCubit>().adoptPet(pet.id);
      //                     ScaffoldMessenger.of(context).showSnackBar(
      //                       SnackBar(content: Text("You’ve now adopted ${pet.name}")),
      //                     );
      //                   },
      //                   child: const Text('Adopt Me'),
      //                 ),
      //               ],
      //             ),
      //           );
      //         },
      //       );
      //     },
      //   ),
      // ),
    );
  }
}



