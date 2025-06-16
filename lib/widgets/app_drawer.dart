import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  final Function(String) onItemTap;
  final bool isDarkMode;
  final VoidCallback toggleDarkMode;

  const DrawerScreen({
    super.key,
    required this.onItemTap,
    required this.isDarkMode,
    required this.toggleDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff9188E5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
              ),
              const SizedBox(height: 16),
              const Text('Ashutosh Mishra',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              const Text('@thescriptrailoth', style: TextStyle(color: Colors.white70)),

              const SizedBox(height: 30),
              drawerItem('Home', Icons.home, onItemTap),
              drawerItem('Favorites', Icons.favorite, onItemTap),
              drawerItem('Adopted Pets', Icons.pets, onItemTap),
              drawerItem('Settings', Icons.settings, onItemTap),
              drawerItem('About Us', Icons.info_outline, onItemTap),

              const Spacer(),

              Row(
                children: [
                  Icon(Icons.dark_mode, color: Colors.white),
                  const SizedBox(width: 10),
                  Text('Dark Mode', style: TextStyle(color: Colors.white)),
                  const Spacer(),
                  Switch(
                    value: isDarkMode,
                    onChanged: (_) => toggleDarkMode(),
                    activeColor: Colors.white,
                  )
                ],
              ),
              const SizedBox(height: 12),
              drawerItem('Logout', Icons.logout, onItemTap),
            ],
          ),
        ),
      ),
    );
  }

  Widget drawerItem(String label, IconData icon, Function(String) onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(label, style: TextStyle(color: Colors.white)),
      onTap: () => onTap(label),
    );
  }
}
