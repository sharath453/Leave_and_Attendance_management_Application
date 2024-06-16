class Attendance {
  final int attendanceId;
  final int studentId;
  final String subject;
  final double attendancePercentage;
  final int uploadedBy;

  Attendance({
    required this.attendanceId,
    required this.studentId,
    required this.subject,
    required this.attendancePercentage,
    required this.uploadedBy,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      attendanceId: json['attendance_id'],
      studentId: json['student_id'],
      subject: json['subject'],
      attendancePercentage: json['attendance_percentage'],
      uploadedBy: json['uploaded_by'],
    );
  }
}
