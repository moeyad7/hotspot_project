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
          return Column(
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
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('locations')
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

                    final locationDocs = snapshot.data!.docs;
                    List result = [];
                    List ids = [];
                    for (var i = 0; i < userDocs['saved'].length; i++) {
                      var currentId = userDocs['saved'][i];
                      for (var j = 0; j < locationDocs.length; j++) {
                        if (currentId == locationDocs[j].id) {
                          result.add(locationDocs[j].data());
                          ids.add(locationDocs[j]);
                        }
                      }
                    }

                    return Container(
                      height: 45,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: result.length,
                        itemBuilder: (context, index) {
                          return PostCard(
                            touristSites: TouristSite(
                              id: ids[index].id,
                              title: result[index]['title'],
                              description: result[index]['description'],
                              imageUrl: result[index]['image'],
                              category:
                                  List<String>.from(result[index]['categories']),
                              added: result[index]['time'].toDate(),
                              ratings: result[index]['ratings'],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: NavBarComponent(selectedTab: NavigationItem.profile),
    );
  }
}
