import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:tailmate/widgets/navbar_widget.dart';
import 'drawer_screen.dart';
import 'favorite_page.dart';
import 'home_page.dart';
import 'favorite_page.dart';
import 'history_page.dart';
import '../repository/pet_repository.dart';

class MainNavigation extends StatefulWidget {
  final PetRepository repository;
  const MainNavigation({super.key, required this.repository});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}


class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  final ZoomDrawerController _zoomDrawerController = ZoomDrawerController();

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      HomePage(
        repository: widget.repository,
        toggleDrawer: () => _zoomDrawerController.toggle!(),
      ),
      const FavoritesPage(),
      const HistoryPage(),
    ]);
  }

  void _onItemSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: _zoomDrawerController,
      borderRadius: 24,
      angle: -8,
      style: DrawerStyle.style3,
      showShadow: true,
      menuBackgroundColor: Colors.grey.shade200,
      mainScreenTapClose: true,
      menuScreen: MenuScreen(onToggleTheme: () {}),
      mainScreen: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            // Animated page switching
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _pages[_selectedIndex],
            ),

            // Floating Bottom Navigation Bar
            Positioned(
              left: 0,
              right: 0,
              bottom: 24,
              child: Center(
                child: CustomBottomNavBar(
                  selectedIndex: _selectedIndex,
                  onItemSelected: _onItemSelected,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// class _MainNavigationState extends State<MainNavigation> {
//   int _selectedIndex = 0;
//
//   final ZoomDrawerController _zoomDrawerController = ZoomDrawerController();
//
//   void _onItemSelected(int index) {
//     setState(() => _selectedIndex = index);
//     _zoomDrawerController.toggle!();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ZoomDrawer(
//       controller: _zoomDrawerController,
//       borderRadius: 24,
//       angle: -8,
//       style: DrawerStyle.style3,
//       showShadow: true,
//       menuScreen: MenuScreen(onToggleTheme: () {  },),
//       mainScreen: getMainScreen(),
//       mainScreenTapClose: true,
//       menuBackgroundColor: Colors.grey.shade200,
//     );
//   }
//
//   Widget getMainScreen() {
//     return Scaffold(
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: [
//           HomePage(
//             repository: widget.repository,
//             toggleDrawer: () => _zoomDrawerController.toggle!(),
//           ),
//           const FavoritesPage(),
//           const HistoryPage(),
//         ],
//       ),
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       bottomNavigationBar: CustomBottomNavBar(selectedIndex: _selectedIndex, onItemSelected: (index) => setState(() => _selectedIndex = index))
//     );
//   }
//
// }



