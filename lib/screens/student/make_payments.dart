import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MakePaymentsPage extends StatelessWidget {
  const MakePaymentsPage({super.key});

  void _launchGooglePay() async {
    const url = 'googlepay://'; // URL scheme for Google Pay
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch Google Pay';
    }
  }

  void _launchPaytm() async {
    const url = 'paytm://'; // URL scheme for Paytm
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch Paytm';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Make Payments'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _launchGooglePay,
              child: Image.asset(
                'assets/images/google_pay_logo.png',
                height: 50, // Adjust the height as needed
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _launchPaytm,
              child: Image.asset(
                'assets/images/paytm_logo.png',
                height: 50, // Adjust the height as needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
