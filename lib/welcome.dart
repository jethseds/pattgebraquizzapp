import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizzapp/bookmark.dart';
import 'package:quizzapp/home.dart';
import 'package:quizzapp/performance.dart';
import 'package:quizzapp/scoreboard.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable, camel_case_types
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WelcomePage createState() => _WelcomePage();
}

// ignore: camel_case_types
class _WelcomePage extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: MainAppwidget());
  }
}

// ignore: camel_case_types
class MainAppwidget extends StatefulWidget {
  const MainAppwidget({super.key});

  @override
  MainAppwidgetfooter createState() => MainAppwidgetfooter();
}

class MainAppwidgetfooter extends State<MainAppwidget> {
  int selectedindex = 0;

  late List<Widget> widgetoption;

  @override
  void initState() {
    super.initState();
    widgetoption = [
      const HomePage(),
      const PerformancePage(),
      const ScoreBoardPage(),
      const BookMarkPage(),
    ];
  }

  void onitemtapped(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade200,
      body: Center(
        child: widgetoption.elementAt(selectedindex),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 2.0,
              color: Color(0xFF2F6609),
            ),
          ),
          gradient: LinearGradient(
            colors: [
              Color(0xFF2F6609),
              Color.fromARGB(255, 75, 155, 18),
              Color(0xFF2F6609)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SizedBox(
          height: 70, // Adjust this value to avoid overflow
          child: BottomNavigationBar(
            unselectedItemColor: Colors.white,
            selectedItemColor: Color.fromARGB(255, 119, 238, 35),
            selectedFontSize: 13,
            unselectedFontSize: 13,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),

            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.bookOpen,
                  size: 25,
                ),
                label: 'Learn',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.graduationCap,
                  size: 25,
                ),
                label: 'Performance',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.ribbon,
                  size: 25,
                ),
                label: 'Score Board',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.bookmark,
                  size: 25,
                ),
                label: 'Bookmark',
              ),
            ],
            currentIndex: selectedindex,
            type: BottomNavigationBarType.fixed,
            onTap: onitemtapped,
            backgroundColor: Colors
                .transparent, // Set to transparent to see the BottomAppBar color
            elevation: 0, // Remove top shadow color
          ),
        ),
      ),
    );
  }
}
