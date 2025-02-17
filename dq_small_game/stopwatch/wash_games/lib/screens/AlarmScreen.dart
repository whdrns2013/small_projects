import 'package:flutter/cupertino.dart';
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  alignment: Alignment.topLeft,
                  child: Text(
                    '알람',
                    style: TextStyle(
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.bed,
                        color: Colors.white,
                        size: 28,
                      ),
                      Text(
                        ' 수면 | 기상',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Divider(
                      color: Color.fromARGB(50, 230, 230, 230),
                      thickness: 1.2,
                      height: 10),
                ),
                AlarmCard(
                  time: '07:30',
                  desc: ' 내일 아침',
                  componenetType: 'other',
                  isSwitched: false,
                ),
                SizedBox(
                  height: 45,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    children: [
                      Text(
                        '기타',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Divider(
                      color: Color.fromARGB(50, 230, 230, 230),
                      thickness: 1.2,
                      height: 10),
                ),
                Column(
                  children: [
                    AlarmCard(
                      time: '03:00',
                      desc: ' 알람',
                      componenetType: 'cupSwitch',
                      isSwitched: false,
                    ),
                    AlarmCard(
                      time: '04:00',
                      desc: ' 알람',
                      componenetType: 'cupSwitch',
                      isSwitched: false,
                    ),
                    AlarmCard(
                      time: '05:00',
                      desc: ' 알람',
                      componenetType: 'cupSwitch',
                      isSwitched: false,
                    ),
                    AlarmCard(
                      time: '06:00',
                      desc: ' 알람',
                      componenetType: 'cupSwitch',
                      isSwitched: false,
                    ),
                    AlarmCard(
                      time: '07:40',
                      desc: ' 알람',
                      componenetType: 'cupSwitch',
                      isSwitched: false,
                    ),
                    AlarmCard(
                      time: '08:00',
                      desc: ' 알람',
                      componenetType: 'cupSwitch',
                      isSwitched: false,
                    ),
                  ],
                ),
              ]),
            ),
          ),
          BottomNavigator()
        ]));
  }
}

class AlarmCard extends StatefulWidget {
  final String time;
  final String desc;
  final String componenetType;
  final bool isSwitched;

  const AlarmCard({
    required this.time,
    required this.desc,
    required this.componenetType,
    required this.isSwitched,
    super.key,
  });

  @override
  State<AlarmCard> createState() => _AlarmCardState();
}

class _AlarmCardState extends State<AlarmCard> {
  late bool isSwitched;

  @override
  void initState() {
    super.initState();
    isSwitched = widget.isSwitched;
  }

  dynamic whatIsComponent(String componenetType) {
    if (componenetType == 'cupSwitch') {
      return CupertinoSwitch(
          value: isSwitched,
          onChanged: (bool value) {
            setState(() {
              isSwitched = value;
            });
          });
    }
    return Container(
      width: 53,
      height: 35,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 73, 73, 73),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '변경',
            style: TextStyle(
                color: Colors.orange,
                fontSize: 17,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.zero,
              // height: 70,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.time,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 55,
                              fontWeight: FontWeight.w300),
                        ),
                        Text(widget.desc,
                            style: TextStyle(color: Colors.grey, fontSize: 15))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [whatIsComponent(widget.componenetType)],
                    )
                  ]),
            ),
            Divider(
                color: Color.fromARGB(50, 230, 230, 230),
                thickness: 1.2,
                height: 15),
          ],
        ));
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 20,
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
    ]);
  }
}
