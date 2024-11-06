import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizzapp/algebraicequation/posttest/algebraicequationposttestview.dart';
import 'package:quizzapp/algebraicequation/posttest/algebraicequationpretestview.dart';
import 'package:quizzapp/top.dart';
import 'package:quizzapp/understandingalgebraicequation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlgebraicEquationPage extends StatefulWidget {
  const AlgebraicEquationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AlgebraicEquationPage createState() => _AlgebraicEquationPage();
}

class _AlgebraicEquationPage extends State<AlgebraicEquationPage> {
  String status = 'pending';
  @override
  void initState() {
    super.initState();
    _loadData(); // Load saved data on initialization
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      status = prefs.getString('algebraicequationpretestCompleted') ??
          ''; // Load saved score
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                margin: const EdgeInsets.only(top: 30, left: 20),
                alignment: Alignment.bottomLeft,
                child: GestureDetector(
                  child: const FaIcon(
                    FontAwesomeIcons.arrowLeft,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const TopPage(),
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
                              'Algebraic Equation',
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
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2F6609),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Understanding Algebraic Equation",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Understandingalgebraicequation()));
                              },
                            )
                          ],
                        ),
                      ),
                      status == 'completed'
                          ? GestureDetector(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2F6609),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'Take Post Test',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onTap: () {
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 30),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              'Do you want to take a pre test to know your knowledge about the Algebraic Equation?',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 19),
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(height: 20),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const Algebraicequationposttestview()));
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 40,
                                                          vertical: 5),
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                              0xFF2F6609),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: const Text(
                                                        'YES',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    )),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 40,
                                                          vertical: 5),
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                              0xFF2F6609),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: const Text(
                                                        'NO',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
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
                              },
                            )
                          : GestureDetector(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2F6609),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'Take Pre Test',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onTap: () {
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 30),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              'Do you want to take a pre test to know your knowledge about the Algebraic Equation?',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 19),
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(height: 20),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const Algebraicequationpretestview()));
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 40,
                                                          vertical: 5),
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                              0xFF2F6609),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: const Text(
                                                        'YES',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    )),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 40,
                                                          vertical: 5),
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                              0xFF2F6609),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: const Text(
                                                        'NO',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
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
                              },
                            )
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
}

void main() => runApp(const MaterialApp(home: AlgebraicEquationPage()));
