import 'package:flutter/material.dart';

class LaneControlPage extends StatelessWidget {
  const LaneControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lane Control')),
      body: Center(
        child: const Text('This is the Lane Control page'),
      ),
    );
  }
}
