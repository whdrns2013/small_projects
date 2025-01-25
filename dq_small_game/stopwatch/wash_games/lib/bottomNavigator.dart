import 'package:flutter/material.dart';
import 'package:wash_games/screens/AlarmScreen.dart';
import 'package:wash_games/screens/StopWatchScreen.dart';
import 'package:wash_games/screens/TimerScreen.dart';
import 'package:wash_games/screens/WorldClockScreen.dart';

class GlobalSetting {
  static double bottomIconSize = 40;
  static double bottomFontSize = 13;

  static String worldTimeText = '세계 시계';
  static String alarmText = '알람';
  static String stopwatchText = '스톱워치';
  static String timerText = '타이머';

  static Color selectedColor = Colors.orange;
  static Color unSelectedColor = Colors.grey;
}

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({
    super.key,
  });

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  static String selectedMenu = '스톱워치';

  // 화면전환
  void changeScreen(screen) {
    Navigator.push(
      context,
      PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => screen,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
          transitionDuration: Duration.zero),
    );
  }

  void turnToWorldClock() {
    setState(() {
      selectedMenu = '세계 시계';
    });
    changeScreen(WorldClockScreen());
  }

  void turnToAlarm() {
    setState(() {
      selectedMenu = '알람';
      changeScreen(AlarmScreen());
    });
  }

  void turnToStopwatch() {
    setState(() {
      selectedMenu = '스톱워치';
    });
    changeScreen(StopWatchScreen());
  }

  void turnToTimer() {
    setState(() {
      selectedMenu = '타이머';
    });
    changeScreen(TimerScreen());
  }

  Color getColor(selectedMenu, thisMenu) {
    Color color = selectedMenu == thisMenu
        ? GlobalSetting.selectedColor
        : GlobalSetting.unSelectedColor;
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return
        // 하단 세계 시각 / 알람 / 스톱워치 / 타이머
        Container(
      height: 110,
      color:
          // Color.fromARGB(100, 100, 100, 100),
          Colors.black,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: [
                  IconButton(
                    onPressed: turnToWorldClock,
                    icon: Icon(
                      Icons.language,
                      color:
                          getColor(selectedMenu, GlobalSetting.worldTimeText),
                    ),
                    iconSize: GlobalSetting.bottomIconSize,
                  ),
                  Text(
                    GlobalSetting.worldTimeText,
                    style: TextStyle(
                        color:
                            getColor(selectedMenu, GlobalSetting.worldTimeText),
                        fontSize: GlobalSetting.bottomFontSize),
                  )
                ]),
                Column(children: [
                  IconButton(
                    onPressed: turnToAlarm,
                    icon: Icon(
                      Icons.alarm,
                      color: getColor(selectedMenu, GlobalSetting.alarmText),
                    ),
                    iconSize: GlobalSetting.bottomIconSize,
                  ),
                  Text(
                    GlobalSetting.alarmText,
                    style: TextStyle(
                        color: getColor(selectedMenu, GlobalSetting.alarmText),
                        fontSize: GlobalSetting.bottomFontSize),
                  )
                ]),
                Column(children: [
                  IconButton(
                    onPressed: turnToStopwatch,
                    icon: Icon(
                      Icons.timer,
                      color:
                          getColor(selectedMenu, GlobalSetting.stopwatchText),
                    ),
                    iconSize: GlobalSetting.bottomIconSize,
                  ),
                  Text(
                    GlobalSetting.stopwatchText,
                    style: TextStyle(
                        color:
                            getColor(selectedMenu, GlobalSetting.stopwatchText),
                        fontSize: GlobalSetting.bottomFontSize),
                  )
                ]),
                Column(children: [
                  IconButton(
                    onPressed: turnToTimer,
                    icon: Icon(
                      // Icons.timer_outlined,
                      Icons.access_time,
                      color: getColor(selectedMenu, GlobalSetting.timerText),
                    ),
                    iconSize: GlobalSetting.bottomIconSize,
                  ),
                  Text(
                    GlobalSetting.timerText,
                    style: TextStyle(
                        color: getColor(selectedMenu, GlobalSetting.timerText),
                        fontSize: GlobalSetting.bottomFontSize),
                  )
                ])
              ],
            ),
          )
        ],
      ),
    );
  }
}
