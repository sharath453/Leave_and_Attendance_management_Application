import 'package:flutter/material.dart';
import 'package:leave_management_app/services/api_service.dart';

class UploadAttendancePage extends StatefulWidget {
  const UploadAttendancePage({super.key});

  @override
  _UploadAttendancePageState createState() => _UploadAttendancePageState();
}

class _UploadAttendancePageState extends State<UploadAttendancePage> {
  final ApiService apiService = ApiService();
  String? selectedSubject;
  int totalClassesConducted = 0;
  Map<String, int> attendanceMap = {};
  List<String> usernames = [];

  @override
  void initState() {
    super.initState();
    fetchUsernames();
  }

  // Fetch usernames from the database
  Future<void> fetchUsernames() async {
    try {
      List<String> fetchedUsernames = await apiService.fetchUsernames();
      setState(() {
        usernames = fetchedUsernames;
      });
    } catch (e) {
      print('Error fetching usernames: $e');
      // Handle error gracefully, e.g., show a dialog to the user
    }
  }

  // Submit attendance to the server
  void submitAttendance() async {
    try {
      if (selectedSubject == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a subject')),
        );
        return;
      }

      // Validate totalClassesConducted
      if (totalClassesConducted <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Total classes conducted should be greater than zero')),
        );
        return;
      }

      for (int i = 0; i < usernames.length; i++) {
        String username = usernames[i];
        int attendedClasses = attendanceMap[username] ?? 0;
        double attendancePercentage =
            (attendedClasses / totalClassesConducted) * 100;
        await apiService.uploadAttendance(
            username, selectedSubject!, attendancePercentage);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Attendance submitted successfully')),
      );
    } catch (e) {
      print('Error uploading attendance: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit attendance')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Attendance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'Select Subject',
                border: OutlineInputBorder(),
              ),
              value: selectedSubject,
              onChanged: (String? newValue) {
                setState(() {
                  selectedSubject = newValue!;
                });
              },
              items: [
                'Full Stack Development (Python Django)',
                'Software Engineering and Project Management',
                'Full Stack Development (Python Django) Laboratory',
                'Computer Graphics',
                'Advanced Java Programming',
                'Computer Graphics Laboratory',
                'Soft Skills',
                'Mini Project Laboratory',
              ].map<DropdownMenuItem<String>>((String subject) {
                return DropdownMenuItem<String>(
                  value: subject,
                  child: Text(subject),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Total Classes Conducted',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  totalClassesConducted = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: usernames.length,
                itemBuilder: (context, index) {
                  String username = usernames[index];
                  return ListTile(
                    title: Text(username),
                    subtitle: TextField(
                      decoration: InputDecoration(
                        labelText: 'Classes Attended',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          attendanceMap[username] = int.tryParse(value) ?? 0;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: submitAttendance,
              child: Text('Submit Attendance'),
            ),
          ],
        ),
      ),
    );
  }
}
