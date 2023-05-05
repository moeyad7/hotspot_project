import 'package:flutter/material.dart';
import 'package:hotspot_project/compnents/buttons/buttons.dart';
import '../data/DUMMMY_DATA.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    String img = touristSites[0].imageUrl;
    Rating(double rating) {
      return Row(children: [
        Icon(
          Icons.star,
          color: Colors.white,
        ),
        Icon(
          Icons.star,
          color: Colors.white,
        ),
        Icon(
          Icons.star,
          color: Colors.white,
        ),
        Icon(
          Icons.star,
          color: Colors.white,
        ),
        Icon(
          Icons.star_half,
          color: Colors.white,
        ),
      ]);
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
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage("https://cdn.discordapp.com/attachments/1102648982624284784/1103798049953812500/20230505_003816.jpg"),
                  fit: BoxFit.fill,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0),
                      Colors.black.withOpacity(0.5),
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
                          touristSites[0].name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Rating(touristSites[0].rating),
                      ],
                    ),
                    SizedBox(height: 8),
                    Center(
                        child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8,
                      children: [
                        Row(
                          children: touristSites[0].category.map((tag) {
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
                        touristSites[0].description,
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
