import 'package:flutter/material.dart';

class AttendanceCard extends StatelessWidget {
  final Map<String, dynamic> attendance;

  const AttendanceCard({super.key, required this.attendance});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(attendance['subject']),
        subtitle: Text('Attendance: ${attendance['percentage']}%'),
      ),
    );
  }
}
