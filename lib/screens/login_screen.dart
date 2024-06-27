import 'package:flutter/material.dart';
import 'package:leave_management_app/screens/faculty/faculty_home.dart';
import 'package:leave_management_app/screens/hod/hod_home.dart';
import 'package:leave_management_app/screens/student/student_home.dart';
import 'package:leave_management_app/screens/register_page.dart';
import 'package:leave_management_app/services/api_service.dart';
import 'package:leave_management_app/widgets/my_button.dart';
import 'package:leave_management_app/widgets/my_text_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiService apiService = ApiService();

  void signUserIn(BuildContext context) async {
    String username = usernameController.text;
    String password = passwordController.text;

    if (username.isNotEmpty && password.isNotEmpty) {
      try {
        final data = await apiService.login(username, password);

        // Debugging output
        print('Login API response: $data');

        if (data.containsKey('role')) {
          String role = data['role'];

          if (role == "student") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => StudentHomePage(),
              ),
            );
          } else if (role == "faculty") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => FacultyHomePage(),
              ),
            );
          } else if (role == "hod") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HodHomePage(),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Invalid role.'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        } else if (data.containsKey('message')) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data['message']),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Invalid response from server.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        // Enhanced error handling
        print('Error during login: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter both username and password.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void navigateToRegisterPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Image.asset(
                  'assets/images/college_logo.png',
                  height: 250,
                ),
                const SizedBox(height: 50),
                Text(
                  'Welcome back, you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                MyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                MyButton(
                  onTap: () => signUserIn(context),
                  label: 'Sign In',
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => navigateToRegisterPage(context),
                  child: Text('Don\'t have an account? Register here'),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
