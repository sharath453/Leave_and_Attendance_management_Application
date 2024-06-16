import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class UploadAttendancePage extends StatefulWidget {
  @override
  _UploadAttendancePageState createState() => _UploadAttendancePageState();
}

class _UploadAttendancePageState extends State<UploadAttendancePage> {
  final ApiService apiService = ApiService();
  String? selectedSubject;
  int totalClassesConducted = 0;
  Map<int, int> attendedClasses = {};
  final List<String> subjects = [
    'Full Stack Development (Python Django)',
    'Software Engineering and Project Management',
    'Full Stack Development (Python Django) Laboratory',
    'Computer Graphics',
    'Advanced Java Programming',
    'Computer Graphics Laboratory',
    'Soft Skills',
    'Mini Project Laboratory',
  ];

  void submitAttendance() async {
    attendedClasses.forEach((studentId, attended) async {
      double attendancePercentage = (attended / totalClassesConducted) * 100;
      await apiService.uploadAttendance(
          studentId, selectedSubject!, attendancePercentage);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Attendance submitted successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Attendance'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
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
                items: subjects.map<DropdownMenuItem<String>>((String subject) {
                  return DropdownMenuItem<String>(
                    value: subject,
                    child: Text(subject),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Total Classes Conducted',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    totalClassesConducted = int.parse(value);
                  });
                },
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount:
                    10, // Assuming 10 students, modify as per actual data
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Student $index'),
                    subtitle: TextField(
                      decoration: InputDecoration(
                        labelText: 'Classes Attended',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          attendedClasses[index] = int.parse(value);
                        });
                      },
                    ),
                  );
                },
              ),
              ElevatedButton(
                onPressed: submitAttendance,
                child: Text('Submit Attendance'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
