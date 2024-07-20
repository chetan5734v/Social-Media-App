// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  Mybutton({super.key,required this.text,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
      onTap: onTap,
      child: Container(
        height: 50,
        width:200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color:  const Color.fromARGB(255, 104, 103, 103)

        ),
        
        
        child: Center(child: Text(text,style: TextStyle(color: Colors.white),)),
      ),
    );
  }
}
