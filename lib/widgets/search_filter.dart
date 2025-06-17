import 'package:flutter/material.dart';
import '../models/pet.dart';

class SearchFilterBar extends StatefulWidget {
  final String selectedType;
  final double maxPrice;
  final bool showOnlyNotAdopted;
  final List<Pet> allPets;
  final Function({
  required String type,
  required double maxPrice,
  required bool showOnlyNotAdopted,
  }) onFilterChanged;

  const SearchFilterBar({
    super.key,
    required this.selectedType,
    required this.maxPrice,
    required this.showOnlyNotAdopted,
    required this.onFilterChanged,
    required this.allPets,
  });

  @override
  State<SearchFilterBar> createState() => _SearchFilterBarState();
}

class _SearchFilterBarState extends State<SearchFilterBar> {
  late String _type;
  late double _price;
  late bool _notAdoptedOnly;

  Set<String> typesSet = {'All'};
  late final List<Pet> allPets;

  void getPetCategories(){
    for(final pet in widget.allPets){
      typesSet.add(pet.category);
    }
  }

  @override
  void initState() {
    super.initState();
    getPetCategories();
    _type = widget.selectedType;
    _price = widget.maxPrice;
    _notAdoptedOnly = widget.showOnlyNotAdopted;
  }

  void _notifyChange() {
    widget.onFilterChanged(
      type: _type,
      maxPrice: _price,
      showOnlyNotAdopted: _notAdoptedOnly,
    );
  }

  @override
  Widget build(BuildContext context) {

    final List<String> types = typesSet.toList();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: kElevationToShadow[1],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Pet Type", style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),

          DropdownButtonFormField<String>(
            value: _type,
            items: types.map((type) {
              return DropdownMenuItem<String>(
                value: type,
                child: Text(type),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => _type = value);
                _notifyChange();
              }
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
          ),
          const SizedBox(height: 16),
          const Text("Maximum Price", style: TextStyle(fontWeight: FontWeight.w600)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("₹1000"),
              Text("₹${_price.toInt()}"),
              Text("₹20000"),
            ],
          ),
          Slider(
            value: _price,
            min: 1000,
            max: 20000,
            divisions: 19,
            label: '₹${_price.toInt()}',
            onChanged: (value) {
              setState(() => _price = value);
              _notifyChange();
            },
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Show Only Available",
                  style: TextStyle(fontWeight: FontWeight.w600)),
              Switch(
                value: _notAdoptedOnly,
                onChanged: (value) {
                  setState(() => _notAdoptedOnly = value);
                  _notifyChange();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
