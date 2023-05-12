import 'package:flutter/material.dart';

import '../data/DUMMMY_DATA.dart';
import '../compnents/app_bar.dart';
import '../compnents/nav_bar.dart';
import '../compnents/cards/post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = '/HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
//make it create a listview builder for the posts from the data in the dummy_data
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: touristSites.length,
              itemBuilder: (context, index) {
                return PostCard(
                  touristSites: touristSites[index],
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBarComponent(
        selectedTab: NavigationItem.home,
      ),
    );
  }
}
