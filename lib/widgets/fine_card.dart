import 'package:flutter/material.dart';

class FineCard extends StatelessWidget {
  final Map<String, dynamic> fine;

  const FineCard({Key? key, required this.fine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title: Text('User: ${fine['username']}'),
        subtitle: Text('Fine Amount: ${fine['fine_amount']}'),
      ),
    );
  }
}
