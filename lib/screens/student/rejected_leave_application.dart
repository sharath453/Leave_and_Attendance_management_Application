import 'package:flutter/material.dart';
import 'package:leave_management_app/services/api_service.dart';

class RejectedLeaveApplicationPage extends StatefulWidget {
  const RejectedLeaveApplicationPage({super.key});

  @override
  _RejectedLeaveApplicationPageState createState() =>
      _RejectedLeaveApplicationPageState();
}

class _RejectedLeaveApplicationPageState
    extends State<RejectedLeaveApplicationPage> {
  final ApiService _apiService = ApiService();
  List<dynamic> rejectedLeaveApplications = [];

  @override
  void initState() {
    super.initState();
    fetchRejectedLeaveApplications();
  }

  Future<void> fetchRejectedLeaveApplications() async {
    try {
      final response = await _apiService.fetchRejectedLeaveApplications();
      setState(() {
        rejectedLeaveApplications = response;
      });
    } catch (e) {
      // Handle error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to fetch rejected leave applications: $e'),
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
        title: Text('Rejected Leave Applications'),
      ),
      body: rejectedLeaveApplications.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: rejectedLeaveApplications.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username: ${rejectedLeaveApplications[index]['username']}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Start Date: ${rejectedLeaveApplications[index]['start_date']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'End Date: ${rejectedLeaveApplications[index]['end_date']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Reason: ${rejectedLeaveApplications[index]['reason']}',
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
