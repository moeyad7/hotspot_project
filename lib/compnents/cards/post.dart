import '/data/DUMMMY_DATA.dart';
import '../buttons/buttons.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final TouristSite touristSites;

  const PostCard({Key? key, required this.touristSites}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String img = touristSites.imageUrl;
    Row Rating(double rating) {
      const star = Icon(
        Icons.star,
        color: Colors.white,
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
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(touristSites.imageUrl),
                  fit: BoxFit.fill,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0),
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          touristSites.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Rating(touristSites.rating),
                      ],
                    ),
                    SizedBox(height: 8),
                    Center(
                        child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8,
                      children: [
                        Row(
                          children: touristSites.category.map((tag) {
                            return Container(
                                margin: EdgeInsets.only(
                                    left: 8,
                                    right: 8), // spacing between adjacent chips
                                child: CustomButton(
                                  name: tag,
                                  color: ThemeData().colorScheme.tertiary,
                                  type: 'chips',
                                ));
                          }).toList(),
                        )
                      ],
                    )),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Column(children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      margin:
                          EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 8),
                      child: Text(
                        touristSites.description,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ))
                ]),
                Column(children: <Widget>[
                  Row(
                    children: [
                      CustomButton(
                          name: 'seen',
                          color: Colors.black,
                          type: 'icons',
                          icon: Icons.check_circle_outline_rounded),
                      CustomButton(
                          name: 'save',
                          color: Colors.black,
                          type: 'icons',
                          icon: Icons.bookmark_border_rounded),
                    ],
                  ),
                  CustomButton(
                      name: 'More',
                      color: ThemeData().colorScheme.tertiary,
                      type: 'elevated',
                      icon: Icons.zoom_out_map_rounded)
                ])
              ],
            )
          ],
        ),
      ),
    );
  }
}
