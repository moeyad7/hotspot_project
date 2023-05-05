
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';

import '../compnents/app_bar.dart';
import '../compnents/data/DUMMMY_DATA.dart';
import '../compnents/buttons/buttons.dart';

class PostDetail extends StatefulWidget {
  static const routeName = '/post-detail';

  const PostDetail({super.key});

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  Rating(double rating) {
    return Row(children: [
      Icon(
        Icons.star,
        color: Colors.black,
      ),
      Icon(
        Icons.star,
        color: Colors.black,
      ),
      Icon(
        Icons.star,
        color: Colors.black,
      ),
      Icon(
        Icons.star,
        color: Colors.black,
      ),
      Icon(
        Icons.star_half,
        color: Colors.black,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: my_appBar(context),
      body: Column(
        children: <Widget>[
//           ClipRRect(
//    borderRadius: BorderRadius.only(
//      bottomLeft: Radius.circular(15),
//      bottomRight: Radius.circular(15),
//    ),
//    child: Shimmer.fromColors(
//      baseColor: ThemeData().colorScheme.primary.withAlpha(50),
//      highlightColor: ThemeData().colorScheme.surface.withAlpha(50),
//      child: Image.network(
//        touristSites[0].imageUrl
//      ),
//    ),
// ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/loading.gif',
              image: touristSites[0].imageUrl,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              DateFormat.yMd().format(touristSites[0].added),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                touristSites[0].name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        touristSites[0].rating.toString() + "/5",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CustomButton(
                        name: 'seen',
                        color: Colors.black,
                        type: 'icons',
                        icon: Icons.check_circle_outline_rounded,
                      ),
                      CustomButton(
                        name: 'save',
                        color: Colors.black,
                        type: 'icons',
                        icon: Icons.bookmark_border_rounded,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Categories",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Row(
            children: touristSites[0].category.map((tag) {
              return Container(
                margin: EdgeInsets.only(left: 8, right: 8),
                child: CustomButton(
                  name: tag,
                  color: ThemeData().colorScheme.tertiary,
                  type: 'chips',
                ),
              );
            }).toList(),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Rating",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Rating(touristSites[0].rating),
          SizedBox(height: 8),
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
          Text(
            touristSites[0].description,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          CustomButton(name: "Comments/Rating", color:  Color(0xFF2FC686), type: "ElevatedButton", icon: Icons.comment_rounded)
        ],
                  

      ),
    );
  }
}


// ClipRRect(
//    borderRadius: BorderRadius.only(
//      bottomLeft: Radius.circular(15),
//      bottomRight: Radius.circular(15),
//    ),
//    child: Shimmer.fromColors(
//      baseColor: ThemeData().colorScheme.primary.withAlpha(50),
//      highlightColor: ThemeData().colorScheme.surface.withAlpha(50),
//      child: Image.network(
//        touristSites[0].imageUrl
//      ),
//    ),
// ),
