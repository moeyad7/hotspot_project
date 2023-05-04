import 'package:flutter/material.dart';

Card post_card(BuildContext context) {
  return Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
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
        Expanded(
            child: Row(
          children: [
            Column(children: [
              Container(
                  color: ThemeData().colorScheme.background,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    "See the wonders of the long extinct YAHIA. The person who started it all. The AR/VR implementer of the week. Get a picture now before he is physical no more! ☠",
                  ))
            ]),
            Column(//Row(),
                )
          ],
        ))
      ],
    ),
  );
}
