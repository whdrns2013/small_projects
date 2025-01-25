import 'package:flutter/material.dart';
import 'package:wash_games/BottomNavigator.dart';
// TODO:: 현재 화면만 만들어놓음. 보강 필요

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(children: [
          TopBar(),
          Expanded(flex: 6, child: Column()),
          BottomNavigator()
        ]));
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
            '알람',
            style: TextStyle(
                fontSize: 40, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
