import 'package:flutter/material.dart';
import 'package:leave_management_app/screens/hod/view_leave_requests.dart';
import 'package:leave_management_app/screens/hod/approved_leave_application.dart';
import 'package:leave_management_app/screens/hod/view_attendance.dart';
import 'package:leave_management_app/screens/hod/rejected_leave_application.dart';
import 'package:leave_management_app/screens/hod/add_fine.dart'; // Import the AddFinePage

class HodHomePage extends StatelessWidget {
  const HodHomePage({super.key});

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
                  MaterialPageRoute(
                    builder: (context) => ViewLeaveRequestsPage(),
                  ),
                );
              },
              child: Text('View Leave Requests'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ApprovedLeaveApplicationPage(),
                  ),
                );
              },
              child: Text('Approved Leave Applications'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewEditAttendancePage(),
                  ),
                );
              },
              child: Text('View Attendance'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RejectedLeaveApplicationPage(),
                  ),
                );
              },
              child: Text('Rejected Leave Applications'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddFinePage(), // Navigate to AddFinePage
                  ),
                );
              },
              child: Text('Add Fine'),
            ),
          ],
        ),
      ),
    );
  }
}
