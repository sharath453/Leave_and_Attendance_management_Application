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
                return ListTile(
                  title: Text('Leave Request ${index + 1}'),
                  subtitle: Text('Reason: ${leaveRequests[index]['reason']}'),
                  // Add more details as needed
                );
              },
            ),
    );
  }
}
