import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../data/DUMMMY_DATA.dart';
import '../buttons/buttons.dart';

class PostCard extends StatelessWidget {
  final TouristSite touristSites;

  const PostCard({Key? key, required this.touristSites}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Row Rating(double rating) {
      const star = Icon(
        Icons.star,
        color: Colors.black,
      );
      const nostar = Icon(Icons.star_outline_outlined, color: Colors.white);
      if (rating >= 5) {
        return Row(
          children: [
            star,
            star,
            star,
            star,
            star,
          ],
        );
      }
      if (rating >= 4) {
        return Row(
          children: [
            star,
            star,
            star,
            star,
            nostar,
          ],
        );
      }
      if (rating >= 3) {
        return Row(
          children: [
            star,
            star,
            star,
            nostar,
            nostar,
          ],
        );
      }
      if (rating >= 2) {
        return Row(
          children: [
            star,
            star,
            nostar,
            nostar,
            nostar,
          ],
        );
      }
      if (rating >= 1) {
        return Row(
          children: [
            star,
            nostar,
            nostar,
            nostar,
            nostar,
          ],
        );
      } else {
        return Row(
          children: [
            nostar,
            nostar,
            nostar,
            nostar,
            nostar,
          ],
        );
      }
    }

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/post-detail');
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
                    child: _buildImage(touristSites.imageUrl),
                  ),
                  Positioned(
                    left: 8,
                    bottom: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          touristSites.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Rating(touristSites.rating),
                        Row(
                          children: touristSites.category.map((tag) {
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
                    touristSites.description,
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
