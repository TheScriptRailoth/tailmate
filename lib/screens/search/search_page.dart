import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailmate/widgets/search_filter.dart';
import '../../cubits/pet_cubit.dart';
import '../../models/pet.dart';
import '../details_page.dart';


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
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        titleSpacing: 0,

          title: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Row(
              children: [
                Expanded(
                  child: Hero(
                    tag: 'searchHero',
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: theme.brightness == Brightness.dark
                              ? Colors.grey[800]
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search, color: Colors.grey),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                autofocus: true,
                                decoration: const InputDecoration.collapsed(
                                    hintText: "Search pets..."),
                                onChanged: _onSearchChanged,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    CupertinoIcons.slider_horizontal_3,
                    color: Colors.grey[600],
                  ),
                  onPressed: () => setState(() => showFilters = !showFilters),
                )
              ],
            ),
          )
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (showFilters)
              SearchFilterBar(
                selectedType: selectedType,
                maxPrice: maxPrice,
                showOnlyNotAdopted: showOnlyNotAdopted,
                onFilterChanged: _onFilterChanged,
                allPets: allPets,
              ),
            Expanded(
              child: filteredPets.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off,
                        size: 72, color: Colors.grey.shade500),
                    const SizedBox(height: 12),
                    Text(
                      "No pets found",
                      style: theme.textTheme.titleMedium
                          ?.copyWith(color: Colors.grey),
                    )
                  ],
                ),
              )
                  : ListView.builder(
                itemCount: filteredPets.length,
                itemBuilder: (context, index) {
                  final pet = filteredPets[index];
                  return ListTile(
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailsPage(pet: pet),
                          ),
                        );
                      });
                    },
                    leading: Hero(
                      tag: pet.id,
                      child: CircleAvatar(
                        radius: 26,
                        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                        backgroundImage: pet.imageBytes != null
                            ? MemoryImage(pet.imageBytes!)
                            : NetworkImage(pet.imageUrl) as ImageProvider,
                      ),
                    ),
                    title: Text(pet.name),
                    subtitle:
                    Text('Age: ${pet.age} • ₹${pet.price.toStringAsFixed(0)}'),
                    trailing: pet.isAdopted
                        ? const Text("Adopted",
                        style: TextStyle(color: Colors.grey))
                        : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
