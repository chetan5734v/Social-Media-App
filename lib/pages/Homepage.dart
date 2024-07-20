// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/custom_drawer.dart';
import 'package:social_media_app/pages/chatpage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("H O M E"),
        actions: [IconButton(onPressed: logout, icon: Icon(Icons.logout))],
      ),
      
      drawer: Mydrawer(),
    );
  }
}
