import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../widgets/attendance_card.dart';

class ViewAttendancePage extends StatelessWidget {
  final ApiService apiService = ApiService();

  ViewAttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
      ),
      body: FutureBuilder(
        future: apiService.fetchAttendanceData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          List attendanceData = snapshot.data as List;
          return ListView.builder(
            itemCount: attendanceData.length,
            itemBuilder: (context, index) {
              return AttendanceCard(attendance: attendanceData[index]);
            },
          );
        },
      ),
    );
  }
}
