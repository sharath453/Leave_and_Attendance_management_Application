import 'package:flutter/material.dart';
import 'package:leave_management_app/screens/hod/approve_leave.dart';
import 'package:leave_management_app/screens/hod/view_leave_requests.dart';

class HodHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOD Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ApproveLeavePage()),
                );
              },
              child: Text('Approve Leave Requests'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewLeaveRequestsPage()),
                );
              },
              child: Text('View Leave Requests'),
            ),
          ],
        ),
      ),
    );
  }
}
