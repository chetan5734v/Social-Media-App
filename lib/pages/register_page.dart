// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/mybuttons.dart';
import 'package:social_media_app/components/mytextfeild.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();

  final TextEditingController usernamecontroller = TextEditingController();

  final TextEditingController confirmpasscontroller = TextEditingController();

  void register() async {
    if (passwordcontroller.text != confirmpasscontroller.text) {
      showDialog(
          context: context,
          builder: (context) => const Center(
                child: Text("Confirm password does not match"),
              ));
    } else {
      try {
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailcontroller.text, password: passwordcontroller.text);

        await FirebaseFirestore.instance
            .collection('user')
            .doc(userCredential.user!.email)
            .set({
          'email': userCredential.user!.email,
          'username': usernamecontroller.text
        });
      } on FirebaseAuthException catch (e) {
        showDialog(
            context: context,
            builder: (context) => const Center(
                  child: Text("failed"),
                ));
      }
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
              // username
              const SizedBox(
                height: 20,
              ),
              MyTextfeild(
                  controller: usernamecontroller,
                  hintext: "Username",
                  obscuretext: false),

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
              // confirm password
              const SizedBox(
                height: 20,
              ),
              MyTextfeild(
                  controller: confirmpasscontroller,
                  hintext: "Confirm Password",
                  obscuretext: true),
              //register button
              SizedBox(
                height: 20,
              ),
              Mybutton(text: "R E G I S T E R", onTap: register),
              //dont have acc
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Login here",
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
