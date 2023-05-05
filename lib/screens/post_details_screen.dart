import 'package:flutter/material.dart';
import '../compnents/data/DUMMMY_DATA.dart';

class PostDetail extends StatefulWidget {
  static const routeName = '/post-detail';

  const PostDetail({super.key});

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Detail'),
      ),
      body: (
          Container(
            child:
            Column(children: <Widget>[
              ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      child: Image.network(
                        touristSites[0].imageUrl,
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
            ]),
          )
      ),

      );
  }
}