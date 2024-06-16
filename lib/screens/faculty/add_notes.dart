import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class AddNotesPage extends StatefulWidget {
  @override
  _AddNotesPageState createState() => _AddNotesPageState();
}

class _AddNotesPageState extends State<AddNotesPage> {
  final ApiService apiService = ApiService();
  String? selectedSubject;
  File? selectedFile;

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

  void selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    }
  }

  void uploadNotes() async {
    if (selectedSubject == null || selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a subject and a file')),
      );
      return;
    }

    try {
      await apiService.uploadNotes(
          1, selectedSubject!, selectedFile!.path); // Use actual facultyId
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Notes uploaded successfully')),
      );
      setState(() {
        selectedSubject = null;
        selectedFile = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload notes: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Notes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
              items: subjects.map<DropdownMenuItem<String>>((String subject) {
                return DropdownMenuItem<String>(
                  value: subject,
                  child: Text(subject),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectFile,
              child: Text(selectedFile == null
                  ? 'Select PDF File'
                  : 'File Selected: ${selectedFile!.path.split('/').last}'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: uploadNotes,
              child: Text('Upload Notes'),
            ),
          ],
        ),
      ),
    );
  }
}
