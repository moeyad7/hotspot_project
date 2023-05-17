import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../compnents/app_bar.dart';
import '../model/tourist_site.dart';
import '../compnents/buttons/buttons.dart';

class PostDetail extends StatefulWidget {
  static const routeName = '/post-detail';
  final TouristSite? touristSite;

  const PostDetail({this.touristSite});

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  bool _isVisible = false;

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

  Widget _buildTitle() {
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: Text(
        widget.touristSite!.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
    );
  }

  Widget _buildRating() {
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: Row(
        children: [
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                ? Container() //widget.touristSite.imageUrl ? _buildImage(widget.touristSite.imageUrl)
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
              DateFormat.yMd().format(widget.touristSite!.added),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _buildTitle()),
              SizedBox(width: 16),
              Column(
                children: [
                  _buildRating(),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        child: CustomButton(
                          name: 'seen',
                          color: Colors.black,
                          type: 'icons',
                          icon: Icons.check_circle_outline_rounded,
                        ),
                      ),
                      SizedBox(width: 35),
                      Container(
                        width: 20,
                        height: 20,
                        child: CustomButton(
                          name: 'save',
                          color: Colors.black,
                          type: 'icons',
                          icon: Icons.bookmark_border_rounded,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
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
            children: widget.touristSite!.category.map((tag) {
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
                        widget.touristSite!.description,
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
