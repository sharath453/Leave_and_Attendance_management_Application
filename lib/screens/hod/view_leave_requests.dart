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
                                String username =
                                    leaveRequests[index]['username'];
                                approveLeave(username);
                              },
                              child: Text('Approve'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                String username =
                                    leaveRequests[index]['username'];
                                rejectLeave(username); // Updated method call
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

  void approveLeave(String username) {
    try {
      _apiService.markLeaveAsApproved(username).then((_) {
        setState(() {
          fetchLeaveRequests(); // Refresh the leave requests list
          showMessage('Leave Approved');
        });
      }).catchError((error) {
        showErrorDialog('Failed to approve leave: $error');
      });
    } catch (e) {
      showErrorDialog('Failed to approve leave: $e');
    }
  }

  void rejectLeave(String username) {
    try {
      _apiService.markLeaveAsRejected(username).then((_) {
        setState(() {
          fetchLeaveRequests(); // Refresh the leave requests list
          showMessage('Leave Rejected');
        });
      }).catchError((error) {
        showErrorDialog('Failed to reject leave: $error');
      });
    } catch (e) {
      showErrorDialog('Failed to reject leave: $e');
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2), // Display for 2 seconds
      ),
    );
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
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
