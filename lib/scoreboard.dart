import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizzapp/sidebar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreBoardPage extends StatefulWidget {
  const ScoreBoardPage({super.key});

  @override
  _ScoreBoardPage createState() => _ScoreBoardPage();
}

class _ScoreBoardPage extends State<ScoreBoardPage> {
  int fibonaccipretestscore = 0;
  int fibonacciposttestscore = 0;

  int thenthtermofasequenceposttestscore = 0;
  int thenthtermofasequencepretestscore = 0;

  int algebraicexpressionposttestscore = 0;
  int algebraicexpressionpretestscore = 0;

  int algebraicequationposttestscore = 0;
  int algebraicequationpretestscore = 0;

  int solvingequationposttestscore = 0;
  int solvingequationpretestscore = 0;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fibonaccipretestscore = prefs.getInt('fibonaccipretestscore') ?? 0;
      fibonacciposttestscore =
          prefs.getInt('fibonacciposttestscore') ?? 0; // Load saved score

      thenthtermofasequenceposttestscore =
          prefs.getInt('thenthtermofasequenceposttestscore') ?? 0;
      thenthtermofasequencepretestscore =
          prefs.getInt('thenthtermofasequencepretestscore') ??
              0; // Load saved score

      algebraicexpressionposttestscore =
          prefs.getInt('algebraicexpressionposttestscore') ?? 0;
      algebraicexpressionpretestscore =
          prefs.getInt('algebraicexpressionpretestscore') ??
              0; // Load saved score

      algebraicequationposttestscore =
          prefs.getInt('algebraicequationposttestscore') ?? 0;
      algebraicequationpretestscore =
          prefs.getInt('algebraicequationpretestscore') ??
              0; // Load saved score

      solvingequationposttestscore =
          prefs.getInt('solvingequationposttestscore') ?? 0;
      solvingequationpretestscore =
          prefs.getInt('solvingequationpretestscore') ?? 0; // Load saved score
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidebarPage(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2F6609), Color(0xFFC1FFB1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.bottomLeft,
              child: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // Open the drawer
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.ribbon,
                        color: Colors.white,
                      ),
                      Text(
                        ' Scoreboard:',
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Center(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: 50,
                          decoration: BoxDecoration(
                              color: Color(0xDDaafa42),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Image(
                            image: AssetImage('assets/brain.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        'Patgebra',
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 2,
              decoration: BoxDecoration(border: Border.all(width: 1)),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 130, 236, 55),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Column(
                            children: [
                              Text(
                                'Lesson 1',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Writing Rules For Sequence',
                                style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        widgetScoreBoard2('Pre - Test', '', 'Post - Test'),
                        widgetScoreBoard2(
                            fibonaccipretestscore.toString(),
                            'Fibonacci Sequence',
                            fibonacciposttestscore.toString()),
                        widgetScoreBoard2(
                            thenthtermofasequencepretestscore.toString(),
                            'The Nth Term of a Sequence',
                            thenthtermofasequenceposttestscore.toString())
                      ],
                    ),
                  ),
                  widgetScoreboard(
                      'Lessong 2',
                      'Algebraic Expression',
                      'Pre - Test',
                      'Post Test',
                      algebraicexpressionpretestscore.toString(),
                      'Translating Word Phases into Algebraic',
                      algebraicexpressionposttestscore.toString()),
                  widgetScoreboard(
                      'Lessong 3',
                      'Algebraic Equation',
                      'Pre - Test',
                      'Post Test',
                      algebraicexpressionpretestscore.toString(),
                      'Translating Word Phases into Algebraic',
                      algebraicexpressionposttestscore.toString()),
                  widgetScoreboard(
                      'Lessong 4',
                      'Solving Equation',
                      'Pre - Test',
                      'Post Test',
                      algebraicexpressionpretestscore.toString(),
                      'Translating Verbal Phrases into Algebraic Equation',
                      algebraicexpressionposttestscore.toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  widgetScoreboard(String label1, String label2, String label3, String label4,
      String label5, String label6, String label7) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 130, 236, 55),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text(
                  label1,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                Text(
                  label2,
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            decoration:
                BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label3,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      label4,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            decoration:
                BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label5,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      label6,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      label7,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  widgetScoreBoard2(String label1, String label2, String label3) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration:
          const BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label1,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Text(
                label2,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Text(
                label3,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: ScoreBoardPage()));
