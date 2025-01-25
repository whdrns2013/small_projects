import 'package:flutter/material.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});
  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class GlobalSetting {
  static const double stopwatchFontSize = 80;
  static const double stopwatchStartStopIconSize = 100;
  static const double bellowIconSize = 40;
  static const double bellowIconFontSize = 20;
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  void nullAction() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        body: Column(
          children: [
            SizedBox(
              height: 230,
            ),
            Flexible(
                child: Container(
                    child: Text(
              "00 : 00 : 00",
              style: TextStyle(
                color: Colors.white,
                fontSize: GlobalSetting.stopwatchFontSize,
                fontWeight: FontWeight.w200,
              ),
            ))), // 시간초
            SizedBox(
              height: 80,
            ),
            Flexible(
                // 랩/시작 버튼
                child: Container(
                    child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: nullAction,
                  icon: Icon(Icons.circle, color: Colors.grey),
                  iconSize: GlobalSetting.stopwatchStartStopIconSize,
                ),
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
                IconButton(
                  onPressed: nullAction,
                  icon: Icon(Icons.circle, color: Colors.grey),
                  iconSize: 100,
                ),
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
