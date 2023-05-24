import 'package:flutter/material.dart';
import 'package:Hotspot/model/tourist_site.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
    final fbm = FirebaseMessaging.instance;
    fbm.requestPermission();
  }

  List<String> _inactiveChips = [
    'Nature',
    'History',
    'Entertainment',
    'Food',
    'Adventure',
    'Religion',
    'Shopping',
    'Culture'
  ];
  List<String> _activeChips = [];

  Widget _buildChips() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: _inactiveChips
          .map((chip) => ChoiceChip(
                label: Text(
                  chip,
                  style: TextStyle(
                    color: _activeChips.contains(chip)
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                selected: _activeChips.contains(chip),
                onSelected: (selected) => _activateChip(selected, chip),
                selectedColor: Colors.blue,
                backgroundColor: _activeChips.contains(chip)
                    ? Color(0xFF228CE5).withOpacity(0.4)
                    : Color(0xFF228CE5).withOpacity(0.4),
              ))
          .toList(),
    );
  }

  void _activateChip(bool selected, String chip) {
    setState(() {
      if (selected) {
        _activeChips.add(chip);
      } else {
        _activeChips.remove(chip);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 30, top: 10, right: 30),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(children: [
                  Wrap(
                      spacing: 3.0,
                      // gap between adjacent chips
                      children: [_buildChips()]),
                ]),
              ),
            ),
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

                if (!snapshot.hasData || snapshot.data == null) {
                  // Stream has no data, show a message
                  return Center(
                    child: Text('No data available.'),
                  );
                }

                final locationDocs = snapshot.data!.docs;

                if (_activeChips.isEmpty) {
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
                          ratings: locationDocs[index]['ratings'],
                        ),
                      );
                    },
                  );
                }

                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: locationDocs.length,
                  itemBuilder: (context, index) {
                    for (var i = 0; i < _activeChips.length; i++) {
                      if (locationDocs[index]['categories']
                          .contains(_activeChips[i])) {
                        return PostCard(
                          touristSites: TouristSite(
                            id: locationDocs[index].id,
                            title: locationDocs[index]['title'],
                            description: locationDocs[index]['description'],
                            imageUrl: locationDocs[index]['image'],
                            category: List<String>.from(
                                locationDocs[index]['categories']),
                            added: locationDocs[index]['time'].toDate(),
                            ratings: locationDocs[index]['ratings'],
                          ),
                        );
                      }
                    }
                    return Container();
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
