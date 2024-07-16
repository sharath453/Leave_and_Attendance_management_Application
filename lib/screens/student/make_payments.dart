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
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                'Select the Payment Application',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),

              // Google Pay button
              ElevatedButton(
                onPressed: _launchGooglePay,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                  elevation: 5,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/google_pay_logo.png',
                      height: 30, // Adjust the height as needed
                    ),
                    SizedBox(width: 10),
                    Text('Google Pay'),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Paytm button
              ElevatedButton(
                onPressed: _launchPaytm,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                  elevation: 5,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/paytm_logo.png',
                      height: 30, // Adjust the height as needed
                    ),
                    SizedBox(width: 10),
                    Text('Paytm'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
