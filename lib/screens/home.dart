

import 'package:barberia/screens/login.dart';
import 'package:barberia/services/firebase_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () async{
            await FirebaseServices().signOut();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const LoginScreen()));

          },
          child: const Text("Logout"),
      
      ),)

    );


  }
}
