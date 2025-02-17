import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wash_games/BottomNavigator.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});
  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class GlobalSetting {
  static const double timeFontSize = 75;
  static const TextStyle timeTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 80,
    fontWeight: FontWeight.w200,
  );
  static const double stopwatchStartStopIconSize = 95;

  static Color startStopButtonTextColorDeact =
      const Color.fromARGB(255, 0, 255, 50);
  static Color startStopButtonColorDeact = const Color.fromARGB(90, 0, 150, 0);
  static Color startStopButtonTextColorAct =
      const Color.fromARGB(255, 255, 50, 50);
  static Color startStopButtonColorAct = const Color.fromARGB(80, 150, 0, 0);

  static Color lapRefreshButtonTextColorDeact =
      const Color.fromARGB(200, 150, 150, 150);
  static Color lapRefreshButtonColorDeact =
      const Color.fromARGB(100, 150, 150, 150);
  static Color lapRefreshButtonTextColorAct =
      const Color.fromARGB(250, 250, 250, 250);
  static Color lapRefreshButtonColorAct =
      const Color.fromARGB(100, 200, 200, 200);

  static double startStopFontSize = 15;
  static String startStopButtonTextDeact = '시작';
  static String startStopButtonTextAct = '중단';
  static String lapRefreshButtonTextDeact = '랩';
  static String lapRefreshButtonTextAct = '재설정';

  static Color selectedSubScreenIconColor = Color.fromARGB(240, 240, 240, 240);
  static Color unselectedSubScreenIconColor =
      const Color.fromARGB(255, 90, 90, 90);
  static double subScreenIconSize = 13;
}

class LapSet {
  final String lapName;
  final String lapTime;
  final String lapSetString;
  const LapSet({Key? key, required this.lapName, required this.lapTime})
      : lapSetString = lapName + '      ' + lapTime;
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  bool isRunning = false;
  bool isStopped = false;
  bool isRefreshed = false;
  int subScreenNumber = 0;
  late Timer timer;
  int miliSeconds = 0;
  List<LapSet> lapList = [];
  int lapCount = 1;
  bool isCheet = false; // cheet
  int cheetLapCount = 0; // cheet

  void Lap() {
    String lapName = '랩 ' + lapCount.toString();
    String lapTime = timeFormatting(miliSeconds, 2, 4) +
        ':' +
        timeFormatting(miliSeconds, 5, 7) +
        '.' +
        (isCheet // cheet
            ? timeFormatting(miliSeconds, 8, 9) +
                max(4, int.parse(timeFormatting(miliSeconds, 9, 10))).toString()
            : timeFormatting(miliSeconds, 8, 10));
    setState(() {
      lapList.add(LapSet(lapName: lapName, lapTime: lapTime));
    });
    lapCount += 1;
    cheetLapCount += 1; // cheet
    isCheet = ((isCheet) & (cheetLapCount >= 2)) ? false : isCheet; // cheet
    cheetLapCount = isCheet ? cheetLapCount : 0; // cheet
  }

  void onTick(Timer timer) {
    setState(() {
      miliSeconds += 1;
    });
  }

  void startStop() {
    setState(() {
      if (isRunning == true) {
        isStopped = !isStopped;
        timer.cancel();
      } else {
        isStopped = false;
        timer = Timer.periodic(Duration(milliseconds: 1), onTick);
      }
      isRunning = !isRunning;
      isRefreshed = false;
    });
    print(isRunning);
  }

  void refresh() {
    setState(() {
      isRefreshed = true;
      isStopped = false;
      isRunning = false;
      miliSeconds = 0;
      lapCount = 1;
      lapList.clear();
    });
  }

  void toggleCheet() {
    // cheet
    setState(() {
      isCheet = !isCheet;
    });
  }

