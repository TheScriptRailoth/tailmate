// import 'package:flutter/material.dart';
//
// class CustomBottomNavBar extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onItemSelected;
//
//   const CustomBottomNavBar({
//     Key? key,
//     required this.selectedIndex,
//     required this.onItemSelected,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final primaryColor = Color(0xFF9188E5);
//
//     return Container(
//       margin: const EdgeInsets.all(16),
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(30),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             offset: Offset(0, 6),
//             blurRadius: 12,
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _buildNavItem(Icons.home, 0, primaryColor),
//           _buildNavItem(Icons.shopping_cart, 1, primaryColor),
//           _buildNavItem(Icons.favorite, 2, primaryColor),
//           _buildNavItem(Icons.settings, 3, primaryColor),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildNavItem(IconData icon, int index, Color activeColor) {
//     bool isSelected = selectedIndex == index;
//
//     return GestureDetector(
//       onTap: () => onItemSelected(index),
//       child: Container(
//         padding: const EdgeInsets.all(10),
//         decoration: isSelected
//             ? BoxDecoration(
//           color: activeColor.withOpacity(0.2),
//           shape: BoxShape.circle,
//         )
//             : null,
//         child: Icon(
//           icon,
//           color: isSelected ? activeColor : Colors.grey,
//           size: 28,
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0, left: 16, right: 16), // Reduced bottom padding
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(30),
          // Removed shadow
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(CupertinoIcons.home, 0, context),
            _buildNavItem(CupertinoIcons.suit_heart_fill, 1, context),
            _buildNavItem(CupertinoIcons.clock, 2, context),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, BuildContext context) {
    final isSelected = index == selectedIndex;

    return GestureDetector(
      onTap: () => onItemSelected(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          icon,
          size: isSelected ? 28 : 24,
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }
}

// class CustomBottomNavBar extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onItemSelected;
//
//   const CustomBottomNavBar({
//     Key? key,
//     required this.selectedIndex,
//     required this.onItemSelected,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 5.0, left: 16, right: 16),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.surface,
//           borderRadius: BorderRadius.circular(30),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 10,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _buildNavItem(CupertinoIcons.home, 0, context),
//             _buildNavItem(CupertinoIcons.suit_heart_fill, 1, context),
//             _buildNavItem(CupertinoIcons.clock, 2, context),
//
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNavItem(IconData icon, int index, BuildContext context) {
//     final isSelected = index == selectedIndex;
//
//     return GestureDetector(
//       onTap: () => onItemSelected(index),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 250),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         decoration: BoxDecoration(
//           color: isSelected
//               ? Theme.of(context).colorScheme.primary.withOpacity(0.15)
//               : Colors.transparent,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Icon(
//           icon,
//           size: isSelected ? 28 : 24,
//           color: isSelected
//               ? Theme.of(context).colorScheme.primary
//               : Theme.of(context).iconTheme.color,
//         ),
//       ),
//     );
//   }
// }
