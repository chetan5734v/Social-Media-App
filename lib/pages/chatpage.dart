// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String currentUseruid;
  final String userUid;
  ChatPage({super.key, required this.currentUseruid, required this.userUid});

  TextEditingController _textController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> checkAndCreate(String chatId) async {
    var chatDoc = FirebaseFirestore.instance.collection('chatrooms').doc(chatId);
    var checkSnapshot = await chatDoc.get();
    if (!checkSnapshot.exists) {
      await chatDoc.set({
        'users': [currentUseruid, userUid],
        'created_at': FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> ex = [currentUseruid, userUid];
    ex.sort();
    String chatId = ex.join("_");
    checkAndCreate(chatId);

    void sendMessage(String text) {
      if (text.trim().isEmpty) return;

      FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(chatId)
          .collection('messages')
          .add({
        'text': text,
        'senderid': user?.email,
        'timestamp': FieldValue.serverTimestamp()
      });
      _textController.clear();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("C H A T S"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chatrooms')
                  .doc(chatId)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("An error occurred: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("No messages found"));
                }

                var messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];
                    return ListTile(
                      title: Text(message['text']),
                      subtitle: Text(message['senderid']),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      labelText: "Enter message",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    sendMessage(_textController.text.trim());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
