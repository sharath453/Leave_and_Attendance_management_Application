import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:leave_management_app/services/api_service.dart';
import 'package:leave_management_app/utils/constants.dart';

class ViewNotesPage extends StatefulWidget {
  @override
  _ViewNotesPageState createState() => _ViewNotesPageState();
}

class _ViewNotesPageState extends State<ViewNotesPage> {
  final ApiService apiService = ApiService();
  List<dynamic> notesList = [];

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  void fetchNotes() async {
    // Replace studentId with the actual student ID
    int studentId = 1;
    List<dynamic> notes = await apiService.fetchNotes(studentId);
    setState(() {
      notesList = notes;
    });
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Notes'),
      ),
      body: ListView.builder(
        itemCount: notesList.length,
        itemBuilder: (context, index) {
          final note = notesList[index];
          return ListTile(
            title: Text('${note['subject']}'),
            subtitle: Text('Uploaded at: ${note['uploaded_at']}'),
            trailing: IconButton(
              icon: Icon(Icons.download),
              onPressed: () {
                _launchURL('${Constants.baseUrl}/${note['file_path']}');
              },
            ),
          );
        },
      ),
    );
  }
}
