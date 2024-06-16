import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class ViewEditAttendancePage extends StatefulWidget {
  @override
  _ViewEditAttendancePageState createState() => _ViewEditAttendancePageState();
}

class _ViewEditAttendancePageState extends State<ViewEditAttendancePage> {
  final ApiService apiService = ApiService();
  late Future<List<dynamic>> attendanceData;

  @override
  void initState() {
    super.initState();
    attendanceData = apiService.fetchAttendanceData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View and Edit Attendance'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: attendanceData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final data = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final attendance = data[index];
                      return ListTile(
                        title: Text(attendance['full_name']),
                        subtitle: Text(
                          'Total Classes Conducted: ${attendance['total_classes_conducted']} | Total Classes Attended: ${attendance['total_classes_attended']} | Attendance: ${attendance['attendance_percentage']}%',
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Implement edit functionality
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
