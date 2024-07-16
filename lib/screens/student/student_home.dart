import 'package:flutter/material.dart';
import 'package:leave_management_app/screens/hod/approved_leave_application.dart';
import 'apply_leave.dart';
import 'view_attendance.dart';
import 'view_fines.dart';
import 'view_notes.dart';
import 'make_payments.dart';
import 'rejected_leave_application.dart'; // Import the new file
import 'package:leave_management_app/screens/login_screen.dart'; // Import your login page

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Home'),
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              text: 'Apply for Leave',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ApplyLeavePage()),
                );
              },
            ),
            CustomButton(
              text: 'View Attendance',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewEditAttendancePage()),
                );
              },
            ),
            CustomButton(
              text: 'View Fines',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewFinesPage()),
                );
              },
            ),
            CustomButton(
              text: 'View Notes',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewNotesPage()),
                );
              },
            ),
            CustomButton(
              text: 'Make Payments',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MakePaymentsPage()), // Navigate to MakePaymentsPage
                );
              },
            ),
            CustomButton(
              text: 'Approved Leave Applications',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ApprovedLeaveApplicationPage()), // Navigate to ApprovedLeaveApplicationPage
                );
              },
            ),
            CustomButton(
              text: 'Rejected Leave Applications',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RejectedLeaveApplicationPage()), // Navigate to RejectedLeaveApplicationPage
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: SizedBox(
        width: double.infinity, // Make the button wide
        height: 50, // Set a fixed height for the button
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white, // Text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Curved edges
            ),
            elevation: 2, // Light shadow effect
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
