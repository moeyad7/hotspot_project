import 'package:flutter/material.dart';

class NavBarComponent extends StatelessWidget {
  const NavBarComponent({super.key, required this.selectedTab});

  final NavigationItem selectedTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: ThemeData().colorScheme.primary,
      selectedItemColor: ThemeData().colorScheme.secondary,
      unselectedItemColor: ThemeData().colorScheme.tertiary,
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
          case NavigationItem.trending:
            Navigator.pushNamed(context, '/Trending');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.trending_up),
          label: 'Trending',
        ),
      ],
    );
  }
}

enum NavigationItem { home, search, add, profile, trending }
