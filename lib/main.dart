// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_task_sample/view/reg_screen/reg_screen.dart';
import 'package:flutter/material.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBLIdMXbv0p2aJeoU9pbowkXs099Uy4FGA",
          appId: "1:586376339373:android:ec7e07b1549082b490cb24",
          messagingSenderId: "",
          projectId: "fir-tasksample",
          storageBucket: "fir-tasksample.appspot.com"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: RegScreen());
  }
}
