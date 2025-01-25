import 'package:flutter/material.dart';
import 'package:wash_games/BottomNavigator.dart';

class WorldClockScreen extends StatefulWidget {
  const WorldClockScreen({super.key});

  @override
  State<WorldClockScreen> createState() => _WorldClockScreenState();
}

class _WorldClockScreenState extends State<WorldClockScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(children: [
        TopBar(),
        Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Divider(
              color: Color.fromARGB(50, 230, 230, 230),
              thickness: 1.2,
              height: 25),
        ),
        Expanded(flex: 6, child: Column()),
        BottomNavigator()
      ]),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 25,
        ),
        Container(
          height: 80,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
            child: Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '편집',
                    style: TextStyle(color: Colors.orange, fontSize: 20),
                  ),
                  Text(
                    '+',
                    style: TextStyle(color: Colors.orange, fontSize: 28),
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          alignment: Alignment.topLeft,
          child: Text(
            '세계 시계',
            style: TextStyle(
                fontSize: 40, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
