import 'package:flutter/material.dart';
import 'package:my_super_cat_app/screens/cats/show_cats_screen.dart';
import 'package:my_super_cat_app/screens/favorites/favorites_screen.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cats'),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ShowCatsScreen(),
          FavoritesScreen()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabController.index,
        onTap: (index) {
          _tabController.animateTo(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Cats'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites'
          )
        ],
      ),
    );
  }
}