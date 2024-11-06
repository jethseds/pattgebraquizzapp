import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizzapp/thenthtermofasequence.dart';
import 'package:quizzapp/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThenthtermofasequencepretestviewPage extends StatefulWidget {
  const ThenthtermofasequencepretestviewPage({super.key});

  @override
  _ThenthtermofasequencepretestviewPage createState() =>
      _ThenthtermofasequencepretestviewPage();
}

class _ThenthtermofasequencepretestviewPage
    extends State<ThenthtermofasequencepretestviewPage> {
  String? _selectedAnswer; // To store the selected answer
  int currentQuestionIndex = 0;
  List<String> correctAnswers = []; // To store correct answers
  int score = 0; // To keep track of the score
  List<String> savedQuestions = []; // To track saved questions

  String status = 'pending';

  // List of questions and answers
  final List<Map<String, dynamic>> questions = [
    {
      "question": "What is a sequence?",
      "options": [
        "A random list of numbers",
        "A list of numbers arranged in a specific order",
        "A single number",
        "A pattern of letters"
      ],
      "answer": "A list of numbers arranged in a specific order"
    },
    {
      "question": "Which of the following is an arithmetic sequence?",
      "options": [
        "1, 2, 4, 8, 16",
        "3, 6, 9, 12, 15",
        "2, 4, 8, 16",
        "1, 1, 2, 3, 5"
      ],
      "answer": "3, 6, 9, 12, 15"
    },
    {
      "question":
          "What is the common difference in the arithmetic sequence 5, 10, 15, 20?",
      "options": ["5", "10", "15", "20"],
      "answer": "5"
    },
    {
      "question":
          "What is the nth term of the arithmetic sequence 4, 7, 10, 13?",
      "options": ["4n", "3n + 1", "3n + 4", "3n + 2"],
      "answer": "3n + 1"
    },
    {
      "question":
          "In the arithmetic sequence defined by the formula an = 2 + (n - 1) x 3, what is the first term (n = 1)?",
      "options": ["5", "3", "2", "6"],
      "answer": "2"
    },
    {
      "question":
          "What is the formula for the nth term of an arithmetic sequence?",
      "options": [
        "an = a + (n - 1)d",
        "an = a x d^n",
        "an = a + nd",
        "an = d + n"
      ],
      "answer": "an = a + (n - 1)d"
    },
    {
      "question":
          "What is the common ratio in the geometric sequence 2, 6, 18, 54?",
      "options": ["2", "3", "4", "5"],
      "answer": "3"
    },
    {
      "question":
          "For the geometric sequence defined by the formula an = 3 x 2^(n-1), what is the second term (n = 2)?",
      "options": ["3", "6", "9", "12"],
      "answer": "6"
    },
    {
      "question":
          "What is the nth term of the geometric sequence 5, 15, 45, 135?",
      "options": [
        "an = 5 x 3^(n-1)",
        "an = 5 x 2^(n-1)",
        "an = 3^(n-1)",
        "an = 5 + (n-1) x 15"
      ],
      "answer": "an = 5 x 3^(n-1)"
    },
    {
      "question": "Which of the following sequences is geometric?",
      "options": ["2, 5, 10, 15", "2, 3, 5, 7", "3, 6, 9, 12", "1, 2, 4, 8"],
      "answer": "1, 2, 4, 8"
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
      score = prefs.getInt('thenthtermofasequencepretestscore') ?? 0;
      correctAnswers =
          prefs.getStringList('thenthtermofasequencecorrectAnswers') ??
              []; // Load saved answers
      savedQuestions =
          prefs.getStringList('thenthtermofasequencesavedQuestions') ??
              []; // Load saved questions
      status = prefs.getString('thenthtermofasequencepretestCompleted') ?? '';
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
      await prefs.setStringList('thenthtermofasequencecorrectAnswers',
          correctAnswers); // Save to local storage
      await prefs.setInt('thenthtermofasequencepretestscore',
          score); // Save score to local storage
      await prefs.setString('thenthtermofasequencepretestCompleted', 'pending');
    }

    // Save the current question to the savedQuestions list
    savedQuestions.add(questions[currentQuestionIndex]['question']);
    await prefs.setStringList('thenthtermofasequencesavedQuestions',
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'thenthtermofasequencepretestCompleted', 'completed');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ThenthtermofasequencepretestviewPage()));
    }
  }

  Future<void> _clearSavedQuestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(
        'thenthtermofasequencesavedQuestions'); // Clear savedQuestions from local storage

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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomePage()));
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
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ThenthtermofasequencePage()));
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
