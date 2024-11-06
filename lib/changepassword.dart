import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizzapp/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final currentpasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;
  bool _isCurrentPasswordObscured = true;
  String currentpassword = "";

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    _loadData();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitDown,
    ]);
    currentpasswordController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentpassword = prefs.getString('password') ?? '';
      print(currentpassword);
    });
  }

  Future<void> saveCredentials() async {
    if (passwordController.text != "") {
      if (currentpassword == currentpasswordController.text) {
        if (passwordController.text != confirmpasswordController.text) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text('Password Not Match'),
            ),
          );
        } else {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('password', passwordController.text);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Change Password successfully!')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Current Password Not Match'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Required Input Password'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2F6609), Color(0xFFC1FFB1), Color(0xFF2F6609)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30, left: 20),
              alignment: Alignment.bottomLeft,
              child: GestureDetector(
                child: FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.white),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(height: screenHeight * 0.1),
            Center(
              child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width / 3.5,
                height: MediaQuery.of(context).size.width / 3.5,
                decoration: BoxDecoration(
                    color: Color(0xDDaafa42),
                    borderRadius: BorderRadius.circular(20)),
                child: const Image(
                  image: AssetImage('assets/brain.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            const Center(
              child: Text(
                'Change Password',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            SizedBox(height: screenHeight * 0.02),
            _buildTextField(
              controller: currentpasswordController,
              labelText: 'Current Password',
              icon: Icons.remove_red_eye,
              obscureText:
                  _isCurrentPasswordObscured, // Pass the visibility state
              toggleVisibility: () {
                setState(() {
                  _isCurrentPasswordObscured = !_isCurrentPasswordObscured;
                });
              },
            ),
            SizedBox(height: screenHeight * 0.02),
            _buildTextField(
              controller: passwordController,
              labelText: 'New Password',
              icon: Icons.remove_red_eye,
              obscureText: _isPasswordObscured, // Pass the visibility state
              toggleVisibility: () {
                setState(() {
                  _isPasswordObscured = !_isPasswordObscured;
                });
              },
            ),
            SizedBox(height: screenHeight * 0.02),
            _buildTextField(
              controller: confirmpasswordController,
              labelText: 'Confirm Password',
              icon: Icons.remove_red_eye,
              obscureText:
                  _isConfirmPasswordObscured, // Pass the visibility state
              toggleVisibility: () {
                setState(() {
                  _isConfirmPasswordObscured = !_isConfirmPasswordObscured;
                });
              },
            ),
            SizedBox(height: screenHeight * 0.02),
            Container(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 121, 255, 87),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: saveCredentials,
                  child: Text(
                    'Change Password',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    required bool obscureText,
    required VoidCallback toggleVisibility,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xddececec),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: controller,
                obscureText: obscureText,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: labelText,
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.black,
              ),
              onPressed: toggleVisibility,
            ),
          ),
        ],
      ),
    );
  }
}
