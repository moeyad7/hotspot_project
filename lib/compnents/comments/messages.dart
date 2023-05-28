import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './message_bubble.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatefulWidget {
  final String siteID;
  Messages({required this.siteID});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return FutureBuilder(
      future: Future.value(FirebaseAuth.instance.currentUser),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('locations')
                .doc(widget.siteID)
                .collection('comments')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, commentsSnapshot) {
              if (commentsSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              // if there are no comments yet then show a message to the user
              if (commentsSnapshot.data!.docs.length == 0) {
                return Center(
                  child: Text(
                    'No Comments Yet',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                );
              }

              final commentdocs = commentsSnapshot.data!.docs;
              return ListView.builder(
                reverse: true,
                itemCount: commentdocs.length,
                itemBuilder: (ctx, index) => MessageBubble(
                  commentdocs[index]['text'],
                  commentdocs[index]['username'],
                  commentdocs[index]['userImage'],
                  user != null
                      ? commentdocs[index]['userId'] == futureSnapshot.data!.uid
                      : false,
                  key: ValueKey(commentdocs[index].id),
                ),
              );
            });
      },
    );
  }
}
