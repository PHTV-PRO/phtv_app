import 'package:flutter/material.dart';

class ToolsScreen extends StatelessWidget{
  const ToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: const Color.fromARGB(255, 241, 242, 243),
      body: const Center(
          child: Text('ToolsScreen')
      ),
    );
  }
}