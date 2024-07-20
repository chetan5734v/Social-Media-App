// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyTextfeild extends StatelessWidget {
  final String hintext;
  final bool obscuretext;
  final TextEditingController controller;
  const MyTextfeild(
      {super.key,
      required this.controller,
      required this.hintext,
      required this.obscuretext});

  @override
  Widget build(BuildContext context) {
    return TextField(
      
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12)
        ),
        hintText: hintext,
        
      ),
      style: TextStyle(color: Colors.white),
      obscureText: obscuretext,
      
    );
  }
}