  String timeFormatting(int miliSeconds, int start, int end) {
    var duration = Duration(milliseconds: miliSeconds);
    return duration.toString().substring(start, end);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        body: Column(
          children: [
            Container(
                height: 180,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: toggleCheet,
                      icon: Icon(
                        Icons.rectangle,
                        size: 150,
                      ),
                      color: Colors.black,
                    )
                  ],
                )),
            // SizedBox(
            //   height: 190,
            // ),
            Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 17,
                    ),
                    Container(
                        width: 100,
                        child: Text(
                          timeFormatting(miliSeconds, 2, 4),
                          style: GlobalSetting.timeTextStyle,
                        )),
                    Container(
                        width: 25,
                        child: Text(
                          ':',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: GlobalSetting.timeFontSize,
                              fontWeight: FontWeight.w200,
                              letterSpacing: 5.0),
                        )),
                    Container(
                        width: 100,
                        child: Text(
                          timeFormatting(miliSeconds, 5, 7),
                          style: GlobalSetting.timeTextStyle,
                        )),
                    Container(
                        width: 20,
                        child: Text(
                          '.',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: GlobalSetting.timeFontSize,
                              fontWeight: FontWeight.w200,
                              letterSpacing: 0),
                        )),
                    Container(
                        width: 115,
                        child: Text(
                          timeFormatting(miliSeconds, 8, 10),
                          style: GlobalSetting.timeTextStyle,
                        )),
                  ],
                )), // 시간초
            SizedBox(
              height: 80,
            ),
            Flexible(
                // 랩/시작 버튼
                child: Container(
                    child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(children: [
                  IconButton(
                    onPressed: isStopped ? refresh : Lap,
                    icon: Icon(Icons.circle,
                        color: (isRunning || isStopped)
                            ? GlobalSetting.lapRefreshButtonColorAct
                            : GlobalSetting.lapRefreshButtonColorDeact),
                    iconSize: GlobalSetting.stopwatchStartStopIconSize,
                  ),
                  Positioned(
                    left: (isStopped) ? 36 : 49,
                    top: 47,
                    child: Text(
                      (isStopped)
                          ? GlobalSetting.lapRefreshButtonTextAct
                          : GlobalSetting.lapRefreshButtonTextDeact,
                      style: TextStyle(
                          color: (isRunning || isStopped)
                              ? GlobalSetting.lapRefreshButtonTextColorAct
                              : GlobalSetting.lapRefreshButtonTextColorDeact,
                          fontSize: GlobalSetting.startStopFontSize),
                    ),
                  ),
                  IconButton(
                    onPressed: isStopped ? refresh : Lap,
                    icon: Icon(Icons.circle, color: Color.fromARGB(0, 0, 0, 0)),
                    iconSize: GlobalSetting.stopwatchStartStopIconSize,
                  ),
                ]),
                SizedBox(
                  width: 65,
                ),
                Column(
                  children: [
                    SizedBox(height: 50),
                    Icon(Icons.circle,
                        color: isCheet
                            ? GlobalSetting.unselectedSubScreenIconColor
                            : GlobalSetting.selectedSubScreenIconColor,
                        size: GlobalSetting.subScreenIconSize),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Icon(Icons.circle,
                        color: isCheet
                            ? GlobalSetting.selectedSubScreenIconColor
                            : GlobalSetting.unselectedSubScreenIconColor,
                        size: GlobalSetting.subScreenIconSize),
                  ],
                ),
                SizedBox(
                  width: 65,
                ),
                Stack(children: [
                  Positioned(
                    left: 42,
                    top: 47,
                    child: Text(
                      isRunning
                          ? GlobalSetting.startStopButtonTextAct
                          : GlobalSetting.startStopButtonTextDeact,
                      style: TextStyle(
                          color: isRunning
                              ? GlobalSetting.startStopButtonTextColorAct
                              : GlobalSetting.startStopButtonTextColorDeact,
                          fontSize: GlobalSetting.startStopFontSize),
                    ),
                  ),
                  IconButton(
                    onPressed: startStop,
                    icon: Icon(Icons.circle,
                        color: isRunning
                            ? GlobalSetting.startStopButtonColorAct
                            : GlobalSetting.startStopButtonColorDeact),
                    iconSize: GlobalSetting.stopwatchStartStopIconSize,
                  ),
                ])
              ],
              // ),
            ))),
            SizedBox(
              height: 15,
            ),
            Divider(
              color: Color.fromARGB(50, 230, 230, 230),
              thickness: 1.2,
              height: 25,
            ),
            // lapListWidget(lapName: 'lap1', lapTime: 12345),
            Expanded(
                flex: 3,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: lapList.length,
                    itemBuilder: (context, index) {
                      final LapSet lap = lapList[lapList.length - 1 - index];
                      return lapListWidget(
                          lapName: lap.lapName, lapTime: lap.lapTime);
                    })),
            BottomNavigator()
          ],
        ));
  }
}

class lapListWidget extends StatelessWidget {
  final String lapName;
  final String lapTime;
  static TextStyle textStyle =
      TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500);

  const lapListWidget({Key? key, required this.lapName, required this.lapTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 36,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    lapName,
                    style: textStyle,
                  ),
                  Text(
                    lapTime.toString(),
                    style: textStyle,
                  )
                ]),
          ),
        ),
        Divider(
          color: Color.fromARGB(50, 230, 230, 230),
          thickness: 1.2,
        ),
      ],
    );
  }
}
