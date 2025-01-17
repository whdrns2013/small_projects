import 'package:flutter/material.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});
  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        body: Column(
          children: [
            Flexible(child: Container(child: Text("00 : 00"))), // 시간초
            Flexible(
                // 랩/시작 버튼
                child: Container(
                    child: Column(
              children: [Icon(Icons.circle), Icon(Icons.circle)],
            ))),
            Flexible(
              // 하단 세계 시각 / 알람 / 스톱워치 / 타이머
              child: Column(
                children: [Row(), Row(), Row(), Row()],
              ),
            )
          ],
        ));
  }
}
