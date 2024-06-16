import 'package:flutter/material.dart';

class FineCard extends StatelessWidget {
  final Map<String, dynamic> fine;

  FineCard({required this.fine});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(fine['description']),
        subtitle: Text('Amount: \$${fine['amount']}'),
      ),
    );
  }
}
