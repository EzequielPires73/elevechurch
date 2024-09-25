import 'package:elevechurch/layers/presentation/screens/bible/bible_page.dart';
import 'package:elevechurch/layers/presentation/screens/home/home_page.dart';
import 'package:elevechurch/layers/presentation/screens/prayers/prayers_page.dart';
import 'package:elevechurch/layers/presentation/screens/profile/profile_page.dart';
import 'package:elevechurch/layers/presentation/screens/radio/radio_page.dart';
import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int selectedIndex = 0;
  static const List<Widget> pages = [
    HomePage(),
    RadioPage(),
    PrayersPage(),
    BiblePage(),
    ProfilePage(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        indicatorColor: Colors.indigo,
        selectedIndex: selectedIndex,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            icon: Icon(Icons.home_outlined),
            label: 'Início',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.radio,
              color: Colors.white,
            ),
            icon: Icon(Icons.radio_outlined),
            label: 'Rádio',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.diversity_1,
              color: Colors.white,
            ),
            icon: Icon(Icons.diversity_1_outlined),
            label: 'Orações',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.book,
              color: Colors.white,
            ),
            icon: Icon(Icons.book_outlined),
            label: 'Bíblia',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
