import 'package:flutter/material.dart';

class RejectedLeaveApplicationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rejected Leave Applications'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Rejected Leave Applications Page',
              style: TextStyle(fontSize: 24),
            ),
            // Add your UI components here
          ],
        ),
      ),
    );
  }
}
