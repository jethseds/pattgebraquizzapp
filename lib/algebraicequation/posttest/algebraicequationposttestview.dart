import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizzapp/algebraicequation.dart';
import 'package:quizzapp/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Algebraicequationposttestview extends StatefulWidget {
  const Algebraicequationposttestview({super.key});

  @override
  _Algebraicequationposttestview createState() =>
      _Algebraicequationposttestview();
}

class _Algebraicequationposttestview
    extends State<Algebraicequationposttestview> {
  String? _selectedAnswer; // To store the selected answer
  int currentQuestionIndex = 0;
  List<String> correctAnswers = []; // To store correct answers
  int score = 0; // To keep track of the score
  List<String> savedQuestions = []; // To track saved questions
  String status = 'pending';
  // List of questions and answers
  final List<Map<String, dynamic>> questions = [
    {
      "question": "Translate: 'The sum of a number and 15 is 30.'",
      "options": ["x + 15 = 30", "15 - x = 30", "x - 15 = 30", "30 + x = 15"],
      "answer": "x + 15 = 30"
    },
    {
      "question": "What does the equation '2x = 10' translate to?",
      "options": [
        "Two times a number equals ten.",
        "A number divided by two equals ten.",
        "Ten is two times a number.",
        "The product of two and a number is ten."
      ],
      "answer": "Two times a number equals ten."
    },
    {
      "question": "Translate: 'A number decreased by 4 is 12.'",
      "options": ["x - 4 = 12", "12 - x = 4", "x + 4 = 12", "4 - x = 12"],
      "answer": "x - 4 = 12"
    },
    {
      "question": "What does the equation 'x + 20 = 50' mean?",
      "options": [
        "Fifty minus a number is twenty.",
        "A number plus twenty equals fifty.",
        "The sum of twenty and a number is fifty.",
        "Twenty more than a number equals fifty."
      ],
      "answer": "Twenty more than a number equals fifty."
    },
    {
      "question": "Translate: 'The product of a number and 9 is 72.'",
      "options": ["9x = 72", "72 - 9x = 0", "x + 9 = 72", "9 - x = 72"],
      "answer": "9x = 72"
    },
    {
      "question": "What does the equation 'x - 5 = 10' translate to?",
      "options": [
        "Five less than a number is ten.",
        "A number minus five equals ten.",
        "The difference of a number and five is ten.",
        "Ten more than a number is five."
      ],
      "answer": "A number minus five equals ten."
    },
    {
      "question": "Translate: 'Three times a number plus 6 equals 18.'",
      "options": ["3x + 6 = 18", "18 - 3x = 6", "x + 3 = 18", "3 + 6x = 18"],
      "answer": "3x + 6 = 18"
    },
    {
      "question": "What does the equation '25 - x = 10' mean?",
      "options": [
        "Twenty-five minus a number equals ten.",
        "A number decreased from twenty-five is ten.",
        "Ten less than twenty-five is a number.",
        "A number minus ten equals twenty-five."
      ],
      "answer": "Twenty-five minus a number equals ten."
    },
    {
      "question": "Translate: 'The quotient of a number and 5 is 3.'",
      "options": ["x / 5 = 3", "x + 5 = 3", "5 - x = 3", "3 / x = 5"],
      "answer": "x / 5 = 3"
    },
    {
      "question": "What does the equation 'x + 7 = 14' translate to?",
      "options": [
        "The sum of seven and a number is fourteen.",
        "A number plus seven equals fourteen.",
        "Seven more than a number is fourteen.",
        "Fourteen minus a number is seven."
      ],
      "answer": "Seven more than a number is fourteen."
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
      score = prefs.getInt('algebraicequationposttestscore') ??
          0; // Load saved score
      correctAnswers =
          prefs.getStringList('algebraicequationposttestcorrectAnswers') ??
              []; // Load saved answers
      savedQuestions =
          prefs.getStringList('algebraicequationposttestsavedQuestions') ??
              []; // Load saved questions
      status = prefs.getString('algebraicequationposttestCompleted') ?? '';
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
      await prefs.setStringList('algebraicequationposttestcorrectAnswers',
          correctAnswers); // Save to local storage
      await prefs.setInt('algebraicequationposttestscore',
          score); // Save score to local storage
      await prefs.setString('algebraicequationposttestCompleted', 'pending');
    }

    // Save the current question to the savedQuestions list
    savedQuestions.add(questions[currentQuestionIndex]['question']);
    await prefs.setStringList('algebraicequationposttestsavedQuestions',
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
            'algebraicequationposttestCompleted', 'completed');
      } else {
        _clearSavedQuestions();
      }

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Algebraicequationposttestview()));
    }
  }

  Future<void> _clearSavedQuestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(
        'algebraicequationposttestsavedQuestions'); // Clear savedQuestions from local storage
    await prefs.setString('algebraicequationposttestCompleted', 'pending');
    await prefs.setInt('algebraicequationposttestscore', 0);
    setState(() {
      savedQuestions.clear(); // Clear the savedQuestions list in the app
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
                                            AlgebraicEquationPage()));
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
