import 'package:flutter/material.dart';
import 'add_notes.dart';
import 'upload_attendance.dart';
import 'view_edit_attendance.dart';

class FacultyHomePage extends StatelessWidget {
  const FacultyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Faculty Home'),
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
