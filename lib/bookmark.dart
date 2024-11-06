import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizzapp/sidebar.dart';
import 'package:quizzapp/top.dart';
import 'package:quizzapp/top2.dart';
import 'package:quizzapp/understandingalgebraicequation.dart';
import 'package:quizzapp/understandingalgebraicexpression.dart';
import 'package:quizzapp/understandingfibonaccisequence.dart';
import 'package:quizzapp/understandingsolvingequation.dart';
import 'package:quizzapp/understandingthenthtermofasequence';
import 'package:shared_preferences/shared_preferences.dart';

class BookMarkPage extends StatefulWidget {
  const BookMarkPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BookMarkPage createState() => _BookMarkPage();
}

class _BookMarkPage extends State<BookMarkPage> {
  String mark1 = 'unmark';
  String mark2 = 'unmark';
  String mark3 = 'unmark';
  String mark4 = 'unmark';
  String mark5 = 'unmark';
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mark1 = prefs.getString('mark1') ?? '';
      mark2 = prefs.getString('mark2') ?? '';
      mark3 = prefs.getString('mark3') ?? '';
      mark4 = prefs.getString('mark4') ?? '';
      mark5 = prefs.getString('mark5') ?? '';
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
                      const SizedBox(height: 15),
                      mark1 == 'mark'
                          ? widgetCard('1', 'Fibonacci Sequence')
                          : const SizedBox(),
                      mark2 == 'mark'
                          ? widgetCard('2', 'The Nth Term of a Sequence')
                          : const SizedBox(),
                      mark3 == 'mark'
                          ? widgetCard('3', 'Algebraic Expression')
                          : const SizedBox(),
                      mark4 == 'mark'
                          ? widgetCard('4', 'Algebraic Equation')
                          : const SizedBox(),
                      mark5 == 'mark'
                          ? widgetCard('5', 'Solving Equation')
                          : const SizedBox(),
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

  widgetCard(String id, String label1) {
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
                Expanded(
                    child: Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.solidBookmark,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: label1,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
                GestureDetector(
                  child: const FaIcon(
                    // ignore: deprecated_member_use
                    FontAwesomeIcons.solidCheckCircle,
                    color: Colors.white,
                  ),
                  onTap: () {
                    if (id == '1') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const UnderstandingfibonaccisequencePage()));
                    } else if (id == '2') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const UnderstandingthenthtermofasequencePage()));
                    } else if (id == '3') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const Understandingalgebraicexpression()));
                    } else if (id == '4') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const Understandingalgebraicequation()));
                    } else if (id == '5') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const Understandingsolvingequation()));
                    }
                  },
                )
              ],
            ),
          ],
        ));
  }
}

void main() => runApp(const MaterialApp(home: BookMarkPage()));
