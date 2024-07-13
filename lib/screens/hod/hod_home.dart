import 'package:flutter/material.dart';
import 'package:leave_management_app/screens/hod/view_leave_requests.dart';
import 'package:leave_management_app/screens/hod/approved_leave_application.dart';
import 'package:leave_management_app/screens/hod/view_attendance.dart';
import 'package:leave_management_app/screens/hod/rejected_leave_application.dart';
import 'package:leave_management_app/screens/hod/add_fine.dart';
import 'package:leave_management_app/screens/hod/view_fines.dart'
    as hod; // Aliasing for HOD view
// ignore: unused_import
import 'package:leave_management_app/screens/student/view_fines.dart'
    as student; // Aliasing for Student view

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
                    builder: (context) => AddFinePage(),
                  ),
                );
              },
              child: Text('Add Fine'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        hod.ViewFinesPage(), // Using alias for HOD view
                  ),
                );
              },
              child: Text('View Fines'),
            ),
          ],
        ),
      ),
    );
  }
}
