import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:video_player/video_player.dart';

class Understandingsolvingequation extends StatefulWidget {
  const Understandingsolvingequation({super.key});

  @override
  _Understandingsolvingequation createState() =>
      _Understandingsolvingequation();
}

class _Understandingsolvingequation
    extends State<Understandingsolvingequation> {
  late VideoPlayerController _controller;
  void initState() {
    super.initState();
    // Initialize the video player controller with a video URL
    _controller = VideoPlayerController.asset('assets/Solving_Equation.mp4')
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
      mark = prefs.getString('mark5') ?? 'unmark';
    });
  }

// Toggle bookmark status and save to local storage
  Future<void> _toggleBookmark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mark = (mark == "mark") ? "unmark" : "mark";
    });
    prefs.setString('mark5', mark);
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
                        'Solving Equation',
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
                        'Topic: Translating Verbal Phrases into Equations and Solving Equation',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2F6609),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Understanding Verbal Phrases',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2F6609),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '• What are Verbal Phrases?\n'
                        '  o Verbal phrases are statements or sentences that describe a mathematical relationship using words. We can translate these phrases into equations.',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Common Keywords',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2F6609),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Here are some common phrases and their mathematical representations:\n'
                        'Phrase                    Mathematical Operation\n'
                        '• Sum of                 Addition (+)\n'
                        '• Difference of          Subtraction (−)\n'
                        '• Product of             Multiplication (×)\n'
                        '• Quotient of            Division (÷)\n'
                        '• Is equal to            Equals (=)',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Translating Phrases into Equations',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2F6609),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Steps to Translate:\n'
                        '• Identify the Keywords: Look for keywords in the phrase.\n'
                        '• Assign a Variable: Let x represent the unknown number.\n'
                        '• Write the Equation: Combine the variable and constants using the appropriate operations.',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Example: Translate and Write an Equation\n'
                        '• Phrase: "The sum of a number and 8 is 15."\n'
                        'Step-by-Step Translation:\n'
                        '• Identify Keywords: "Sum of" indicates addition, and "is" indicates equals.\n'
                        '• Assign a Variable: Let x be the unknown number.\n'
                        'Write the Equation:\n'
                        '• x + 8 = 15',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Solving the Equation',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2F6609),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Steps to Solve an Equation:\n'
                        '• Isolate the Variable: Use inverse operations to get the variable alone on one side of the equation.\n'
                        '• Perform the Operations: Do the same operation on both sides to keep the equation balanced.\n'
                        '• Check Your Solution: Substitute your answer back into the original equation to verify.\n'
                        'Example: Solve the Equation\n'
                        '• Equation: x + 8 = 15\n'
                        'Step-by-Step Solution:\n'
                        'Isolate the Variable: Subtract 8 from both sides:\n'
                        '• x + 8 − 8 = 15 − 8\n'
                        'x = 7\n'
                        'Check Your Solution: Substitute x = 7 back into the equation:\n'
                        '• 7 + 8 = 15 (True)\n'
                        'Final Solution:\n'
                        '• x = 7',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Solving Equations with Basic Operations',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2F6609),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'What is an Equation?\n'
                        '• An equation is a mathematical statement that two expressions are equal and often contains a variable (an unknown number).\n'
                        'Example: x + 4 = 10\n'
                        'Components of an Equation:\n'
                        '• Variable: A letter representing an unknown value (x).\n'
                        '• Constant: A fixed number (5).\n'
                        '• Coefficient: A number multiplied by a variable (in 3x, 3 is the coefficient).\n'
                        '• Operator: Symbols that indicate mathematical operations (+, -, ×, ÷).',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'The Four Basic Operations:\n'
                        '• Addition (+): Combining two or more numbers.\n'
                        '• Subtraction (−): Taking one number away from another.\n'
                        '• Multiplication (×): Adding a number to itself a certain number of times.\n'
                        '• Division (÷): Splitting a number into equal parts.',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Solving One-step Equations:\n'
                        'Example: Solve x + 5 = 12 using addition and subtraction.\n'
                        '• Step 1: Identify the operation. Here, 5 is added to x.\n'
                        '• Step 2: Use subtraction to isolate x:\n'
                        'x + 5 − 5 = 12 − 5\n'
                        'x = 7\n'
                        'Check Method:\n'
                        '• Substitute x = 7 back into the original equation:\n'
                        '7 + 5 = 12 (True)',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Solving Two-step Equations:\n'
                        'Example: Solve 2x + 4 = 12.\n'
                        '• Step 1: Subtract 4 from both sides:\n'
                        '2x + 4 − 4 = 12 − 4\n'
                        '2x = 8\n'
                        '• Step 2: Divide by 2:\n'
                        '2x / 2 = 8 / 2\n'
                        'x = 4\n'
                        'Check Method:\n'
                        '• Substitute x = 4 back into the original equation:\n'
                        '2(4) + 4 = 12 (True)',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Solving Multi-step Equations:\n'
                        'Example: Solve 3(x + 2) – 4 = 11.\n'
                        '• Step 1: Distribute 3:\n'
                        '3x + 6 – 4 = 11\n'
                        '• Step 2: Combine like terms:\n'
                        '3x + 2 = 11\n'
                        '• Step 3: Subtract 2:\n'
                        '3x + 2 – 2 = 11 − 2\n'
                        '3x = 9\n'
                        '• Step 4: Divide by 3:\n'
                        'x = 9 / 3\n'
                        'x = 3\n'
                        'Check Method:\n'
                        '• Substitute x = 3 back into the original equation:\n'
                        '3(3 + 2) – 4 = 11 (True)',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                      ),
                    ],
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
