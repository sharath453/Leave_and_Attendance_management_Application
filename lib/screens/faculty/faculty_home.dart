import 'package:flutter/material.dart';
import 'add_notes.dart';
import 'upload_attendance.dart';
import 'view_edit_attendance.dart';
import 'package:leave_management_app/screens/login_screen.dart'; // Import your login page

class FacultyHomePage extends StatelessWidget {
  const FacultyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Faculty Home'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        LoginPage(), // Replace with your login page
                  ),
                );
              },
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.black, // Text color
                  fontSize: 16, // Font size
                ),
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Upload Notes'),
              Tab(text: 'Upload Attendance'),
              Tab(text: 'View/Edit Attendance'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AddNotesPage(),
            UploadAttendancePage(),
            ViewEditAttendancePage(),
          ],
        ),
      ),
    );
  }
}
