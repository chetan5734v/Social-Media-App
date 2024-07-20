// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/mytextfeild.dart';

class Explorepage extends StatefulWidget {
  Explorepage({super.key});

  @override
  State<Explorepage> createState() => _ExplorepageState();
}

class _ExplorepageState extends State<Explorepage> {
  TextEditingController _textController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser; 
  String emailId = "";
  void sendRequest() {
    FirebaseFirestore.instance
        .collection('user')
        .doc(emailId)
        .collection('freindrequests')
        .add({
      'from': user?.email,
    });
  }

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("E x p l o r e  P a g e")),
      ),
      body: Center(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextfeild(
                controller: _textController,
                hintext: "Search",
                obscuretext: false),
          ),
          Expanded(child: _buildUserListStream())
        ]),
      ),
    );
  }

  Widget _buildUserListStream() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('user')
          .where('username', isEqualTo: _textController.text)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("An error occurred: ${snapshot.error}"),
          );
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text("No User Found"),
          );
        }

        var persons = snapshot.data!.docs;
        return ListView.builder(
          itemCount: persons.length,
          itemBuilder: (context, index) {
            var person = persons[index];
            emailId = person.id;
            return ListTile(
              title: Text(person['username']),
              trailing: IconButton(
                icon: Icon(Icons.add),
                onPressed: sendRequest,
              ),
            );
          },
        );
      },
    );
  }
}
