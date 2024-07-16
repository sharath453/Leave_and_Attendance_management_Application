import 'package:flutter/material.dart';
import 'package:leave_management_app/screens/hod/view_leave_requests.dart';
import 'package:leave_management_app/screens/hod/approved_leave_application.dart';
import 'package:leave_management_app/screens/hod/view_attendance.dart';
import 'package:leave_management_app/screens/hod/rejected_leave_application.dart';
import 'package:leave_management_app/screens/hod/add_fine.dart';
import 'package:leave_management_app/screens/hod/view_fines.dart' as hod;

class HodHomePage extends StatelessWidget {
  const HodHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOD Home'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var button in buttons(context))
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox(
                    width: double.infinity, // Make button wide
                    height: 50, // Set a fixed height
                    child: ElevatedButton(
                      onPressed: button['onPressed'],
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue, // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12), // Rounded corners
                        ),
                        elevation: 2,
                      ),
                      child: Text(button['label']),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> buttons(BuildContext context) {
    return [
      {
        'label': 'View Leave Requests',
        'onPressed': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewLeaveRequestsPage(),
            ),
          );
        },
      },
      {
        'label': 'Approved Leave Applications',
        'onPressed': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ApprovedLeaveApplicationPage(),
            ),
          );
        },
      },
      {
        'label': 'View Attendance',
        'onPressed': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewEditAttendancePage(),
            ),
          );
        },
      },
      {
        'label': 'Rejected Leave Applications',
        'onPressed': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RejectedLeaveApplicationPage(),
            ),
          );
        },
      },
      {
        'label': 'Add Fine',
        'onPressed': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFinePage(),
            ),
          );
        },
      },
      {
        'label': 'View Fines',
        'onPressed': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => hod.ViewFinesPage(),
            ),
          );
        },
      },
    ];
  }
}
