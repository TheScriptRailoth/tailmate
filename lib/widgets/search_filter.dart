import 'package:flutter/material.dart';

class SearchFilterBar extends StatefulWidget {
  final Function({
  required String type,
  required double maxPrice,
  required bool showOnlyNotAdopted,
  }) onFilterChanged;

  const SearchFilterBar({super.key, required this.onFilterChanged});

  @override
  State<SearchFilterBar> createState() => _SearchFilterBarState();
}

class _SearchFilterBarState extends State<SearchFilterBar> {
  String selectedType = 'All';
  double maxPrice = 10000;
  bool showOnlyNotAdopted = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 8,
          alignment: WrapAlignment.start,
          children: [
            DropdownButton<String>(
              value: selectedType,
              items: ['All', 'Dog', 'Cat', 'Bird', 'Rabbit']
                  .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                  .toList(),
              onChanged: (val) {
                setState(() => selectedType = val!);
                widget.onFilterChanged(
                  type: selectedType,
                  maxPrice: maxPrice,
                  showOnlyNotAdopted: showOnlyNotAdopted,
                );
              },
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Max ₹"),
                Slider(
                  value: maxPrice,
                  min: 0,
                  max: 10000,
                  divisions: 20,
                  label: maxPrice.round().toString(),
                  onChanged: (value) {
                    setState(() => maxPrice = value);
                    widget.onFilterChanged(
                      type: selectedType,
                      maxPrice: maxPrice,
                      showOnlyNotAdopted: showOnlyNotAdopted,
                    );
                  },
                ),
              ],
            ),
            FilterChip(
              label: const Text("Not Adopted"),
              selected: showOnlyNotAdopted,
              onSelected: (val) {
                setState(() => showOnlyNotAdopted = val);
                widget.onFilterChanged(
                  type: selectedType,
                  maxPrice: maxPrice,
                  showOnlyNotAdopted: showOnlyNotAdopted,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
