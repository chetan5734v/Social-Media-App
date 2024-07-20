import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  Future<void> getCurrentUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
  
    if (user != null) {
      // User is signed in
     user.email;
     
    } else {
      // No user is signed in
      print('No user is currently signed in.');
    }
  }

  @override
  Widget build(BuildContext context) {
    getCurrentUserEmail();
    return Scaffold(
      body: Column(
        children: [Text("hi")],
      ),
    );
  }
}
