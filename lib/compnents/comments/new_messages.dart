import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../notifications/notifications.dart';

class NewMessage extends StatefulWidget {
  final String siteID;
  NewMessage({required this.siteID});
  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();
  var _enteredMessage = '';
  final user = FirebaseAuth.instance.currentUser;
  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    FirebaseFirestore.instance
        .collection('locations')
        .doc(widget.siteID)
        .collection('comments')
        .add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user!.uid,
      'username': userData['username'],
      'userImage': userData['image_url'],
    });
    _controller.clear();
    NotificationService()
        .showNotification(title: 'Comments', body: 'New Comment Added');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: user != null
          ? Row(children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _controller,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  enableSuggestions: true,
                  decoration: InputDecoration(labelText: 'Write a comment '),
                  onChanged: (value) {
                    setState(() {
                      _enteredMessage = value;
                    });
                  },
                ),
              ),
              IconButton(
                color: Color(0xFFF58A07),
                onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
                icon: Icon(Icons.send),
              )
            ])
          : Container(),
    );
  }
}
