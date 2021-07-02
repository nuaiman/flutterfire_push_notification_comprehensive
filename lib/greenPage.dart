import 'package:flutter/material.dart';

class GreenPage extends StatelessWidget {
  static const routeName = '/green';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(),
      body: Center(
        child: Text('This is Green Page'),
      ),
    );
  }
}
