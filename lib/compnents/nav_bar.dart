import 'package:flutter/material.dart';

class NavBarComponent extends StatelessWidget {
  const NavBarComponent({super.key, required this.selectedTab});

  final NavigationItem selectedTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).colorScheme.primary,
      selectedItemColor: Theme.of(context).colorScheme.onSecondary,
      currentIndex: selectedTab.index,
      onTap: (int index) {
        final selectedTab = NavigationItem.values[index];
        switch (selectedTab) {
          case NavigationItem.home:
            Navigator.popAndPushNamed(context, '/HomePage');
            break;
          case NavigationItem.search:
            Navigator.popAndPushNamed(context, '/SearchPage');
            break;
          case NavigationItem.add:
            Navigator.popAndPushNamed(context, '/AddPage');
            break;
          case NavigationItem.profile:
            Navigator.popAndPushNamed(context, '/ProfileScreen');
            break;
          case NavigationItem.trending:
            Navigator.popAndPushNamed(context, '/Trending');
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
