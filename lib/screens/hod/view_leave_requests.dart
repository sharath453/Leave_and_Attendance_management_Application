import 'package:flutter/material.dart';
import 'package:leave_management_app/services/api_service.dart';

class ViewLeaveRequestsPage extends StatefulWidget {
  @override
  _ViewLeaveRequestsPageState createState() => _ViewLeaveRequestsPageState();
}

class _ViewLeaveRequestsPageState extends State<ViewLeaveRequestsPage> {
  final ApiService _apiService = ApiService();
  List<dynamic> leaveRequests = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLeaveRequests();
  }

  Future<void> fetchLeaveRequests() async {
    try {
      final response = await _apiService.viewLeaveApplications('4AL21CS');
      setState(() {
        leaveRequests = response
            .map((request) => {...request, 'processed': false})
            .toList();
        isLoading = false;
      });
    } catch (e) {
      // Handle error
      setState(() {
        isLoading = false;
      });
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : leaveRequests.isEmpty
              ? Center(child: Text('No recent leave applications found.'))
              : ListView.builder(
                  itemCount: leaveRequests.length,
                  itemBuilder: (context, index) {
                    final request = leaveRequests[index];
                    final isProcessed = request['processed'];

                    return Card(
                      margin: EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Username: ${request['username']}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Start Date: ${request['start_date']}',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'End Date: ${request['end_date']}',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Reason: ${request['reason']}',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: isProcessed
                                      ? null
                                      : () => approveLeave(index),
                                  child: Text('Approve'),
                                ),
                                ElevatedButton(
                                  onPressed: isProcessed
                                      ? null
                                      : () => rejectLeave(index),
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

  void approveLeave(int index) {
    final username = leaveRequests[index]['username'];
    try {
      _apiService.markLeaveAsApproved(username).then((value) {
        setState(() {
          leaveRequests[index]['processed'] = true;
          showMessage('Leave Approved');
        });
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

  void rejectLeave(int index) {
    final username = leaveRequests[index]['username'];
    try {
      _apiService.markLeaveAsRejected(username).then((value) {
        setState(() {
          leaveRequests[index]['processed'] = true;
          showMessage('Leave Rejected');
        });
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

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
