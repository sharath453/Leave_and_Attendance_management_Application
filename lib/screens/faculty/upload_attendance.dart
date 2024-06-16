import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class UploadAttendancePage extends StatelessWidget {
  final ApiService apiService = ApiService();
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController attendanceController = TextEditingController();

  void uploadAttendance() async {
    // Implement upload attendance logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Attendance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: studentIdController,
              decoration: InputDecoration(
                labelText: 'Student ID',
              ),
            ),
            TextField(
              controller: subjectController,
              decoration: InputDecoration(
                labelText: 'Subject',
              ),
            ),
            TextField(
              controller: attendanceController,
              decoration: InputDecoration(
                labelText: 'Attendance (%)',
              ),
            ),
            ElevatedButton(
              onPressed: uploadAttendance,
              child: Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
