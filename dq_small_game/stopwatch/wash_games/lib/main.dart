import 'package:flutter/material.dart';
import 'package:wash_games/screens/StopWatchScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        ),
        home: const Scaffold(
          body: StopWatchScreen(),
        ));
  }
}
