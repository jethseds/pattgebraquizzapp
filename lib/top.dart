import 'package:flutter/material.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  _TopPage createState() => _TopPage();
}

class _TopPage extends State<TopPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Patterns and Algebra \n',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: 'Tutorials',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Let's learn Patterns and Algebra Tutorials \n",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: 'Guide.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
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
    );
  }
}

void main() => runApp(MaterialApp(home: TopPage()));
