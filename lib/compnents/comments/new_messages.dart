import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  final String siteID;
  NewMessage({required this.siteID});
  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();
  var _enteredMessage = '';
  void _sendMessage()  async{
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser; 
    FirebaseFirestore.instance
        .collection('locations')
        .doc(widget.siteID)
        .collection('comments')
        .add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user!.uid,
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(children: <Widget>[
        Expanded(
          child: TextField(
            controller: _controller,
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
      ]),
    );
  }
}
