import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../buttons/buttons.dart';
import '../../model/tourist_site.dart';
import '../../screens/post_details_screen.dart';

class PostCard extends StatefulWidget {
  final TouristSite touristSites;

  const PostCard({required this.touristSites});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  var _seen = false;
  var _saved = false;

  var user = FirebaseAuth.instance.currentUser;

  void getData() async {
    if (user != null) {
      try {
        final user_data = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();
        if (user_data['seen'] != null) {
          user_data['seen'].forEach((element) {
            if (element == widget.touristSites.id) {
              setState(() {
                _seen = true;
              });
            }
          });
        }

        if (user_data['saved'] != null) {
          user_data['saved'].forEach((element) {
            if (element == widget.touristSites.id) {
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
  }

  void addOrDeleteSeen() async {
    if (user != null) {
      if (!_seen) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .update({
          'seen': FieldValue.arrayRemove([widget.touristSites.id])
        });
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .update({
          'seen': FieldValue.arrayUnion([widget.touristSites.id])
        });
      }
    }
  }

  void addOrDeleteSaved() async {
    if (user != null) {
      if (!_saved) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .update({
          'saved': FieldValue.arrayRemove([widget.touristSites.id])
        });
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .update({
          'saved': FieldValue.arrayUnion([widget.touristSites.id])
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: ThemeData().colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              children: [
                Positioned.fill(
                  child: _buildImage(widget.touristSites.imageUrl),
                ),
                Positioned(
                  left: 8,
                  bottom: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.touristSites.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      widget.touristSites.rating != 0.0
                          ? RatingBar.builder(
                              initialRating: widget.touristSites.rating,
                              minRating: 0.5,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 30,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 1.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            )
                          : Container(),
                      Row(
                        children: widget.touristSites.category.map((tag) {
                          return Container(
                            margin: EdgeInsets.only(
                              left: 4,
                              right: 4,
                            ),
                            child: CustomButton(
                              name: tag,
                              color: ThemeData().colorScheme.primary,
                              type: 'chips',
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text(
                  widget.touristSites.description,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            _seen
                                ? Icons.check_circle_rounded
                                : Icons.check_circle_outline_rounded,
                            color: _seen ? Colors.green : null,
                          ),
                          onPressed: user != null
                              ? () {
                                  setState(() {
                                    _seen = !_seen;
                                  });
                                  addOrDeleteSeen();
                                }
                              : () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('You need to login first'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                        ),
                        IconButton(
                          icon: Icon(
                            _saved
                                ? Icons.bookmark
                                : Icons.bookmark_border_rounded,
                            color: _saved ? Colors.orange : null,
                          ),
                          onPressed: user != null
                              ? () {
                                  setState(() {
                                    _saved = !_saved;
                                  });
                                  addOrDeleteSaved();
                                }
                              : () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('You need to login first'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                        ),
                      ],
                    ),
                    CustomButton(
                      name: 'More',
                      color: ThemeData().colorScheme.tertiary,
                      type: 'elevated',
                      icon: Icons.zoom_out_map_rounded,
                      pressFunction: () {
                        Navigator.pushNamed(context, PostDetail.routeName,
                            arguments: widget.touristSites);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Center(
          child: Text(
            'Could not load image',
            style: TextStyle(color: Colors.grey),
          ),
        );
      },
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            color: Colors.grey[300],
          ),
        );
      },
    );
  }
}
