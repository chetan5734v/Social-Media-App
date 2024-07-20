// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/mybuttons.dart';
import 'package:social_media_app/components/mytextfeild.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();

  void login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text, password: passwordcontroller.text);
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) => const Center(
                child: Text("error"),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 40, 38, 38),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // icon
              Icon(
                Icons.person,
                size: 80,
                color: Colors.white,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "S O C I A L",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),

              // email
              const SizedBox(
                height: 20,
              ),
              MyTextfeild(
                  controller: emailcontroller,
                  hintext: "Email",
                  obscuretext: false),
              //passwd
              const SizedBox(
                height: 20,
              ),
              MyTextfeild(
                  controller: passwordcontroller,
                  hintext: "Password",
                  obscuretext: true),
              //login button
              SizedBox(
                height: 20,
              ),
              Mybutton(text: "L O G I N", onTap: login),
              //dont have acc
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have any account? ",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Register here",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
