import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';

class MyCVScreen extends StatelessWidget {
  const MyCVScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My CV'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('this is my CV screen'),
      ),
    );
  }
}
