import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:phtv_app/modals/login_request.dart';
import 'package:phtv_app/screens/my_cv/my_cv_screen.dart';

class MyFollowCompanyScreen extends StatelessWidget{
  const MyFollowCompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 242, 243),
      appBar: AppBar(
        title: const Text('My Following Companies', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: Text('My Following Companies'),
      ),
    );
  }
}