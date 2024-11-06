import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class UnderstandingfibonaccisequencePage extends StatefulWidget {
  const UnderstandingfibonaccisequencePage({super.key});

  @override
  _UnderstandingfibonaccisequencePage createState() =>
      _UnderstandingfibonaccisequencePage();
}

class _UnderstandingfibonaccisequencePage
    extends State<UnderstandingfibonaccisequencePage> {
  late VideoPlayerController _controller;
  void initState() {
    super.initState();
    // Initialize the video player controller with a video URL
    _controller = VideoPlayerController.asset('assets/Fibonacci_Sequence.mp4')
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
      mark = prefs.getString('mark1') ?? 'unmark';
    });
  }

// Toggle bookmark status and save to local storage
  Future<void> _toggleBookmark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mark = (mark == "mark") ? "unmark" : "mark";
    });
    prefs.setString('mark1', mark);
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
                        'Fibonacci Sequence',
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
                        'Introduction to Pascal\'s Triangle',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'What is Pascal\'s Triangle?',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '• A triangular arrangement of numbers where each number is the sum of the two above it.',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'How to Build It:',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '• Start with 1 at the top.\n• Each number below is created by adding the two numbers above it.',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Example:',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Image(image: AssetImage('assets/i1.png')),
                      SizedBox(height: 16),
                      Text(
                        'Introduction to the Fibonacci Sequence',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'What is the Fibonacci Sequence?',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '• A series of numbers where each number is the sum of the two preceding ones.\n'
                        '• Starting Numbers: 0, 1, 1, 2, 3, 5, 8, 13...',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Connecting Fibonacci and Pascal\'s Triangle',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'How to Find Fibonacci Numbers:\n'
                        '• Look at the diagonals in Pascal\'s Triangle and sum the numbers.',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Example:\n'
                        'Diagonal 1: 1 (1st Fibonacci number)\n'
                        'Diagonal 2: 1 (2nd Fibonacci number)\n'
                        'Diagonal 3: 2 (3rd Fibonacci number)\n'
                        'Diagonal 4: 3 (4th Fibonacci number)\n'
                        'Diagonal 5: 5 (5th Fibonacci number)',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Exploring Fibonacci Sequence with Basic Operation',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Introduction to the Fibonacci Sequence',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '• Definition: A sequence of numbers where each number is the sum of the two preceding numbers.\n'
                        '• Starting Numbers: 0, 1, 1, 2, 3, 5, 8, 13, 21, 34...',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Building the Fibonacci Sequence',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '• How to Generate the Sequence:\n'
                        '  • Start with 0 and 1.\n'
                        '  • Add the last two numbers to get the next one.',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Example:\n'
                        'Start: 0, 1\n'
                        'Next: 0 + 1 = 1\n'
                        'Next: 1 + 1 = 2\n'
                        'Next: 1 + 2 = 3\n'
                        'Continue this pattern...',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Basic Operations with Fibonacci Numbers',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '• Addition:\n'
                        '  • Add two Fibonacci numbers together.\n'
                        '  • Example: 5 + 8 = 13\n'
                        '• Subtraction:\n'
                        '  • Subtract one Fibonacci number from another.\n'
                        '  • Example: 13 – 8 = 5\n'
                        '• Multiplication:\n'
                        '  • Multiply two Fibonacci numbers.\n'
                        '  • Example: 5 × 3 = 15\n'
                        '• Division:\n'
                        '  • Divide one Fibonacci number by another.\n'
                        '  • Example: 21 ÷ 3 = 7',
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
