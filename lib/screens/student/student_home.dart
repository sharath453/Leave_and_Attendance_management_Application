import 'package:flutter/material.dart';
import 'package:leave_management_app/screens/hod/approved_leave_application.dart';
import 'apply_leave.dart';
import 'view_attendance.dart';
import 'view_fines.dart';
import 'view_notes.dart';
import 'make_payments.dart';
import 'rejected_leave_application.dart'; // Import the new file

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ApplyLeavePage()),
                );
              },
              child: Text('Apply for Leave'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewEditAttendancePage()),
                );
              },
              child: Text('View Attendance'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewFinesPage()),
                );
              },
              child: Text('View Fines'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewNotesPage()),
                );
              },
              child: Text('View Notes'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MakePaymentsPage()), // Navigate to MakePaymentsPage
                );
              },
              child: Text('Make Payments'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ApprovedLeaveApplicationPage()), // Navigate to ApprovedLeaveApplicationPage
                );
              },
              child: Text('Approved Leave Applications'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RejectedLeaveApplicationPage()), // Navigate to RejectedLeaveApplicationPage
                );
              },
              child: Text('Rejected Leave Applications'),
            ),
          ],
        ),
      ),
    );
  }
}
