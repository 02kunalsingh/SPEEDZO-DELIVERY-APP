import 'package:flutter/material.dart';
import 'package:k/screens/Home/home.dart';
import 'package:k/screens/Order.dart/Order.dart';
import 'package:k/screens/Profile/Profile.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomNavigatorScreen extends StatelessWidget {
  final List<Widget> _screens = [
    const HomeScreen(),
    const Order(),
    const Profile(),
  ];

  BottomNavigatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: PersistentTabController(initialIndex: 0),
      screens: _screens,
      items: [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: 'Home',
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.shopping_cart),
          title: 'Order',
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          title: 'Profile',
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
        ),
      ],
    );
  }
}
