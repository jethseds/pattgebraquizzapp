import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizzapp/algebraicexpression.dart';
import 'package:quizzapp/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Algebraicexpressionposttestview extends StatefulWidget {
  const Algebraicexpressionposttestview({super.key});

  @override
  _Algebraicexpressionposttestview createState() =>
      _Algebraicexpressionposttestview();
}

class _Algebraicexpressionposttestview
    extends State<Algebraicexpressionposttestview> {
  String? _selectedAnswer; // To store the selected answer
  int currentQuestionIndex = 0;
  List<String> correctAnswers = []; // To store correct answers
  int score = 0; // To keep track of the score
  List<String> savedQuestions = []; // To track saved questions
  String status = 'pending';

  // List of questions and answers
  final List<Map<String, dynamic>> questions = [
    {
      "question": "What is an algebraic expression?",
      "options": [
        "A combination of numbers and variables",
        "A mathematical statement with an equal sign",
        "A single number",
        "An expression containing only constants"
      ],
      "answer": "A combination of numbers and variables"
    },
    {
      "question": "Which of the following is a constant?",
      "options": ["x", "0", "7y", "-3z"],
      "answer": "0"
    },
    {
      "question": "In the expression 5a + 4, what is the coefficient of a?",
      "options": ["5", "4", "a", "9"],
      "answer": "5"
    },
    {
      "question": "What does the operator '-' signify in an expression?",
      "options": ["Addition", "Subtraction", "Multiplication", "Division"],
      "answer": "Subtraction"
    },
    {
      "question": "Which of the following is a binomial?",
      "options": ["3x + 2", "4xy", "7x - 5y + 3", "9"],
      "answer": "3x + 2"
    },
    {
      "question": "What type of expression is 2x^2 + 3x + 5?",
      "options": ["Monomial", "Binomial", "Trinomial", "Polynomial"],
      "answer": "Trinomial"
    },
    {
      "question": "Identify the variable in the expression 4x + 2.",
      "options": ["4", "2", "x", "6"],
      "answer": "x"
    },
    {
      "question": "Which phrase translates to the expression 3y + 7?",
      "options": [
        "Seven less than three times a number",
        "Three times a number plus seven",
        "The product of three and a number increased by seven",
        "Seven times a number"
      ],
      "answer": "Three times a number plus seven"
    },
    {
      "question":
          "What is the expression for 'Two times a number decreased by 3'?",
      "options": ["2x - 3", "x - 2", "2 - 3x", "3 - 2x"],
      "answer": "2x - 3"
    },
    {
      "question": "In the expression 10 - 4y, what is the constant?",
      "options": ["10", "4", "y", "-4"],
      "answer": "10"
    },
    // Additional Fibonacci and Pascal's Triangle questions
    {
      "question": "What is the first number in the Fibonacci Sequence?",
      "options": ["1", "0", "2", "3"],
      "answer": "0"
    },
    {
      "question": "Which of the following defines Pascal's Triangle?",
      "options": [
        "A square arrangement of numbers",
        "A linear sequence of numbers",
        "A circular arrangement of numbers",
        "A triangular arrangement where each number is the sum of the two above it"
      ],
      "answer":
          "A triangular arrangement where each number is the sum of the two above it"
    },
    {
      "question": "What is the formula for finding the n-th Fibonacci number?",
      "options": [
        "F(n) = F(n-1) + F(n-2)",
        "F(n) = F(n-1) × F(n-2)",
        "F(n) = F(n-1) - F(n-2)",
        "F(n) = F(n-1) / F(n-2)"
      ],
      "answer": "F(n) = F(n-1) + F(n-2)"
    },
    {
      "question": "What is the 6th Fibonacci number?",
      "options": ["5", "8", "13", "21"],
      "answer": "8"
    },
    {
      "question":
          "How many rows are in the first four rows of Pascal's Triangle?",
      "options": ["2", "3", "4", "5"],
      "answer": "4"
    },
    {
      "question":
          "What number is located at row 5, position 2 in Pascal's Triangle?",
      "options": ["5", "10", "15", "20"],
      "answer": "10"
    },
    {
      "question": "Which of the following is a property of Fibonacci numbers?",
      "options": [
        "They are all prime numbers",
        "They can only be found in nature",
        "They are all even",
        "The sum of any two consecutive Fibonacci numbers is the next Fibonacci number"
      ],
      "answer":
          "The sum of any two consecutive Fibonacci numbers is the next Fibonacci number"
    },
    {
      "question": "What is the sum of the first three Fibonacci numbers?",
      "options": ["1", "2", "3", "5"],
      "answer": "3"
    },
    {
      "question":
          "In which row of Pascal's Triangle do you find the number 10?",
      "options": ["Row 4", "Row 7", "Row 6", "Row 5"],
      "answer": "Row 5"
    },
    {
      "question": "Which Fibonacci number is 34?",
      "options": ["8th", "9th", "10th", "11th"],
      "answer": "10th"
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
      score = prefs.getInt('algebraicexpressionposttestscore') ??
          0; // Load saved score
      correctAnswers =
          prefs.getStringList('algebraicexpressionposttestcorrectAnswers') ??
              []; // Load saved answers
      savedQuestions =
          prefs.getStringList('algebraicexpressionposttestsavedQuestions') ??
              []; // Load saved questions

      status = prefs.getString('algebraicexpressionposttestCompleted') ?? '';
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
      await prefs.setStringList('algebraicexpressionposttestcorrectAnswers',
          correctAnswers); // Save to local storage
      await prefs.setInt('algebraicexpressionposttestscore',
          score); // Save score to local storage
      await prefs.setString('algebraicexpressionposttestCompleted', 'pending');
    }

    // Save the current question to the savedQuestions list
    savedQuestions.add(questions[currentQuestionIndex]['question']);
    await prefs.setStringList('algebraicexpressionposttestsavedQuestions',
        savedQuestions); // Save to local storage

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
      // Show a dialog or message when all questions are completed
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (score >= 15) {
        await prefs.setString(
            'algebraicexpressionposttestCompleted', 'completed');
      } else {
        _clearSavedQuestions();
      }

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Algebraicexpressionposttestview()));
    }
  }

  Future<void> _clearSavedQuestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(
        'algebraicexpressionposttestsavedQuestions'); // Clear savedQuestions from local storage
    await prefs.setString('algebraicexpressionposttestCompleted', 'pending');
    await prefs.setInt('algebraicexpressionposttestscore', 0);
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomePage()));
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    score < 15
                        ? Text(
                            'Retake The Post Test',
                            style: TextStyle(color: Colors.white),
                          )
                        : SizedBox(),
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
                                            AlgebraicExpressionPage()));
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
              SizedBox(height: 10),
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
