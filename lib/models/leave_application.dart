class LeaveApplication {
  final int leaveId;
  final int studentId;
  final DateTime startDate;
  final DateTime endDate;
  final String reason;
  final String status;
  final int hodId;

  LeaveApplication({
    required this.leaveId,
    required this.studentId,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.status,
    required this.hodId,
  });

  factory LeaveApplication.fromJson(Map<String, dynamic> json) {
    return LeaveApplication(
      leaveId: json['leave_id'],
      studentId: json['student_id'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      reason: json['reason'],
      status: json['status'],
      hodId: json['hod_id'],
    );
  }
}
