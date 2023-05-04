import 'package:flutter/material.dart';
import '../theme_data.dart';

class NavBarComponent extends StatelessWidget {
  const NavBarComponent({super.key, required this.selectedTab});

  final NavigationItem selectedTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: ThemeData().colorScheme.primary,
      selectedItemColor: ThemeData().colorScheme.secondary,
      unselectedItemColor: ThemeData().colorScheme.surface,
      currentIndex: selectedTab.index,
      onTap: (int index) {
        final selectedTab = NavigationItem.values[index];
        switch (selectedTab) {
          case NavigationItem.home:
            Navigator.pushNamed(context, '/HomePage');
            break;
          case NavigationItem.search:
            Navigator.pushNamed(context, '/SearchPage');
            break;
          case NavigationItem.add:
            Navigator.pushNamed(context, '/AddPage');
            break;
          case NavigationItem.profile:
            Navigator.pushNamed(context, '/ProfilePage');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book),
          label: 'Courses',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'School Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.wallet),
          label: 'Wallet',
        ),
      ],
    );
  }
}

enum NavigationItem { home, search, add, profile }
