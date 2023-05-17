// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../compnents/app_bar.dart';
import '../compnents/nav_bar.dart';
import '../compnents/cards/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/tourist_site.dart';

class SavedScreen extends StatefulWidget {
  static const routeName = '/SavedScreen';

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
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
            final userDocs = snapshot.data!;
            print(userDocs["saved"]);
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.bookmark,
                          color: Color(0xFFF58A07),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Saved • " + userDocs["saved"].length.toString(),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 2,
                  ),
                  //  userDocs["saved"].map<PostCard>((postId) async {
                  //   final locationDocs = await FirebaseFirestore.instance
                  //       .collection("locations")
                  //       .doc(postId)
                  //       .get();
                  //       print(locationDocs["title"]);
                  //   return FutureBuilder (
                  //     future: locationDocs ,
                  //     builder:((BuildContext context, snapshot) {
                  //       PostCard(
                  //       touristSites: TouristSite(
                  //         id: locationDocs.id,
                  //         title: locationDocs['title'],
                  //         description: locationDocs['description'],
                  //         imageUrl: locationDocs['image'],
                  //         category: List<String>.from(locationDocs['categories']),
                  //         added: locationDocs['time'].toDate(),
                  //       ),
                  //     );
                  //     } ) 
                  //   );
                  // }).toList(),
                ],
              ),
            );
          }),
      bottomNavigationBar: NavBarComponent(selectedTab: NavigationItem.profile),
    );
  }
}
