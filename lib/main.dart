// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/auth/AuthPage.dart';
import 'package:social_media_app/auth/login_or_register.dart';
import 'package:social_media_app/components/searchuser.dart';
import 'package:social_media_app/firebase_options.dart';
import 'package:social_media_app/pages/chatpage.dart';
import 'package:social_media_app/pages/display_users.dart';
import 'package:social_media_app/pages/explorepage.dart';
import 'package:social_media_app/pages/login_page.dart';
import 'package:social_media_app/pages/pendingRequests.dart';
import 'package:social_media_app/pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:AuthPage(),
    routes: {
      '/displayuser':(context)=>UserListScreen(),
      'explorepage':(context)=>Explorepage(),
      'searchuser':(context)=>Searchuser(),
      'explorepage':(context)=>Explorepage(),
      'pendingreq':(context)=>pendingrequest()
      
    }
    );
    }

  }

