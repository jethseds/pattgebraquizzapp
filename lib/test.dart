import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  _TestPage createState() => _TestPage();
}

class _TestPage extends State<TestPage> {
  List<String> savedQuestions1 = [];
  List<String> savedQuestions2 = [];
  List<String> savedQuestions3 = [];
  List<String> savedQuestions4 = [];
  List<String> savedQuestions5 = [];
  String status1 = 'pending';
  String status2 = 'pending';
  String status3 = 'pending';
  String status4 = 'pending';
  String status5 = 'pending';

  @override
  void initState() {
    super.initState();
    _loadData(); // Load saved data on initialization
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedQuestions1 =
          prefs.getStringList('fibonacciposttestsavedQuestions') ?? [];
      status1 = prefs.getString('fibonacciposttestCompleted') ?? '';

      savedQuestions2 =
          prefs.getStringList('thenthtermofasequenceposttestsavedQuestions') ??
              [];
      status2 = prefs.getString('thenthtermofasequenceposttestCompleted') ?? '';

      savedQuestions3 =
          prefs.getStringList('algebraicexpressionposttestsavedQuestions') ??
              [];
      status3 = prefs.getString('algebraicexpressionposttestCompleted') ?? '';

      savedQuestions4 =
          prefs.getStringList('algebraicequationposttestsavedQuestions') ?? [];
      status4 = prefs.getString('algebraicequationposttestCompleted') ?? '';

      savedQuestions5 =
          prefs.getStringList('solvingequationposttestsavedQuestions') ?? [];
      status5 = prefs.getString('solvingequationposttestCompleted') ?? '';
    });
  }

  Future<void> _clearSavedQuestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('fibonacciposttestsavedQuestions');
    await prefs.remove('fibonaccisavedQuestions');
    await prefs.setString('fibonacciposttestCompleted', 'pending');
    await prefs.remove('thenthtermofasequenceposttestsavedQuestions');
    await prefs.setString('thenthtermofasequenceposttestCompleted', 'pending');
    await prefs.remove('algebraicexpressionposttestsavedQuestions');
    await prefs.setString('algebraicexpressionposttestCompleted', 'pending');
    await prefs.remove('algebraicequationposttestsavedQuestions');
    await prefs.setString('algebraicequationposttestCompleted', 'pending');
    await prefs.remove('solvingequationposttestsavedQuestions');
    await prefs.setString('solvingequationposttestCompleted', 'pending');

    await prefs.remove('fibonaccipretestsavedQuestions');
    await prefs.setString('fibonaccipretestCompleted', 'pending');
    await prefs.remove('thenthtermofasequencepretestsavedQuestions');
    await prefs.setString('thenthtermofasequencepretestCompleted', 'pending');
    await prefs.remove('algebraicexpressionpretestsavedQuestions');
    await prefs.setString('algebraicexpressionpretestCompleted', 'pending');
    await prefs.remove('algebraicequationpretestsavedQuestions');
    await prefs.setString('algebraicequationpretestCompleted', 'pending');
    await prefs.remove('solvingequationpretestsavedQuestions');
    await prefs.setString('solvingequationpretestCompleted', 'pending');
    setState(() {
      savedQuestions1.clear();
      savedQuestions2.clear();
      savedQuestions3.clear();
      savedQuestions4.clear();
      savedQuestions5.clear();
    });

    // Optionally, show a message to the user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Saved questions cleared!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Check if there are available questions after filtering

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: _clearSavedQuestions,
                child: Text("Clear Saved Questions"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
