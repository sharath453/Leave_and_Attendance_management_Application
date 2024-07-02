import 'package:flutter/material.dart';
import 'package:leave_management_app/services/api_service.dart';

class ViewLeaveRequestsPage extends StatefulWidget {
  @override
  _ViewLeaveRequestsPageState createState() => _ViewLeaveRequestsPageState();
}

class _ViewLeaveRequestsPageState extends State<ViewLeaveRequestsPage> {
  final ApiService _apiService = ApiService();
  List<dynamic> leaveRequests = [];

  @override
  void initState() {
    super.initState();
    fetchLeaveRequests();
  }

  Future<void> fetchLeaveRequests() async {
    try {
      final response = await _apiService.viewLeaveApplications('4AL21CS');
      setState(() {
        leaveRequests = response;
      });
    } catch (e) {
      // Handle error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to fetch leave requests: $e'),
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
        title: Text('View Leave Requests'),
      ),
      body: leaveRequests.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: leaveRequests.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username: ${leaveRequests[index]['username']}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Start Date: ${leaveRequests[index]['start_date']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'End Date: ${leaveRequests[index]['end_date']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Reason: ${leaveRequests[index]['reason']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                int leaveId = leaveRequests[index]['leave_id'];
                                approveLeave(leaveId);
                              },
                              child: Text('Approve'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                int leaveId = leaveRequests[index]['leave_id'];
                                rejectLeave(leaveId);
                              },
                              child: Text('Reject'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  void approveLeave(int leaveId) {
    try {
      _apiService.markLeaveAsApproved(leaveId).then((value) {
        // Update UI or show success message if needed
        fetchLeaveRequests(); // Refresh the leave requests list
      }).catchError((error) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to approve leave: $error'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to approve leave: $e'),
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

  void rejectLeave(int leaveId) {
    try {
      _apiService.markLeaveAsRejected(leaveId).then((value) {
        // Update UI or show success message if needed
        fetchLeaveRequests(); // Refresh the leave requests list
      }).catchError((error) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to reject leave: $error'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to reject leave: $e'),
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
}
