// import 'package:flutter/material.dart';
//
// class DrawerScreen extends StatelessWidget {
//   final Function(String) onItemSelected;
//
//   const DrawerScreen({super.key, required this.onItemSelected});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.teal.shade700,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const CircleAvatar(radius: 40, backgroundImage: NetworkImage('https://i.pravatar.cc/150')),
//               const SizedBox(height: 12),
//               const Text("Ashutosh Mishra", style: TextStyle(color: Colors.white, fontSize: 20)),
//               const SizedBox(height: 40),
//               drawerItem(Icons.home, 'Home'),
//               drawerItem(Icons.favorite, 'Favorites'),
//               drawerItem(Icons.pets, 'Adoption Requests'),
//               const Spacer(),
//               drawerItem(Icons.logout, 'Logout'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget drawerItem(IconData icon, String title) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.white),
//       title: Text(title, style: const TextStyle(color: Colors.white)),
//       onTap: () => onItemSelected(title),
//     );
//   }
// }

// import 'package:flutter/material.dart';
//
// class MenuScreen extends StatelessWidget {
//   final void Function(int) onItemSelected;
//
//   const MenuScreen({Key? key, required this.onItemSelected}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Drawer(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const DrawerHeader(
//               child: Text("TailMate", style: TextStyle(fontSize: 24, color: Colors.teal)),
//             ),
//             ListTile(
//               leading: Icon(Icons.home),
//               title: Text("Home"),
//               onTap: () => onItemSelected(0),
//             ),
//             ListTile(
//               leading: Icon(Icons.favorite),
//               title: Text("Favorites"),
//               onTap: () => onItemSelected(1),
//             ),
//             ListTile(
//               leading: Icon(Icons.history),
//               title: Text("History"),
//               onTap: () => onItemSelected(2),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const MenuScreen({Key? key, required this.onToggleTheme}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=3"),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Welcome 👋",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "TailMate User",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Divider(color: Colors.grey.shade300),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Dark Theme", style: TextStyle(fontSize: 16)),
                      Switch.adaptive(
                        value: isDark,
                        onChanged: (val) {
                          setState(() => isDark = val);
                          widget.onToggleTheme();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.info_outline),
                    title: const Text("About Us"),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("TailMate – Pet Adoption Made Easy!")),
                      );
                    },
                  ),
                  const SizedBox(height: 100),
                  Center(
                    child: Text(
                      "v1.0.0 © TailMate",
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
