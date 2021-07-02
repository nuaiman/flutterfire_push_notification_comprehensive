import 'package:flutter/material.dart';

class RedPage extends StatelessWidget {
  static const routeName = '/red';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(),
      body: Center(
        child: Text('This is Red Page'),
      ),
    );
  }
}
