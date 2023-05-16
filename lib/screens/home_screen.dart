import 'package:Hotspot/data/DUMMMY_DATA.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import '../data/DUMMMY_DATA.dart';
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
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('locations').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final locationDocs = snapshot.data!.docs;

                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: locationDocs.length,
                  itemBuilder: (context, index) {
                    return PostCard(
                      touristSites: touristSites[index],
                    );
                  },
                );
              }
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
