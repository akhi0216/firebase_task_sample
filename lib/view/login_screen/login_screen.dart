// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_task_sample/view/home_screen/home_screen.dart';
import 'package:firebase_task_sample/view/reg_screen/reg_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController pswdcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _formkey,
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 180,
              ),
              TextFormField(
                controller: emailcontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7))),
                // validator: (value) {
                //   if (RegExp(
                //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                //       .hasMatch(emailcontroller.text)) {
                //     return null;
                //   } else {
                //     return "enter a valid email";
                //   }
                // },
              ),
              SizedBox(height: 30),
              //
              TextFormField(
                controller: pswdcontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7))),
                // validator: (value) {
                //   if (value != null && value.length >= 6) {
                //     return null;
                //   } else {
                //     return "enter a valid password";
                //   }
                // },
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: emailcontroller.text,
                                password: pswdcontroller.text);
                        log(credential.user?.uid.toString() ?? "no data");
                        if (credential.user?.uid != null) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Failed to create Account , try again')));
                        }
                      } on FirebaseAuthException catch (e) {
                        log(e.code.toString());
                        if (e.code == 'user-not-found') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('No user found for that email.')));
                          log('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Wrong password provided for that user.')));
                          log('Wrong password provided for that user.');
                        }
                      }
                    }
                  },
                  child: Text("Login")),
              SizedBox(
                height: 20,
              ),
              // TextButton(
              //     onPressed: () {
              //       // navigate to registor screen
              //       Navigator.pushReplacement(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => RegScreen(),
              //           ));
              //     },
              //     child: Text("login"))
            ],
          ),
        ),
      ),
    );
  }
}
