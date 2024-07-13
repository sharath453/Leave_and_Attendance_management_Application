import 'package:flutter/material.dart';
import 'package:leave_management_app/services/api_service.dart';

class UploadAttendancePage extends StatefulWidget {
  const UploadAttendancePage({super.key});

  @override
  _UploadAttendancePageState createState() => _UploadAttendancePageState();
}

class _UploadAttendancePageState extends State<UploadAttendancePage> {
  final List<String> columns = [
    'Full Stack Development (Python Django)',
    'Software Engineering and Project Management',
    'Full Stack Development (Python Django) Laboratory',
    'Computer Graphics',
    'Advanced Java Programming',
    'Computer Graphics Laboratory',
    'Soft Skills',
    'Mini Project Laboratory',
  ];

  String? selectedColumn;
  List<String> usernames = [];
  Map<String, TextEditingController> controllers = {};
  final TextEditingController newStudentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUsernames();
  }

  void fetchUsernames() async {
    try {
      List<String> fetchedUsernames = await ApiService().fetchUsernames();
      setState(() {
        usernames = fetchedUsernames;
        for (var username in usernames) {
          controllers[username] = TextEditingController();
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching usernames: $e')),
      );
    }
  }

  void addStudent() async {
    String newStudentUsername = newStudentController.text.trim();
    if (newStudentUsername.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid username')),
      );
      return;
    }

    try {
      await ApiService().addStudent(newStudentUsername);
      setState(() {
        usernames.add(newStudentUsername);
        controllers[newStudentUsername] = TextEditingController();
        newStudentController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Student added successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add student: $e')),
      );
    }
  }

  void submitAttendance() async {
    if (selectedColumn == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a subject')),
      );
      return;
    }

    Map<String, double> attendanceData = {};
    for (var username in usernames) {
      attendanceData[username] =
          double.tryParse(controllers[username]!.text) ?? 0;
    }

    try {
      await ApiService().uploadAttendance(selectedColumn!, attendanceData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Attendance uploaded successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload attendance: $e')),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              hint: Text('Select Subject'),
              value: selectedColumn,
              isExpanded: true,
              onChanged: (newValue) {
                setState(() {
                  selectedColumn = newValue;
                });
              },
              items: columns.map((column) {
                return DropdownMenuItem<String>(
                  value: column,
                  child: Text(column),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: usernames.length,
                itemBuilder: (context, index) {
                  String username = usernames[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            username,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: controllers[username],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Attendance %',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: newStudentController,
              decoration: InputDecoration(
                labelText: 'Add New Student',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: addStudent,
                  child: Text('Add Student'),
                ),
                ElevatedButton(
                  onPressed: submitAttendance,
                  child: Text('Submit Attendance'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
