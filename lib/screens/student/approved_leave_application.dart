import 'package:flutter/material.dart';
import 'package:leave_management_app/services/api_service.dart';

class ApprovedLeaveApplicationPage extends StatefulWidget {
  const ApprovedLeaveApplicationPage({super.key});

  @override
  _ApprovedLeaveApplicationPageState createState() =>
      _ApprovedLeaveApplicationPageState();
}

class _ApprovedLeaveApplicationPageState
    extends State<ApprovedLeaveApplicationPage> {
  final ApiService _apiService = ApiService();
  List<dynamic> approvedLeaveApplications = [];

  @override
  void initState() {
    super.initState();
    fetchApprovedLeaveApplications();
  }

  Future<void> fetchApprovedLeaveApplications() async {
    try {
      final response = await _apiService.fetchApprovedLeaveApplications();
      setState(() {
        approvedLeaveApplications = response;
      });
    } catch (e) {
      // Handle error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to fetch approved leave applications: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Approved Leave Applications'),
      ),
      body: approvedLeaveApplications.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: approvedLeaveApplications.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username: ${approvedLeaveApplications[index]['username']}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Start Date: ${approvedLeaveApplications[index]['start_date']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'End Date: ${approvedLeaveApplications[index]['end_date']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Reason: ${approvedLeaveApplications[index]['reason']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
