
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../model/arguments.dart';
import '../compnents/app_bar.dart';
import '../compnents/buttons/buttons.dart';
import '../compnents/rating/star_rating.dart';

class PostDetail extends StatefulWidget {
  static const routeName = '/post-detail';

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  bool _isVisible = false;
  var user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  Widget _buildImage(String imageUrl) {
    return Image.network(
      imageUrl,
      width: double.infinity,
      fit: BoxFit.fitWidth,
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

  Widget _buildTitle(String title) {
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
    );
  }

  Widget _buildRating(List<dynamic> touristSiteList, String touristSiteId) {
    double oldRating = getUserRating(touristSiteList);
    return AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        child: Column(
          children: [
            Text(
              "Your Rating",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            RatingBar.builder(
              initialRating: oldRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 30,
              itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
              itemBuilder: (context, _) => Icon(
                Icons.star_rounded,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                if (oldRating != rating) {
                  FirebaseFirestore.instance
                      .collection('locations')
                      .doc(touristSiteId)
                      .update({
                    'ratings': FieldValue.arrayRemove([
                      {'user_id': user!.uid, 'rating': oldRating}
                    ])
                  });
                  FirebaseFirestore.instance
                      .collection('locations')
                      .doc(touristSiteId)
                      .update({
                    'ratings': FieldValue.arrayUnion([
                      {'user_id': user!.uid, 'rating': rating}
                    ])
                  });
                  oldRating = rating;
                }
              },
            ),
          ],
        ));
  }

  double getUserRating(List<dynamic> touristSitelist) {
    double oldRating = 0;
    if (touristSitelist.length == 0) {
      return 0;
    }

    for (int i = 0; i < touristSitelist.length; i++) {
      if (touristSitelist[i]['user_id'] == user!.uid) {
        oldRating = touristSitelist[i]['rating'].toDouble();
        break;
      }
    }

    return oldRating;
  }

  void _bottomSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            child: Text('!!!!!!!!E3mel el comments ya mohamed!!!!!!!!'),
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Arguments;

    var touristSite = args.touristSite;
    bool _seen = args.seen;
    bool _saved = args.saved;
    double _avgRating = args.rating;

    return Scaffold(
      appBar: MyAppBar(context),
      body: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            child: _isVisible
                ? _buildImage(touristSite.imageUrl)
                : Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      color: Colors.grey[300],
                    ),
                  ),
          ),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              DateFormat.yMd().format(touristSite.added),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _buildTitle(touristSite.title)),
              Column(
                children: [
                  //average rating
                  Text(
                    'Average Rating',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  StarRating(
                    starCount: 5,
                    rating: _avgRating,
                    color: Colors.yellow[700],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        _seen
                            ? Icons.check_circle_rounded
                            : Icons.check_circle_outline_rounded,
                        color: _seen ? Colors.green : null,
                      ),
                      SizedBox(width: 15),
                      Icon(
                        _saved ? Icons.bookmark : Icons.bookmark_border_rounded,
                        color: _saved ? Colors.orange : null,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // MY Rating
          if (user != null) _buildRating(touristSite.ratings, touristSite.id),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Categories",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: touristSite.category.map((tag) {
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
          SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Description",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: _isVisible
                  ? SingleChildScrollView(
                      child: Text(
                        touristSite.description,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    )
                  : Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.grey[300],
                      ),
                    ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                name: 'Comments',
                color: ThemeData().colorScheme.tertiary,
                type: 'elevated',
                icon: Icons.comment,
                pressFunction: () {
                  _bottomSheet(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
