import 'dart:async';

import 'package:flutter/material.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});
  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class GlobalSetting {
  static const double timeFontSize = 90;
  static const double stopwatchStartStopIconSize = 100;
  static const double bellowIconSize = 40;
  static const double bellowIconFontSize = 20;

  static Color startStopButtonTextColorDeact =
      const Color.fromARGB(240, 0, 255, 0);
  static Color startStopButtonColorDeact = const Color.fromARGB(90, 0, 150, 0);
  static Color startStopButtonTextColorAct =
      const Color.fromARGB(255, 255, 50, 50);
  static Color startStopButtonColorAct = const Color.fromARGB(80, 150, 0, 0);

  static Color lapRefreshButtonTextColorDeact =
      const Color.fromARGB(200, 150, 150, 150);
  static Color lapRefreshButtonColorDeact =
      const Color.fromARGB(100, 150, 150, 150);
  static Color lapRefreshButtonTextColorAct =
      const Color.fromARGB(200, 200, 200, 200);
  static Color lapRefreshButtonColorAct =
      const Color.fromARGB(100, 200, 200, 200);

  static double startStopFontSize = 16;
  static String startStopButtonTextDeact = '시작';
  static String startStopButtonTextAct = '중단';
  static String lapRefreshButtonTextDeact = '랩';
  static String lapRefreshButtonTextAct = '재설정';
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  bool isRunning = false;
  bool isStopped = false;
  bool isRefreshed = false;
  int subScreenNumber = 0;
  late Timer timer;
  int miliSeconds = 0;

  void nullAction() {}

  void Lap() {
    print('lap');
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
            SizedBox(
              height: 210,
            ),
            Flexible(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: 115,
                    child: Text(
                      timeFormatting(miliSeconds, 2, 4),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: GlobalSetting.timeFontSize,
                        fontWeight: FontWeight.w200,
                      ),
                    )),
                Container(
                    width: 30,
                    child: Text(
                      ':',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: GlobalSetting.timeFontSize,
                          fontWeight: FontWeight.w200,
                          letterSpacing: 5.0),
                    )),
                Container(
                    width: 115,
                    child: Text(
                      timeFormatting(miliSeconds, 5, 7),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: GlobalSetting.timeFontSize,
                        fontWeight: FontWeight.w200,
                      ),
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
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: GlobalSetting.timeFontSize,
                        fontWeight: FontWeight.w200,
                      ),
                    )),
              ],
            )), // 시간초
            SizedBox(
              height: 65,
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
                    left: (isStopped) ? 38 : 51,
                    top: 49,
                    child: Text(
                      (isStopped)
                          ? GlobalSetting.lapRefreshButtonTextAct
                          : GlobalSetting.lapRefreshButtonTextDeact,
                      style: TextStyle(
                          color: (isStopped || !isRefreshed)
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
                  width: 60,
                ),
                Icon(Icons.circle, color: Colors.grey, size: 15),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.circle, color: Colors.grey, size: 15),
                SizedBox(
                  width: 60,
                ),
                Stack(children: [
                  Positioned(
                    left: 44,
                    top: 49,
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
            Divider(
              color: Color.fromARGB(120, 230, 230, 230),
              thickness: 1.0,
            ),
            Flexible(
              // 하단 세계 시각 / 알람 / 스톱워치 / 타이머
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: [
                          IconButton(
                            onPressed: nullAction,
                            icon: Icon(
                              Icons.language,
                              color: Colors.grey,
                            ),
                            iconSize: GlobalSetting.bellowIconSize,
                          ),
                          Text(
                            "세계시계",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: GlobalSetting.bellowIconFontSize),
                          )
                        ]),
                        Column(children: [
                          IconButton(
                            onPressed: nullAction,
                            icon: Icon(
                              Icons.alarm,
                              color: Colors.grey,
                            ),
                            iconSize: GlobalSetting.bellowIconSize,
                          ),
                          Text(
                            "알람",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: GlobalSetting.bellowIconFontSize),
                          )
                        ]),
                        Column(children: [
                          IconButton(
                            onPressed: nullAction,
                            icon: Icon(
                              Icons.timer,
                              color: Colors.orange,
                            ),
                            iconSize: GlobalSetting.bellowIconSize,
                          ),
                          Text(
                            "스톱워치",
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: GlobalSetting.bellowIconFontSize),
                          )
                        ]),
                        Column(children: [
                          IconButton(
                            onPressed: nullAction,
                            icon: Icon(
                              // Icons.timer_outlined,
                              Icons.access_time,
                              color: Colors.grey,
                            ),
                            iconSize: GlobalSetting.bellowIconSize,
                          ),
                          Text(
                            "타이머",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: GlobalSetting.bellowIconFontSize),
                          )
                        ])
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
