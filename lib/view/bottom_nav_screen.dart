import 'package:flutter/material.dart';
import 'package:wallpaper_app/view/explore_screen.dart';
import 'package:wallpaper_app/view/home_screen.dart';
import 'package:wallpaper_app/view/profile_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 1;
  bool visible = true;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(),
          ExploreScreen(
            hideNavigation: hideNav,
            showNavigation: showNav,
          ),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: Duration(milliseconds: 1000),
        curve: Curves.fastLinearToSlowEaseIn,
        height: visible ? kBottomNavigationBarHeight : 0,
        child: Wrap(
          children: [
            BottomNavigationBar(
              currentIndex: _currentIndex, // Set the current tab index
              onTap: _onTabTapped, // Handle tab selection
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Explore',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void hideNav() {
    setState(() {
      visible = false;
    });
  }

  void showNav() {
    setState(() {
      visible = true;
    });
  }

  //
}
