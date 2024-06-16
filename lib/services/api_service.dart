import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ApiService {
  static const String baseUrl = Constants.baseUrl;

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login.php'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to log in: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to log in: $e');
    }
  }

  Future<List<dynamic>> fetchLeaveApplications(int hodId) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/get_leave_applications.php?hod_id=$hodId'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Failed to fetch leave applications: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to fetch leave applications: $e');
    }
  }

  Future<List<dynamic>> fetchAttendanceData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/get_attendance.php'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Failed to fetch attendance data: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to fetch attendance data: $e');
    }
  }

  Future<List<dynamic>> fetchFines() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/get_fines.php'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to fetch fines: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to fetch fines: $e');
    }
  }

  Future<void> uploadAttendance(
      int studentId, String subject, double attendancePercentage) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/upload_attendance.php'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'student_id': studentId,
          'subject': subject,
          'attendance_percentage': attendancePercentage,
        }),
      );
      if (response.statusCode != 200) {
        throw Exception(
            'Failed to upload attendance: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to upload attendance: $e');
    }
  }

  Future<void> applyLeave(
      int studentId, String startDate, String endDate, String reason) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/apply_leave.php'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'student_id': studentId,
          'start_date': startDate,
          'end_date': endDate,
          'reason': reason,
        }),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to apply for leave: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to apply for leave: $e');
    }
  }
}
