import 'package:flutter/material.dart';

import '../compnents/app_bar.dart';
import '../compnents/comments/messages.dart';
import '../compnents/comments/new_messages.dart';

class CommentsScreen extends StatefulWidget {
  static const routeName = '/CommentsScreen';
  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  Widget build(BuildContext context) {
    final siteID = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: MyAppBar(context),
      body: Container(
        child: Column(children: <Widget>[
          Expanded(
              child: Messages(
            siteID: siteID,
          )),
          NewMessage(siteID: siteID,),
        ]),
      ),
    );
  }
}
