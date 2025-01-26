import 'package:flutter/material.dart';
import 'package:wash_games/BottomNavigator.dart';
// TODO:: 현재 화면만 만들어놓음. 보강 필요

class WorldClockScreen extends StatefulWidget {
  const WorldClockScreen({super.key});

  @override
  State<WorldClockScreen> createState() => _WorldClockScreenState();
}

class _WorldClockScreenState extends State<WorldClockScreen> {
  DateTime dt = DateTime.now();
  List<WorldClockRow> worldClockList = [];
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
        Expanded(
            flex: 6,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  WorldClockRow(
                    timeGap: 0,
                    region: '서울',
                    dt: dt,
                  ),
                  WorldClockRow(
                    timeGap: 1,
                    region: '괌',
                    dt: dt,
                  ),
                  WorldClockRow(
                    timeGap: -17,
                    region: '로스앤젤레스',
                    dt: dt,
                  ),
                ],
              ),
            )),
        BottomNavigator()
      ]),
    );
  }
}

class WorldClockRow extends StatelessWidget {
  final int timeGap;
  final String region;
  final DateTime dt;
  const WorldClockRow(
      {Key? key, required this.timeGap, required this.region, required this.dt})
      : super(key: key);

  String timeGapDesc(timeGap) {
    String day = '오늘';
    if ((dt.hour.toInt() + timeGap) > 24) {
      day = '내일';
    } else if ((dt.hour.toInt() + timeGap) < 0) {
      day = '어제';
    }
    String hour = '시간';
    if (timeGap < 0) {
      hour = timeGap.toString() + hour;
    } else if (timeGap >= 0) {
      hour = '+' + timeGap.toString() + hour;
    }
    return day + ', ' + hour;
  }

  String currentTime(dt, timeGap) {
    String hour = ((dt.hour + timeGap) % 24).toString();
    if (hour.length == 1) {
      hour = '0' + hour;
    }
    String minute = dt.minute.toString();
    if (minute.length == 1) {
      minute = '0' + minute;
    }
    return hour + ':' + minute;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 20, 0),
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      timeGapDesc(timeGap),
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    Text(region,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w500))
                  ],
                ),
                Column(
                  children: [
                    Text(
                      currentTime(dt, timeGap),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.w300),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Divider(
                color: Color.fromARGB(50, 230, 230, 230),
                thickness: 1.2,
                height: 25),
          ),
        ],
      ),
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
