import 'package:Hotspot/model/arguments.dart';
import 'package:Hotspot/screens/post_details_screen.dart';
import 'package:flutter/material.dart';

import '../../model/tourist_site.dart';

class SearchCard extends StatelessWidget {
  final TouristSite touristSite;

  SearchCard({
    required this.touristSite,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).pushNamed(PostDetail.routeName, arguments: Arguments(touristSite, seen, saved, rating));
      },
      child: Card(
        color: Color(0xFFFDF5ED),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(touristSite.imageUrl),
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    touristSite.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    touristSite.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Wrap(
                    spacing: 8,
                    children: touristSite.category
                        .map((category) => Chip(
                              label: Text(
                                category,
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.blue,
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
