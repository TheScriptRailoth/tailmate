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
    final primaryColor = Color(0xFF9188E5);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 6),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 0, primaryColor),
          _buildNavItem(Icons.shopping_cart, 1, primaryColor),
          _buildNavItem(Icons.favorite, 2, primaryColor),
          _buildNavItem(Icons.settings, 3, primaryColor),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, Color activeColor) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onItemSelected(index),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: isSelected
            ? BoxDecoration(
          color: activeColor.withOpacity(0.2),
          shape: BoxShape.circle,
        )
            : null,
        child: Icon(
          icon,
          color: isSelected ? activeColor : Colors.grey,
          size: 28,
        ),
      ),
    );
  }
}
