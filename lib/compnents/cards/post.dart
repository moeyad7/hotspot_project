import 'package:flutter/material.dart';
import 'package:hotspot_project/compnents/buttons/buttons.dart';

Card post_card(BuildContext context) {
  return Card(
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
              image: NetworkImage(
                  'https://cdn.discordapp.com/attachments/1102648982624284784/1103798049953812500/20230505_003816.jpg'),
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
                      'Name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(children: [
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
                    ])
                  ],
                ),
                SizedBox(height: 8),
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    children: [
                      Chip(label: Text('Chip 1')),
                      Chip(label: Text('Chip 2')),
                      Chip(label: Text('Chip 3')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Column(children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  margin: EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 8),
                  child: Text(
                    "See the wonders of the long extinct YAHIA. The person who started it all. The AR/VR implementer of the week. Get a picture now before he is physical no more! ☠",
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
  );
}
