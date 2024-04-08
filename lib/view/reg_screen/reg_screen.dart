// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_task_sample/view/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({super.key});

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController pswdcontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController phncontroller = TextEditingController();
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("users");
  final _formkey = GlobalKey<FormState>();
  List<String> roles = ['', 'Admin', 'User'];

  String selectedRole = '';

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
                height: 185,
              ),
              // email
              TextFormField(
                controller: emailcontroller,
                decoration: InputDecoration(
                    labelText: "email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7))),
                validator: (value) {
                  if (RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(emailcontroller.text)) {
                    return null;
                  } else {
                    return "enter a valid email";
                  }
                },
              ),
              SizedBox(height: 20),

              //password
              TextFormField(
                controller: pswdcontroller,
                decoration: InputDecoration(
                    labelText: "password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7))),
                validator: (value) {
                  if (value != null && value.length >= 6) {
                    return null;
                  } else {
                    return "enter a valid password";
                  }
                },
              ),
              SizedBox(height: 20),
              // username
              TextFormField(
                controller: usernamecontroller,
                decoration: InputDecoration(
                    labelText: "username",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7))),
              ),
              SizedBox(height: 20),
              // phone
              TextFormField(
                controller: phncontroller,
                decoration: InputDecoration(
                    labelText: "phone no",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7))),
              ),
              SizedBox(
                height: 15,
              ),

              DropdownButtonFormField<String>(
                value: selectedRole,
                onChanged: (newValue) {
                  setState(() {
                    selectedRole = newValue!;
                  });
                },
                items: roles.map((String role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      try {
                        final cred = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: emailcontroller.text,
                          password: pswdcontroller.text,
                        );
                        collectionReference.add({
                          "username": usernamecontroller.text,
                          "ph": phncontroller.text,
                          // "image": url,
                          "role": selectedRole
                        });
                        if (cred.user?.uid != null) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("failed to create account try again")));
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          // print('The password provided is too weak.');
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('The password provided is too weak.')));
                        } else if (e.code == 'email-already-in-use') {
                          // print('The account already exists for that email.');
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'The account already exists for that email.')));
                        }
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  child: Text("register")),
              SizedBox(
                height: 15,
              ),

              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                  },
                  child: Text("already a user,login now")),
            ],
          ),
        ),
      ),
    );
  }
}
