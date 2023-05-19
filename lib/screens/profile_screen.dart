import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './saved_screen.dart';
import './visited_screen.dart';
import '../compnents/nav_bar.dart';
import '../compnents/app_bar.dart';
import './edit_profile_screen.dart';
import '../model/tourist_site.dart';
import '../compnents/cards/post.dart';
import '../compnents/buttons/buttons.dart';
import '../../screens/account_required.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/ProfileScreen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = true;
  var _userId;
  var _userName;
  var _userImage;
  var _saved;
  var _seen;
  var ratings;
  void isLoggedIn() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Future.delayed(Duration.zero, () {
        Navigator.of(context)
            .pushReplacementNamed(AccountRequiredScreen.routeName);
      });
    } else {
      getData();
    }
  }

  void getData() async {
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    setState(() {
      _userId = user.uid;
      _userName = userData['username'];
      _userImage = userData['image_url'];
      _saved = userData['saved'].length;
      _seen = userData['seen'].length;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context),
      body: isLoading == true
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 75,
                              backgroundColor: Colors.grey,
                              backgroundImage: NetworkImage(_userImage),
                            ),
                            SizedBox(height: 10),
                            Text(
                              _userName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Center(
                                child: Column(
                                  children: [
                                    Text(
                                      '169',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Comments',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              CustomButton(
                                name: 'Saved • ' + _saved.toString(),
                                color: Color(0xFFD9D9D9),
                                icon: Icons.bookmark,
                                iconColor: Color(0xFFF58A07),
                                pressFunction: () {
                                  Navigator.of(context)
                                      .pushNamed(SavedScreen.routeName);
                                },
                              ),
                              SizedBox(height: 10),
                              CustomButton(
                                name: 'Visited • ' + _seen.toString(),
                                color: Color(0xFFD9D9D9),
                                icon: Icons.check_circle,
                                iconColor: Color(0xFF2FC686),
                                pressFunction: () {
                                  Navigator.of(context)
                                      .pushNamed(VisitedScreen.routeName);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    CustomButton(
                      name: 'Edit Profile',
                      color: Color(0xFFD9D9D9),
                      icon: Icons.edit,
                      iconColor: Colors.black,
                      pressFunction: () {
                        Navigator.of(context)
                            .pushNamed(EditProfileScreen.routeName);
                      },
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Center(
                      child: Text(
                        'Your Posts',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    SizedBox(height: 10),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('locations')
                          .where('userId', isEqualTo: _userId)
                          .snapshots(),
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Text('No Posts Yet'),
                          );
                        }

                        final locationDocs = snapshot.data!.docs;
                        return Container(
                          height: 262,
                          child: ListView.builder(
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
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),]
            ),
      bottomNavigationBar: NavBarComponent(selectedTab: NavigationItem.profile),
    );
  }
}
