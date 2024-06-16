class Fine {
  final int fineId;
  final int studentId;
  final double amount;
  final String description;

  Fine({
    required this.fineId,
    required this.studentId,
    required this.amount,
    required this.description,
  });

  factory Fine.fromJson(Map<String, dynamic> json) {
    return Fine(
      fineId: json['fine_id'],
      studentId: json['student_id'],
      amount: json['amount'],
      description: json['description'],
    );
  }
}
