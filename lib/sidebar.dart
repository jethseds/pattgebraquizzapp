import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizzapp/changepassword.dart';
import 'package:quizzapp/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SidebarPage extends StatefulWidget {
  const SidebarPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SidebarPageState createState() => _SidebarPageState();
}

class _SidebarPageState extends State<SidebarPage> {
  bool _showDetails = false;
  String username = "";
  String password = "";

  void _toggleDetails() {
    setState(() {
      _showDetails = !_showDetails;
    });
  }

  String status3 = 'pending';
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? '';
      password = prefs.getString('password') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 232, 255, 226),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Drawer header
          DrawerHeader(
            padding: EdgeInsets.only(top: 30),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF2F6609), // Dark green
                  Color(0xFFC1FFB1), // Light green
                ],
                begin: Alignment.topLeft,
                end: Alignment
                    .bottomLeft, // Diagonal gradient from top left to bottom right
              ),
            ),
            child: Column(
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: 60,
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
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          // Drawer items
          _showDetails
              ? Container(
                  color: _showDetails ? Colors.transparent : Color(0xFFC1FFB1),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username: ${username}',
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Password: ${password}',
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFFC1FFB1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: GestureDetector(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Change Password',
                                  style: TextStyle(color: Colors.black),
                                ),
                                FaIcon(FontAwesomeIcons.chevronRight)
                              ],
                            ),
                            onTap: () {
                              // Handle Home tap
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChangePassword())); // Close the drawer
                            },
                          ),
                        )
                      ],
                    ),
                    onTap: _toggleDetails,
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFFC1FFB1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Profile',
                            style: TextStyle(fontSize: 18),
                          ),
                          FaIcon(FontAwesomeIcons.chevronRight)
                        ],
                      ),
                    ),
                    onTap: _toggleDetails,
                  ),
                ),
          SizedBox(
            height: 10,
          ),
          _showDetails
              ? SizedBox()
              : Container(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                    onTap: () {
                      // Handle Settings tap
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Color(0xFF2F6609),
                            title: Text(
                              'Confirmation',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            content: Container(
                              height: 30,
                              width: MediaQuery.of(context).size.width / 1,
                              child: Column(
                                children: [
                                  Text(
                                    'Are you sure you want to logout?',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'No, Cancel',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFC1FFB1)),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                },
                                child: Text(
                                  'Yes, Logout',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFC1FFB1)),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                )
          // Add more list tiles here for more options
        ],
      ),
    );
  }
}
