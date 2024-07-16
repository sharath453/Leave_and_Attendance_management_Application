import 'package:flutter/material.dart';
import 'package:leave_management_app/services/api_service.dart'; // Replace with your actual import path

class ApplyLeavePage extends StatefulWidget {
  const ApplyLeavePage({super.key});

  @override
  _ApplyLeavePageState createState() => _ApplyLeavePageState();
}

class _ApplyLeavePageState extends State<ApplyLeavePage> {
  final TextEditingController _usnController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  final ApiService _apiService = ApiService(); // Instantiate your ApiService

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _usnController.addListener(_validateForm);
    _startDateController.addListener(_validateForm);
    _endDateController.addListener(_validateForm);
    _reasonController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isButtonEnabled = _usnController.text.isNotEmpty &&
          _startDateController.text.isNotEmpty &&
          _endDateController.text.isNotEmpty &&
          _reasonController.text.isNotEmpty;
    });
  }

  Future<void> applyForLeave() async {
    final String usn = _usnController.text.toUpperCase();
    final String startDate = _startDateController.text;
    final String endDate = _endDateController.text;
    final String reason = _reasonController.text;

    // Regular expression to match the USN format
    final RegExp usnRegExp = RegExp(r'^4AL21CS\d{3}$');

    if (!usnRegExp.hasMatch(usn)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Invalid USN format'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    // Extract the numeric part from USN (e.g., '001' from '4AL21CS001')
    final studentIdString =
        usn.substring(7); // Extracts '001' from '4AL21CS001'
    final studentId = int.tryParse(studentIdString);

    if (studentId == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Invalid USN format'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    try {
      await _apiService.applyLeave(studentId, startDate, endDate, reason);
      // If successful, show a success dialog or navigate to another screen
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Leave application submitted successfully'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      // If failed, show an error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to submit leave application: $e'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _startDateController.text = picked.toString().split(' ')[0];
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _endDateController.text = picked.toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apply for Leave'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _usnController,
              decoration: InputDecoration(labelText: 'USN'),
            ),
            TextFormField(
              controller: _startDateController,
              onTap: () => _selectStartDate(context),
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Start Date',
                suffixIcon: Icon(Icons.calendar_today),
              ),
            ),
            TextFormField(
              controller: _endDateController,
              onTap: () => _selectEndDate(context),
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'End Date',
                suffixIcon: Icon(Icons.calendar_today),
              ),
            ),
            TextFormField(
              controller: _reasonController,
              decoration: InputDecoration(labelText: 'Reason'),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity, // Make the button wide
              height: 50, // Set a fixed height for the button
              child: ElevatedButton(
                onPressed: _isButtonEnabled ? applyForLeave : null,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Curved edges
                  ),
                  elevation: 2, // Light shadow effect
                ),
                child: Text(
                  'Apply',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usnController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _reasonController.dispose();
    super.dispose();
  }
}
