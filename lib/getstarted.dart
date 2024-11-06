import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizzapp/login.dart';
import 'package:quizzapp/register.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GetStartedPageState createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2F6609), Color(0xFFC1FFB1), Color(0xFF2F6609)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          children: [
            SizedBox(height: 60),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: const Image(image: AssetImage('assets/getstarted.png')),
              ),
            ),
            SizedBox(height: screenHeight * 0.08),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
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
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black)),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Patgebra',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Learning Patterns \n',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'and Algebra',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: screenHeight * 0.08),
            _buildLoginButton('LOGIN'),
            SizedBox(height: screenHeight * 0.04),
            _buildLoginButton('SIGN UP'),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton(String label) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 80),
      child: Container(
        decoration: BoxDecoration(
          color: label == 'LOGIN'
              ? Color.fromARGB(255, 17, 215, 60)
              : Color.fromARGB(255, 106, 254, 138),
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => label == 'LOGIN'
                        ? const LoginPage()
                        : const RegisterPage()));
          },
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
