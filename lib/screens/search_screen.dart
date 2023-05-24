import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../compnents/app_bar.dart';
import '../compnents/nav_bar.dart';
import '../model/tourist_site.dart';
import '../compnents/cards/search_card.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/SearchScreen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String title = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('locations')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    if (title.isEmpty) {
                      return SearchCard(
                        touristSite: TouristSite(
                          id: snapshot.data!.docs[index].id,
                          title: data['title'],
                          description: data['description'],
                          imageUrl: data['image'],
                          category: List<String>.from(data['categories']),
                          added: data['time'].toDate(),
                          ratings: data['ratings'],
                        ),
                      );
                    }
                    if (data['title']
                        .toString()
                        .toLowerCase()
                        .startsWith(title.toLowerCase())) {
                      return SearchCard(
                        touristSite: TouristSite(
                          id: snapshot.data!.docs[index].id,
                          title: data['title'],
                          description: data['description'],
                          imageUrl: data['image'],
                          category: List<String>.from(data['categories']),
                          added: data['time'].toDate(),
                          ratings: data['ratings'],
                        ),
                      );
                    }
                    return Container();
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavBarComponent(selectedTab: NavigationItem.search),
    );
  }
}
