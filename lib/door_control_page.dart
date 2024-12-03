import 'package:flutter/material.dart';

class DoorControlPage extends StatelessWidget {
  const DoorControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('카매라 제어')),
      body: Center(
        child: const Text('This is the Door Control page'),
      ),
    );
  }
}
