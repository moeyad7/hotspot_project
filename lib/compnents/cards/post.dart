import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../buttons/buttons.dart';
import '../../model/tourist_site.dart';

class PostCard extends StatefulWidget {
  final TouristSite touristSites;

  const PostCard({Key? key, required this.touristSites}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    bool seen = false;
    bool saved = false;

    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, '/post-detail');
      },
      child: Card(
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
                        widget.touristSites.rating != null
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
                              seen == true
                                  ? Icons.check_circle_rounded
                                  : Icons.check_circle_outline_rounded,
                              color: seen == true ? Colors.green : null,
                            ),
                            onPressed: () {
                              setState(() {
                                seen = !seen;
                                print(seen);
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              saved == true
                                  ? Icons.bookmark
                                  : Icons.bookmark_border_rounded,
                              color: saved == true ? Colors.orange : null,
                            ),
                            onPressed: () {
                              setState(() {
                                saved = !saved;
                              });
                            },
                          ),
                        ],
                      ),
                      CustomButton(
                        name: 'More',
                        color: ThemeData().colorScheme.tertiary,
                        type: 'elevated',
                        icon: Icons.zoom_out_map_rounded,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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
