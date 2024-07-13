import 'package:flutter/material.dart';
import 'package:leave_management_app/services/api_service.dart';

class ViewEditAttendancePage extends StatefulWidget {
  const ViewEditAttendancePage({super.key});

  @override
  _ViewEditAttendancePageState createState() => _ViewEditAttendancePageState();
}

class _ViewEditAttendancePageState extends State<ViewEditAttendancePage> {
  final ApiService apiService = ApiService();
  late Future<Map<String, Map<String, double>>> attendanceData;

  @override
  void initState() {
    super.initState();
    attendanceData = apiService.fetchAttendanceData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Attendance'),
      ),
      body: FutureBuilder<Map<String, Map<String, double>>>(
        future: attendanceData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final username = data.keys.elementAt(index);
                final subjects = data[username]!;
                return ExpansionTile(
                  title: Text(username),
                  children: subjects.entries.map((entry) {
                    return ListTile(
                      title: Text(entry.key),
                      trailing: Text('${entry.value}%'),
                    );
                  }).toList(),
                );
              },
            );
          }
        },
      ),
    );
  }
}
