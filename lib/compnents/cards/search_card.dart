import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/arguments.dart';
import '../../model/tourist_site.dart';
import '../../screens/post_details_screen.dart';

class SearchCard extends StatefulWidget {
  final TouristSite touristSite;

  SearchCard({
    required this.touristSite,
  });

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  var _seen = false;
  var _saved = false;

  var user = FirebaseAuth.instance.currentUser;
  var averageRating = 0.0;

  void getData() async {
    if (user != null) {
      try {
        final user_data = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();
        if (user_data['seen'] != null) {
          user_data['seen'].forEach((element) {
            if (element == widget.touristSite.id) {
              setState(() {
                _seen = true;
              });
            }
          });
        }

        if (user_data['saved'] != null) {
          user_data['saved'].forEach((element) {
            if (element == widget.touristSite.id) {
              setState(() {
                _saved = true;
              });
            }
          });
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    calculateAverageRating();
  }

  void calculateAverageRating() {
    // calculate the average rating from array ratings that contains a map for each rating of each user in the firebase

    FirebaseFirestore.instance
        .collection('locations')
        .doc(widget.touristSite.id)
        .get()
        .then((value) {
      var ratings = value['ratings'];
      var sum = 0.0;
      for (var i = 0; i < ratings.length; i++) {
        sum += ratings[i]['rating'];
      }
      setState(() {
        averageRating =
            (sum / ratings.length).isNaN ? 0.0 : (sum / ratings.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(PostDetail.routeName,
            arguments:
                Arguments(widget.touristSite, _seen, _saved, averageRating));
      },
      child: Card(
        color: Color(0xFFFDF5ED),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.touristSite.imageUrl),
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.touristSite.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.touristSite.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Wrap(
                    spacing: 8,
                    children: widget.touristSite.category
                        .map((category) => Chip(
                              label: Text(
                                category,
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.blue,
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
