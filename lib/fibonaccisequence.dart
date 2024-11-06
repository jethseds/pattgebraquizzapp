import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizzapp/fibonacci/posttest/fibonacciposttestview.dart';
import 'package:quizzapp/fibonacci/posttest/fibonaccipretestview.dart';
import 'package:quizzapp/top.dart';
import 'package:quizzapp/understandingfibonaccisequence.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FibonacciSequencePage extends StatefulWidget {
  const FibonacciSequencePage({super.key});

  @override
  _FibonacciSequencePage createState() => _FibonacciSequencePage();
}

class _FibonacciSequencePage extends State<FibonacciSequencePage> {
  String status = 'pending';
  @override
  void initState() {
    super.initState();
    _loadData(); // Load saved data on initialization
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      status = prefs.getString('fibonaccipretestCompleted') ??
          ''; // Load saved score
    });
  }

  @override
  Widget build(BuildContext context) {
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
              TopPage(),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
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
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        height: 2,
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                      ),
                      SizedBox(height: 15),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xFF2F6609),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Understanding Fibonacci Sequence",
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
                              child: FaIcon(
                                FontAwesomeIcons.circleArrowRight,
                                color: Colors.white,
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UnderstandingfibonaccisequencePage()));
                              },
                            )
                          ],
                        ),
                      ),
                      status == 'completed'
                          ? GestureDetector(
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Color(0xFF2F6609),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
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
                                          gradient: LinearGradient(
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 30),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Do you want to take a pre test to know your knowledge about the Fibonacci Sequence?',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 19),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(height: 20),
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
                                                                  FibonacciposttestviewPage()));
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 40,
                                                              vertical: 5),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xFF2F6609),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Text(
                                                        'YES',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    )),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 40,
                                                              vertical: 5),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xFF2F6609),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Text(
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
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Color(0xFF2F6609),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
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
                                          gradient: LinearGradient(
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 30),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Do you want to take a pre test to know your knowledge about the Fibonacci Sequence?',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 19),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(height: 20),
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
                                                                  FibonaccipretestviewPage()));
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 40,
                                                              vertical: 5),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xFF2F6609),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Text(
                                                        'YES',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    )),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 40,
                                                              vertical: 5),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xFF2F6609),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Text(
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

void main() => runApp(MaterialApp(home: FibonacciSequencePage()));
