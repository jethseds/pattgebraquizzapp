import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:video_player/video_player.dart';

class Understandingalgebraicexpression extends StatefulWidget {
  const Understandingalgebraicexpression({super.key});

  @override
  _Understandingalgebraicexpression createState() =>
      _Understandingalgebraicexpression();
}

class _Understandingalgebraicexpression
    extends State<Understandingalgebraicexpression> {
  late VideoPlayerController _controller;
  void initState() {
    super.initState();
    // Initialize the video player controller with a video URL
    _controller = VideoPlayerController.asset('assets/Algebraic_Expression.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
      });
    _loadBookmarkStatus();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is removed from the widget tree
    _controller.dispose();
    super.dispose();
  }

  String mark = "unmark";

// Load bookmark status from local storage
  Future<void> _loadBookmarkStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mark = prefs.getString('mark3') ?? 'unmark';
    });
  }

// Toggle bookmark status and save to local storage
  Future<void> _toggleBookmark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mark = (mark == "mark") ? "unmark" : "mark";
    });
    prefs.setString('mark3', mark);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Center(
                  child: _controller.value.isInitialized
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _controller.value.isPlaying
                                      ? _controller.pause()
                                      : _controller.play();
                                });
                              },
                              child: Icon(
                                _controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        )
                      : CircularProgressIndicator(), // Show a loading indicator until the video is initialized
                ),
                Positioned(
                  child: Container(
                    margin: EdgeInsets.only(top: 30, left: 20),
                    alignment: Alignment.bottomLeft,
                    child: GestureDetector(
                      child: FaIcon(
                        FontAwesomeIcons.arrowLeft,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Algebraic Expression',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      Center(
                        child: SizedBox(
                            width: 50,
                            child: GestureDetector(
                              child: FaIcon(
                                mark == "mark"
                                    ? FontAwesomeIcons.solidBookmark
                                    : FontAwesomeIcons.bookmark,
                                color: Color(0xFF2F6609),
                              ),
                              onTap: _toggleBookmark,
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Understanding Algebraic Expressions',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2F6609),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Introduction to Algebraic Expressions',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2F6609),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '• An algebraic expression is a combination of numbers, variables, and operation symbols without an equal sign. These expressions are fundamental in algebra for computations and problem-solving.',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Components of an Algebraic Expression',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2F6609),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '• Constants: Fixed numbers, e.g., 5, -3, 7.2\n'
                        '• Variables: Symbols representing unknown values, e.g., x, y, z\n'
                        '• Coefficients: Numbers that multiply variables, e.g., in 3x, 3 is the coefficient\n'
                        '• Operators: Symbols indicating operations, e.g., +, −, *, /',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Examples of Algebraic Expressions',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2F6609),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '• Expression 1: 3x + 2\n'
                        '  o Coefficient: 3\n'
                        '  o Variable: x\n'
                        '  o Operator: +\n'
                        '  o Constant: 2\n'
                        '• Expression 2: 4y - 7\n'
                        '  o Coefficient: 4\n'
                        '  o Variable: y\n'
                        '  o Operator: -\n'
                        '  o Constant: 7',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Types of Algebraic Expressions',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2F6609),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '• Monomial: One term (e.g., 5x)\n'
                        '• Binomial: Two terms (e.g., 3x + 2)\n'
                        '• Trinomial: Three terms (e.g., 2x^2 + 3x + 5)',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Common Keywords and Their Meanings',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2F6609),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Phrase                        Operation\n'
                        'Sum of                       Addition (+)\n'
                        'Difference of                Subtraction (−)\n'
                        'Product of                   Multiplication (×)\n'
                        'Quotient of                  Division (÷)\n'
                        'Is equal to                  Equals (=)\n'
                        'More than                    Addition (+)\n'
                        'Less than                    Subtraction (−)\n'
                        'Twice a number               Multiplication by 2 (×2)\n'
                        'Three times a number         Multiplication by 3 (×3)',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Translating Phrases into Algebraic Expressions',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2F6609),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Steps to Translate:\n'
                        '• Identify Keywords\n'
                        '• Assign a Variable\n'
                        '• Combine Elements',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Examples of Translation\n'
                        'Example 1: "The sum of a number and 8" -> x + 8\n'
                        'Example 2: "Five less than a number" -> y - 5\n'
                        'Example 3: "Three times a number increased by 4" -> 3z + 4',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Practice Questions\n'
                        '• Difference between a number and 10: x - 10\n'
                        '• Product of 6 and a number: 6y\n'
                        '• Number divided by 2: z / 2\n'
                        '• Eight more than twice a number: 2x + 8\n'
                        '• Sum of a number and 12 is 20: x + 12',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                      ),
                    ],
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
