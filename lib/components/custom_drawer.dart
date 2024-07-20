// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/pages/display_users.dart';
import 'package:social_media_app/pages/explorepage.dart';

class Mydrawer extends StatelessWidget {
  const Mydrawer({super.key});
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  void displayUser(context) {
    Navigator.pushNamed(context,'/displayuser');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(child: Icon(Icons.favorite)),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("H O M E"),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("P R O F I L E"),
          ),
          GestureDetector(
            onTap:() => displayUser(context),
            child: ListTile(
              leading: Icon(Icons.group),
              title: Text("U S E R S"),
            ),
          ),
          GestureDetector(
            onTap:() => Navigator.pushNamed(context,'explorepage'),
            child: ListTile(
              leading: Icon(Icons.group),
              title: Text("E X P L O R E  P A G E"),
            ),
          ),
           GestureDetector(
            onTap:() => Navigator.pushNamed(context,'pendingreq'),
            child: ListTile(
              leading: Icon(Icons.group),
              title: Text("R E Q U E S T S"),
            ),
          ),
          GestureDetector(
            onTap: logout,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 400, 10, 25),
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text("L O G  O U T"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
