import 'package:flutter/material.dart';
import 'search_page.dart';

PageRouteBuilder createSearchRoute() {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 350),
    pageBuilder: (_, __, ___) => const SearchPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        child: child,
      );
    },
  );
}

Widget flightBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection direction,
    BuildContext fromContext,
    BuildContext toContext,
    ) {
  return Material(
    color: Colors.transparent,
    child: fromContext.widget,
  );
}
