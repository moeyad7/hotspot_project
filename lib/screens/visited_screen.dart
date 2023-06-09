// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../compnents/app_bar.dart';
import '../compnents/nav_bar.dart';
import '../model/tourist_site.dart';
import '../compnents/cards/post.dart';

class VisitedScreen extends StatefulWidget {
  static const routeName = '/VisitedScreen';

  @override
  State<VisitedScreen> createState() => _VisitedScreenState();
}

class _VisitedScreenState extends State<VisitedScreen> {
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
                        Icons.check_circle,
                        color: Color(0xFF2FC686),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Visited • " + userDocs["seen"].length.toString(),
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
                      for (var i = 0; i < userDocs['seen'].length; i++) {
                        var currentId = userDocs['seen'][i];
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
                                category: List<String>.from(
                                    result[index]['categories']),
                                added: result[index]['time'].toDate(),
                                ratings: result[index]['ratings'],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          }),
      bottomNavigationBar: NavBarComponent(selectedTab: NavigationItem.profile),
    );
  }
}
