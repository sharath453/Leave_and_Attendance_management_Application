import 'package:flutter/material.dart';
import 'apply_leave.dart';
import 'view_attendance.dart'; // Updated import
import 'view_fines.dart';
import 'view_notes.dart';

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
                      builder: (context) =>
                          ViewEditAttendancePage()), // Updated to use ViewEditAttendancePage
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
          ],
        ),
      ),
    );
  }
}
