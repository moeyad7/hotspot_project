import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './message_bubble.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  final String siteID;
  Messages({required this.siteID});
  @override
  Widget build(BuildContext context) {
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
                .doc(siteID)
                .collection('comments')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, commentsSnapshot) {
              if (commentsSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final commentdocs = commentsSnapshot.data!.docs;
              return ListView.builder(
                reverse: true,
                itemCount: commentdocs.length,
                itemBuilder: (ctx, index) => MessageBubble(
                  commentdocs[index]['text'],
                  commentdocs[index]['username'],
                  commentdocs[index]['userId'] == futureSnapshot.data!.uid,
                  key: ValueKey(commentdocs[index].id),
                ),
              );
            });
      },
    );
  }
}
