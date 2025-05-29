import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_guide/providers/destination_provider.dart';
import 'package:travel_guide/screens/home_screen.dart';
import 'package:travel_guide/screens/search_screen.dart';
import 'package:travel_guide/screens/favorites_screen.dart';
import 'package:travel_guide/screens/profile_screen.dart';
import 'package:travel_guide/widgets/bottom_nav_bar.dart';
import 'package:travel_guide/providers/theme_provider.dart';
import 'package:travel_guide/providers/language_provider.dart';
import 'package:travel_guide/screens/notification_screen.dart';
import 'package:travel_guide/screens/settings_screen.dart' as settings;
import 'package:travel_guide/screens/about_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: languageProvider.getText('home'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.search_outlined),
            selectedIcon: const Icon(Icons.search),
            label: languageProvider.getText('search'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.favorite_outline),
            selectedIcon: const Icon(Icons.favorite),
            label: languageProvider.getText('favorites'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: languageProvider.getText('profile'),
          ),
        ],
      ),
    );
  }
} 