import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizzapp/register.dart';
import 'package:quizzapp/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isPasswordObscured = true;
  @override
  void initState() {
    super.initState();
    // Lock orientation to portrait mode for this screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    // Load saved username and password from local storage
    _loadCredentials();
  }

  @override
  void dispose() {
    // Restore the default orientation when this screen is disposed
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitDown,
    ]);
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Method to load saved credentials from local storage
  Future<void> _loadCredentials() async {
    // setState(() {
    //   emailController.text = prefs.getString('username') ?? '';
    //   passwordController.text = prefs.getString('password') ?? '';
    // });
  }

  // Method to save credentials to local storage
  Future<void> _saveCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', emailController.text);
    await prefs.setString('password', passwordController.text);
  }

  // Method to validate credentials
  void _validateLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fibonaccipretestCompleted', 'pending');
    await prefs.setString('algebraicexpressionpretestCompleted', 'pending');
    await prefs.setString('algebraicequationpretestCompleted', 'pending');
    await prefs.setString('solvingequationpretestCompleted', 'pending');

    String? savedUsername = prefs.getString('username');
    String? savedPassword = prefs.getString('password');

    if (savedUsername != null &&
        savedPassword != null &&
        emailController.text == savedUsername &&
        passwordController.text == savedPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Successful')),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WelcomePage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid Username or Password')),
      );
    }

    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => WelcomePage()));
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
            SizedBox(height: screenHeight * 0.15),
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
            _buildTextField(
              controller: emailController,
              labelText: 'Username',
              icon: Icons.email,
            ),
            SizedBox(height: screenHeight * 0.02),
            _buildTextField(
              controller: passwordController,
              labelText: 'Password',
              icon: Icons.remove_red_eye,
              obscureText: true,
              isPassword: true,
            ),
            SizedBox(height: screenHeight * 0.04),
            Container(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 80),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xDDaafa42),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextButton(
                  onPressed: () async {
                    _validateLogin();

                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => WelcomePage()));
                  },
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
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
                "Don't have an account?",
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
                  "SIGN UP",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterPage()));
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
    bool obscureText = false,
    bool isPassword = false,
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
                obscureText: isPassword ? _isPasswordObscured : obscureText,
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
                isPassword
                    ? (_isPasswordObscured
                        ? Icons.visibility
                        : Icons.visibility_off)
                    : icon,
                color: Colors.black,
              ),
              onPressed: isPassword
                  ? () {
                      setState(() {
                        _isPasswordObscured = !_isPasswordObscured;
                      });
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
