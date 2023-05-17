import 'package:Hotspot/model/tourist_site.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import '../data/DUMMMY_DATA.dart';
import '../compnents/app_bar.dart';
import '../compnents/nav_bar.dart';
import '../compnents/cards/post.dart';

class HomePage extends StatefulWidget {
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
                stream: FirebaseFirestore.instance
                    .collection('locations')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  final locationDocs = snapshot.data!.docs;

                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: locationDocs.length,
                    itemBuilder: (context, index) {
                      return PostCard(
                        touristSites: TouristSite(
                          id: locationDocs[index].id,
                          title: locationDocs[index]['title'],
                          description: locationDocs[index]['description'],
                          imageUrl: locationDocs[index]['image'],
                          category: List<String>.from(
                              locationDocs[index]['categories']),
                          added: locationDocs[index]['time'].toDate(),
                        ),
                      );
                    },
                  );
                }),
          ],
        ),
      ),
      bottomNavigationBar: NavBarComponent(
        selectedTab: NavigationItem.home,
      ),
    );
  }
}
