// import 'package:firebase_task_sample/view/login_screen/login_screen.dart';
// import 'package:flutter/material.dart';
// // import 'package:loginmb/view/login_screen/login_screen.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   Future<void> _logout() async {
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => LoginScreen()),
//       (route) => false,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//             onPressed: () {
//               _logout();
//               // Navigator.push(
//               //     context,
//               //     MaterialPageRoute(
//               //       builder: (context) => RegisterScreen(),
//               //     ));
//             },
//             child: Text("Log Out")),
//       ),
//     );
//   }
// }
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_typing_uninitialized_variables

import 'package:firebase_task_sample/view/home_screen/admin_screen.dart';
import 'package:firebase_task_sample/view/home_screen/user_screen.dart';
import 'package:firebase_task_sample/view/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

// import 'package:task_firebase_sample/view/home_screen/widgets/admin_screen/admin_screen.dart';
// import 'package:task_firebase_sample/view/home_screen/widgets/user_screen/user_screen.dart';
// import 'package:task_firebase_sample/view/login_screen/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: "Admin"),
              Tab(text: "User"),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                      (route) => false);
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: TabBarView(children: [AdminScreen(), UserScreen()]),
      ),
    );
  }
}
