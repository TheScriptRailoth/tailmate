import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/search/search_route.dart';
import 'package:flutter/material.dart';
import '../screens/search/search_route.dart';

class SearchBarHero extends StatelessWidget {
  const SearchBarHero({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.centerLeft,
            child: const Icon(Icons.search, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
