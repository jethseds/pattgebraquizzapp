import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizzapp/algebraicequation.dart';
import 'package:quizzapp/algebraicequation/posttest/algebraicequationpretestview.dart';
import 'package:quizzapp/algebraicexpression.dart';
import 'package:quizzapp/algebraicexpression/posttest/algebraicexpressionpretestview.dart';
import 'package:quizzapp/login.dart';
import 'package:quizzapp/sidebar.dart';
import 'package:quizzapp/solvingequation.dart';
import 'package:quizzapp/solvingequation/posttest/solvingequationpretestview.dart';
import 'package:quizzapp/top.dart';
import 'package:quizzapp/top2.dart';
import 'package:quizzapp/writingrulesforsequence.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String status = 'pending';
  String status2 = 'pending';
  String status3 = 'pending';

  String preteststatus1 = 'pending';
  String preteststatus2 = 'pending';
  String preteststatus3 = 'pending';
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      status = prefs.getString('thenthtermofasequenceposttestCompleted') ?? '';
      status2 = prefs.getString('algebraicexpressionposttestCompleted') ?? '';
      status3 = prefs.getString('algebraicequationposttestCompleted') ?? '';

      preteststatus1 =
          prefs.getString('algebraicexpressionpretestCompleted') ?? '';
      preteststatus2 =
          prefs.getString('algebraicequationpretestCompleted') ?? '';
      preteststatus3 = prefs.getString('solvingequationpretestCompleted') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidebarPage(),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2F6609), Color(0xFFC1FFB1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
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
              const Top2Page(),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Patterns and Algebra',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            Center(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                width: 50,
                                decoration: BoxDecoration(
                                    color: const Color(0xDDaafa42),
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Image(
                                  image: AssetImage('assets/brain.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        height: 2,
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                      ),
                      const SizedBox(height: 15),
                      widgetCard('1', 'Lesson 1: ',
                          'Writing Rules For Sequence \n', '2 Topic'),
                      status == 'completed'
                          ? widgetCard('2', 'Lesson 2: ',
                              'Algebraic Expresssion  \n', '1 Topic')
                          : widgetCard2('2', 'Lesson 2: ',
                              'Algebraic Expresssion  \n', '1 Topic'),
                      status2 == 'completed'
                          ? widgetCard('3', 'Lesson 2: ',
                              'Algebraic Equation \n', '1 Topic')
                          : widgetCard2('3', 'Lesson 2: ',
                              'Algebraic Equation \n', '1 Topic'),
                      status3 == 'completed'
                          ? widgetCard('4', 'Lesson 2: ', 'Solving Equation \n',
                              '1 Topic')
                          : widgetCard2('4', 'Lesson 2: ',
                              'Solving Equation \n', '1 Topic'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  widgetCard(String id, String label1, String label2, String label3) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF2F6609),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: label1,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: label2,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: label3,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  child: const FaIcon(
                    FontAwesomeIcons.circleArrowRight,
                    color: Colors.white,
                  ),
                  onTap: () {
                    if (id == '1') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const WrtingRulesForSequencePage()));
                    } else if (id == '2') {
                      if (preteststatus1 == 'completed') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AlgebraicExpressionPage()));
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(221, 48, 102, 9),
                                      Color.fromARGB(238, 48, 102, 9)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 30),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Do you want to take a pre test to know your knowledge about the Algebraic Expression?',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 19),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Algebraicexpressionpretestview()));
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 40,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF2F6609),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: const Text(
                                                'YES',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 40,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF2F6609),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: const Text(
                                                'NO',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    } else if (id == '3') {
                      if (preteststatus2 == 'completed') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AlgebraicEquationPage()));
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(221, 48, 102, 9),
                                      Color.fromARGB(238, 48, 102, 9)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 30),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Do you want to take a pre test to know your knowledge about the Algebraic Equation?',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 19),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Algebraicequationpretestview()));
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 40,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF2F6609),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: const Text(
                                                'YES',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 40,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF2F6609),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: const Text(
                                                'NO',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    } else if (id == '4') {
                      if (preteststatus3 == 'completed') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SolvingEquationPage()));
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(221, 48, 102, 9),
                                      Color.fromARGB(238, 48, 102, 9)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 30),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Do you want to take a pre test to know your knowledge about the Solving Equation?',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 19),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Solvingequationpretestview()));
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 40, vertical: 5),
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF2F6609),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Text(
                                                'YES',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 40, vertical: 5),
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF2F6609),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Text(
                                                'NO',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }
                  },
                )
              ],
            ),
          ],
        ));
  }

  widgetCard2(String id, String label1, String label2, String label3) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(197, 61, 116, 25),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: label1,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: label2,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: label3,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const FaIcon(
                  FontAwesomeIcons.circleArrowRight,
                  color: Colors.white,
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              child: const FaIcon(
                FontAwesomeIcons.lock,
                size: 28,
                color: Color.fromARGB(210, 216, 216, 216),
              ),
            )
          ],
        ));
  }
}

void main() => runApp(const MaterialApp(home: HomePage()));
