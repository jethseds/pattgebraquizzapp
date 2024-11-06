import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizzapp/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitDown,
    ]);
    usernameController.dispose();
    passwordController.dispose();
    confirmpasswordController
        .dispose(); // Don't forget to dispose this controller
    super.dispose();
  }

  Future<void> saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', usernameController.text);
    await prefs.setString('password', passwordController.text);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Credentials saved successfully!')),
    );
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
                'Patgebra',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            Container(
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
                        controller: usernameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Username',
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
                        Icons.email,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            _buildTextField(
              controller: passwordController,
              labelText: 'Password',
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
            SizedBox(height: screenHeight * 0.04),
            Container(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 80),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 17, 215, 60),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextButton(
                  onPressed: saveCredentials,
                  child: Text(
                    'SIGN UP',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            Center(
              child: Text(
                "Already have an account?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            GestureDetector(
              child: Center(
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
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
