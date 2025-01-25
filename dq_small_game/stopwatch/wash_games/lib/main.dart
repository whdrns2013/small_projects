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


/*
references
위젯 겹치기 : https://ahang.tistory.com/24  
다트 논리 연산자 : https://needneo.tistory.com/229  
화면 스크롤 기능 : https://dudgus907.tistory.com/7  
주석 : https://while1.tistory.com/94#google_vignette  
기타 : https://chatgpt.com/share/67950838-7698-800f-9e28-bbde296d2a4e  
*/