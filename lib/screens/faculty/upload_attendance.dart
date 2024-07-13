import 'package:flutter/material.dart';
import 'package:leave_management_app/services/api_service.dart';

class UploadAttendancePage extends StatefulWidget {
  const UploadAttendancePage({super.key});

  @override
  _UploadAttendancePageState createState() => _UploadAttendancePageState();
}

class _UploadAttendancePageState extends State<UploadAttendancePage> {
  final Map<String, String> subjectColumnMap = {
    'Full Stack Development (Python Django)': 'full_stack_python_django',
    'Software Engineering and Project Management':
        'software_engineering_project_management',
    'Full Stack Development (Python Django) Laboratory':
        'full_stack_python_django_lab',
    'Computer Graphics': 'computer_graphics',
    'Advanced Java Programming': 'advanced_java_programming',
    'Computer Graphics Laboratory': 'computer_graphics_lab',
    'Soft Skills': 'soft_skills',
    'Mini Project Laboratory': 'mini_project_lab',
  };

  List<String> columns;
  String? selectedColumn;
  List<String> usernames = [];
  Map<String, TextEditingController> controllers = {};
  TextEditingController newUsernameController = TextEditingController();

  _UploadAttendancePageState()
      : columns = [
          'Full Stack Development (Python Django)',
          'Software Engineering and Project Management',
          'Full Stack Development (Python Django) Laboratory',
          'Computer Graphics',
          'Advanced Java Programming',
          'Computer Graphics Laboratory',
          'Soft Skills',
          'Mini Project Laboratory',
        ];

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
      String? mappedColumn = subjectColumnMap[selectedColumn];
      if (mappedColumn == null) {
        throw Exception('Selected subject not mapped to a column');
      }

      await ApiService().uploadAttendance(mappedColumn, attendanceData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Attendance uploaded successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload attendance: $e')),
      );
    }
  }

  void addNewStudent() async {
    String newUsername = newUsernameController.text.trim();
    if (newUsername.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a username')),
      );
      return;
    }

    try {
      await ApiService().addStudent(newUsername);
      newUsernameController.clear();
      fetchUsernames();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Student added successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add student: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Attendance'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            style: TextStyle(fontSize: 16),
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
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            TextField(
              controller: newUsernameController,
              decoration: InputDecoration(
                labelText: 'Enter new student USN',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: addNewStudent,
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
