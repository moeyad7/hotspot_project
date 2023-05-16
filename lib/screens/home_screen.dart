import 'package:Hotspot/model/tourist_site.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../compnents/app_bar.dart';
import '../compnents/cards/post.dart';
import '../compnents/nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/HomePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance.collection('locations').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData || snapshot.data == null) {
                  // Stream has no data, show a message
                  return Center(
                    child: Text('No data available.'),
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
                        title: locationDocs[index]['title'],
                        description: locationDocs[index]['description'],
                        imageUrl: locationDocs[index]['image'],
                        category: List<String>.from(locationDocs[index]['categories']),
                        added: locationDocs[index]['time'].toDate(),
                      ),
                    );
                  },
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