import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizzapp/fibonaccisequence.dart';
import 'package:quizzapp/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FibonaccipretestviewPage extends StatefulWidget {
  const FibonaccipretestviewPage({super.key});

  @override
  _FibonaccipretestviewPage createState() => _FibonaccipretestviewPage();
}

class _FibonaccipretestviewPage extends State<FibonaccipretestviewPage> {
  String? _selectedAnswer; // To store the selected answer
  int currentQuestionIndex = 0;
  List<String> correctAnswers = []; // To store correct answers
  int score = 0; // To keep track of the score
  List<String> savedQuestions = []; // To track saved questions
  String status = 'pending';

  // List of questions and answers
  final List<Map<String, dynamic>> questions = [
    {
      "question": "What is Pascal's Triangle?",
      "options": [
        "A square arrangement of numbers",
        "A triangular arrangement of numbers",
        "A circular arrangement of numbers",
        "A linear arrangement of numbers"
      ],
      "answer": "A triangular arrangement of numbers"
    },
    {
      "question": "How is each number in Pascal's Triangle created?",
      "options": [
        "By adding the two numbers above it",
        "By multiplying the two numbers above it",
        "By subtracting the two numbers above it",
        "By averaging the two numbers above it"
      ],
      "answer": "By adding the two numbers above it"
    },
    {
      "question": "What is the first number in the Fibonacci Sequence?",
      "options": ["1", "3", "2", "0"],
      "answer": "0"
    },
    {
      "question": "What are the first two numbers of the Fibonacci Sequence?",
      "options": ["1, 1", "0, 1", "1, 2", "2, 3"],
      "answer": "0, 1"
    },
    {
      "question":
          "How do you find the Fibonacci numbers using Pascal's Triangle?",
      "options": [
        "By summing the rows",
        "By averaging the numbers",
        "By summing the diagonals",
        "By subtracting the numbers"
      ],
      "answer": "By summing the diagonals"
    },
    {
      "question": "What is the third Fibonacci number?",
      "options": ["1", "2", "3", "5"],
      "answer": "2"
    },
    {
      "question":
          "In Pascal's Triangle, what number is located at row 4, position 2?",
      "options": ["1", "4", "6", "3"],
      "answer": "3"
    },
    {
      "question":
          "Which operation can be performed with two Fibonacci numbers?",
      "options": ["Addition", "Subtraction", "Multiplication", "Division"],
      "answer": "Division"
    },
    {
      "question": "What is the sum of the first two Fibonacci numbers?",
      "options": ["3", "2", "1", "0"],
      "answer": "1"
    },
    {
      "question": "What is the fifth Fibonacci number?",
      "options": ["3", "13", "8", "5"],
      "answer": "5"
    }
  ];

  @override
  void initState() {
    super.initState();
    _loadData(); // Load saved data on initialization
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      score = prefs.getInt('fibonaccipretestscore') ?? 0;
      correctAnswers = prefs.getStringList('fibonaccicorrectAnswers') ??
          []; // Load saved answers
      savedQuestions = prefs.getStringList('fibonaccisavedQuestions') ??
          []; // Load saved questions
      status = prefs.getString('fibonaccipretestCompleted') ?? '';
    });

    // Filter out questions that are already saved
    questions.removeWhere(
        (question) => savedQuestions.contains(question['question']));
  }

  Future<void> _saveSelectedAnswer(String answer) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if the selected answer is correct
    if (answer == questions[currentQuestionIndex]['answer']) {
      correctAnswers.add(answer); // Add correct answer to the list
      score++; // Increase score for the correct answer
      await prefs.setStringList(
          'fibonaccicorrectAnswers', correctAnswers); // Save to local storage
      await prefs.setInt(
          'fibonaccipretestscore', score); // Save score to local storage
      await prefs.setString('fibonaccipretestCompleted', 'pending');
    }

    // Save the current question to the savedQuestions list
    savedQuestions.add(questions[currentQuestionIndex]['question']);
    await prefs.setStringList(
        'fibonaccisavedQuestions', savedQuestions); // Save to local storage

    // Print score and move to the next question automatically
    print("Score: $score"); // Print the current score
    _nextQuestion();
  }

  void _nextQuestion() async {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        _selectedAnswer = null; // Reset selected answer for the next question
      });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('fibonaccipretestCompleted', 'completed');
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => FibonaccipretestviewPage()));
    }
  }

  Future<void> _clearSavedQuestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(
        'fibonaccisavedQuestions'); // Clear savedQuestions from local storage

    // Clear the local list
    setState(() {
      savedQuestions.clear(); // Clear the savedQuestions list in the app
      // Optionally, you can also reset other related state variables if needed
    });
  }

  @override
  Widget build(BuildContext context) {
    final radius = MediaQuery.of(context).size.width / 2.1;

    // Check if there are available questions after filtering
    bool hasQuestions = questions.isNotEmpty;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2F6609), Color(0xFFC1FFB1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 1.8,
                decoration: BoxDecoration(
                  color: status == 'pending'
                      ? Color(0xFF2F6609)
                      : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(radius),
                    bottomRight: Radius.circular(radius),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(top: 30, left: 20),
                      alignment: Alignment.bottomLeft,
                      child: GestureDetector(
                        child: FaIcon(FontAwesomeIcons.arrowLeft,
                            color: Colors.white),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: hasQuestions
                                  ? "${currentQuestionIndex + 1}. ${questions[currentQuestionIndex]['question']}\n"
                                  : "",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                hasQuestions
                    ? "Question ${currentQuestionIndex + 1}/ ${questions.length}"
                    : "",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: hasQuestions
                    ? Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: ListView.builder(
                          itemCount:
                              questions[currentQuestionIndex]['options'].length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedAnswer =
                                      questions[currentQuestionIndex]['options']
                                          [index];
                                });
                                _saveSelectedAnswer(_selectedAnswer!);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: _selectedAnswer ==
                                          questions[currentQuestionIndex]
                                              ['options'][index]
                                      ? Colors.lightGreen
                                      : Color(0xFF2F6609),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image(
                                      image: AssetImage('assets/quiz.png'),
                                      width: 50,
                                    ),
                                    Expanded(
                                        child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        questions[currentQuestionIndex]
                                            ['options'][index],
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    )),
                                    SizedBox(
                                      width: 50,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Center(
                        child: Column(
                        children: [
                          Image(
                            image: AssetImage('assets/trophy.png'),
                            width: 200,
                          ),
                          if (score >= 15)
                            Text(
                              'Very Good!',
                              style: TextStyle(
                                  color: Color(0xFF2F6609),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          if (score < 15)
                            Text(
                              'Good!',
                              style: TextStyle(
                                  color: Color(0xFF2F6609),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          if (score >= 15)
                            Text(
                              'You have passed the test!',
                              style: TextStyle(
                                  color: Color(0xFF2F6609),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400),
                            ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Your score is!',
                            style: TextStyle(
                                color: Color(0xFF2F6609),
                                fontSize: 35,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${score}/20',
                            style: TextStyle(
                                color: Color(0xFF2F6609),
                                fontSize: 35,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            decoration: BoxDecoration(
                              color: Color(0xFF2F6609),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FibonacciSequencePage()));
                              },
                              child: const Text(
                                'Proceed',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
              ),
              // SizedBox(height: 10),
              // ElevatedButton(
              //   onPressed: _clearSavedQuestions,
              //   child: Text("Clear Saved Questions"),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.red,
              //   ),
              // ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
