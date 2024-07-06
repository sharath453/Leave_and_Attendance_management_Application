import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../widgets/fine_card.dart';

class ViewFinesPage extends StatelessWidget {
  final ApiService apiService = ApiService();

  ViewFinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fines'),
      ),
      body: FutureBuilder(
        future: apiService.fetchFines(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          List finesData = snapshot.data as List;
          return ListView.builder(
            itemCount: finesData.length,
            itemBuilder: (context, index) {
              return FineCard(fine: finesData[index]);
            },
          );
        },
      ),
    );
  }
}
