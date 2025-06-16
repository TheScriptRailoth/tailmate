import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailmate/widgets/search_filter.dart';
import 'package:tailmate/screens/search/search_route.dart';
import '../../cubits/pet_cubit.dart';
import '../../models/pet.dart';
import '../details_page.dart';
//
// class SearchPage extends StatefulWidget {
//   const SearchPage({super.key});
//
//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }
//
// class _SearchPageState extends State<SearchPage> {
//   final TextEditingController _controller = TextEditingController();
//   Timer? _debounce;
//   List<Pet> _filteredPets = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _controller.addListener(_onSearchChanged);
//   }
//
//   void _onSearchChanged() {
//     if (_debounce?.isActive ?? false) _debounce!.cancel();
//
//     _debounce = Timer(const Duration(milliseconds: 300), () {
//       final query = _controller.text.toLowerCase().trim();
//       final allPets = context.read<PetCubit>().state;
//
//       if (query.isEmpty) {
//         setState(() => _filteredPets = []);
//       } else {
//         setState(() {
//           _filteredPets = allPets.where(
//                 (pet) => pet.name.toLowerCase().contains(query),
//           ).toList();
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _debounce?.cancel();
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(kToolbarHeight),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Hero(
//               tag: 'searchHero',
//               flightShuttleBuilder: flightBuilder,
//               child: Material(
//                 color: Colors.transparent,
//                 child: Container(
//                   height: kToolbarHeight - 12,
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   alignment: Alignment.centerLeft,
//                   child: TextField(
//                     controller: _controller,
//                     autofocus: true,
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       hintText: 'Search pets...',
//                     ),
//                     onChanged: (query) {
//                       // Handle filtering logic here
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       // appBar: AppBar(
//       //   title: TextField(
//       //     controller: _controller,
//       //     autofocus: true,
//       //     decoration: const InputDecoration(
//       //       hintText: 'Search pets by name...',
//       //       border: InputBorder.none,
//       //     ),
//       //   ),
//       //   backgroundColor: theme.scaffoldBackgroundColor,
//       // ),
//       body: _filteredPets.isEmpty
//           ? const Center(child: Text("No matching pets found"))
//           : ListView.builder(
//         itemCount: _filteredPets.length,
//         itemBuilder: (context, index) {
//           final pet = _filteredPets[index];
//           return ListTile(
//             leading: CircleAvatar(backgroundImage: NetworkImage(pet.imageUrl)),
//             title: Text(pet.name),
//             subtitle: Text("₹${pet.price} • Age: ${pet.age}"),
//             onTap: () {
//               Navigator.push(context, MaterialPageRoute(
//                 builder: (_) => DetailsPage(pet: pet),
//               ));
//             },
//           );
//         },
//       ),
//     );
//   }
// }



class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = '';
  List<Pet> allPets = [];
  List<Pet> filteredPets = [];
  bool showFilters = false;

  String selectedType = 'All';
  double maxPrice = 10000;
  bool showOnlyNotAdopted = false;

  @override
  void initState() {
    super.initState();
    allPets = context.read<PetCubit>().state;
    filteredPets = allPets;
  }

  void _filterPets() {
    setState(() {
      filteredPets = allPets.where((pet) {
        final matchesQuery = pet.name.toLowerCase().contains(query.toLowerCase());
        final matchesType = selectedType == 'All' || pet.category == selectedType;
        final matchesPrice = pet.price <= maxPrice;
        final matchesAdoption = !showOnlyNotAdopted || !pet.isAdopted;

        return matchesQuery && matchesType && matchesPrice && matchesAdoption;
      }).toList();
    });
  }

  void _onSearchChanged(String text) {
    query = text;
    _filterPets();
  }

  void _onFilterChanged({
    required String type,
    required double maxPrice,
    required bool showOnlyNotAdopted,
  }) {
    selectedType = type;
    this.maxPrice = maxPrice;
    this.showOnlyNotAdopted = showOnlyNotAdopted;
    _filterPets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'searchHero',
          child: Material(
            color: Colors.transparent,
            child: Container(
              height: kToolbarHeight - 6,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      decoration: const InputDecoration.collapsed(hintText: "Search pets..."),
                      onChanged: _onSearchChanged,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_alt_outlined),
                    onPressed: () => setState(() => showFilters = !showFilters),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          if (showFilters)
            SearchFilterBar(onFilterChanged: _onFilterChanged),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPets.length,
              itemBuilder: (context, index) {
                final pet = filteredPets[index];
                return ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage(pet.imageUrl)),
                  title: Text(pet.name),
                  subtitle: Text('Age: ${pet.age} • ₹${pet.price}'),
                  trailing: pet.isAdopted
                      ? const Text("Adopted", style: TextStyle(color: Colors.grey))
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

