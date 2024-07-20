// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class pendingrequest extends StatelessWidget {
  pendingrequest({super.key});
  User? user = FirebaseAuth.instance.currentUser;
  String emailid = "";
  String username = "";
  String requestId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("F R I E N D S"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('user')
              .doc(user?.email)
              .collection('freindrequests')
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
            var requests = snapshot.data!.docs;
            return ListView.builder(
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  var requesti = requests[index];
                  emailid = requesti['from'];
                  requestId = requesti.id;
                  return ListTile(
                    title: Text(requesti['from']),
                    trailing: IconButton(
                        onPressed: () => acceptRequests(emailid),
                        icon: Icon(Icons.add_circle_outline_sharp)),
                  );
                });
          }),
    );
  }

  Future<void> getUsername(String emailid) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(emailid)
          .get();
      if (userDoc.exists) {
        // Added check for document existence
        username = userDoc['username'];
      } else {
        print("User document does not exist");
      }
    } catch (e) {
      print("Error fetching username: $e");
    }
  }

  Future<void> acceptRequests(String emailid) async {
    await getUsername(emailid);
    FirebaseFirestore.instance
        .collection('user')
        .doc(user?.email)
        .collection('friends')
        .add({'username': username, 'email': emailid});
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user?.email)
        .collection('freindrequests')
        .doc(requestId)
        .delete();
  }
}
