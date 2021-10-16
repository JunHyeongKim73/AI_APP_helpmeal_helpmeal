import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:myapp/src/controller/date_controller.dart';
import 'package:myapp/src/model/colors.dart';
import 'package:flutter_scatter/flutter_scatter.dart';

class ReviewAnalysisPage extends StatefulWidget {
  const ReviewAnalysisPage({Key? key}) : super(key: key);

  @override
  State<ReviewAnalysisPage> createState() => _ReviewAnalysisPageState();
}

class _ReviewAnalysisPageState extends State<ReviewAnalysisPage> {
  final List<Map<String, dynamic>> mapList = [
    {'food': '적당', 'freq': 15},
    {'food': '치킨', 'freq': 10},
    {'food': '식단관리', 'freq': 9},
    {'food': '청결', 'freq': 6},
    {'food': '식당관리', 'freq': 5},
    {'food': '휴지', 'freq': 4},
    {'food': '급식', 'freq': 4},
    {'food': '양', 'freq': 3},
    {'food': '개선', 'freq': 2},
    {'food': '시리얼', 'freq': 1},
    {'food': '너무', 'freq': 1},
    {'food': '적어', 'freq': 1},
  ];
  List<Widget> widgets = [];
  @override
  void initState() {
    for (var maps in mapList) {
      widgets.add(ScatterItem(
          text: maps['food'],
          color: _setItemColor(maps['freq']),
          size: _setItemSize(maps['freq'])));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final ratio = screenSize.width / screenSize.height;

    return GetBuilder<DateController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text('리뷰&댓글 분석',
              style: GoogleFonts.doHyeon(fontSize: 24, color: Colors.white)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 20),
                  child: Row(
                    children: const [
                      SizedBox(width: 20),
                      Text(
                        '리뷰 정리본은 매주 월요일에 제공됩니다.',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
                Text(
                  _getWeekOfMonth(controller.dateText),
                  style: GoogleFonts.roboto(fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          Text('Best 3',
                              style: GoogleFonts.anton(
                                  fontSize: 28, color: Colors.blue)),
                        ],
                      ),
                      const SizedBox(height: 15),
                      _rankContainer(
                          '1', '김치볶음밥', Colors.lightBlue[100], Colors.blue),
                      const SizedBox(height: 10),
                      _rankContainer(
                          '2', '치킨마요', Colors.lightBlue[100], Colors.blue),
                      const SizedBox(height: 10),
                      _rankContainer(
                          '3', '참치마요', Colors.lightBlue[100], Colors.blue),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Text('Worst 3',
                            style: GoogleFonts.anton(
                                fontSize: 28, color: Colors.red)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    _rankContainer('1', '햄소시지찌개', Colors.red[100], Colors.red),
                    const SizedBox(height: 10),
                    _rankContainer('2', '고등어순살조림', Colors.red[100], Colors.red),
                    const SizedBox(height: 10),
                    _rankContainer('3', '오이무침', Colors.red[100], Colors.red),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Text('긍정',
                        style: GoogleFonts.doHyeon(
                            fontSize: 28, color: Colors.blue)),
                  ],
                ),
                FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Scatter(
                      alignment: Alignment.topLeft,
                      delegate: FermatSpiralScatterDelegate(ratio: ratio),
                      children: widgets,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Text('부정',
                        style: GoogleFonts.doHyeon(
                            fontSize: 28, color: Colors.red)),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Color _setItemColor(int freq) {
    List<int> freqList = [];
    for (var map in mapList) {
      freqList.add(map['freq']);
    }
    freqList.sort((b, a) => a.compareTo(b));

    int len = freqList.length;
    int idx = freqList.indexOf(freq);

    switch (idx) {
      case 0:
        return Colors.blueAccent;
      case 1:
        return Colors.redAccent;
      case 2:
        return Colors.amber.shade900;
      default:
        int percent = (100 * ((len - idx) / len)).ceil();
        if (percent >= 60) {
          return Colors.green;
        } else if (percent >= 40) {
          return Colors.purple;
        } else if (percent >= 30) {
          return Colors.cyan;
        } else {
          return Colors.black;
        }
    }
  }

  double _setItemSize(int freq) {
    List<int> freqList = [];
    for (var map in mapList) {
      freqList.add(map['freq']);
    }
    freqList.sort((b, a) => a.compareTo(b));

    int len = freqList.length;
    int idx = freqList.indexOf(freq);

    switch (idx) {
      case 0:
        return 50;
      case 1:
        return 40;
      case 2:
        return 30;
      default:
        int percent = 100 * ((len - idx) / len).ceil();
        if (percent >= 60) {
          return 25;
        } else if (percent >= 40) {
          return 20;
        } else if (percent >= 20) {
          return 15;
        } else {
          return 10;
        }
    }
  }

  Widget _rankContainer(
      String rank, String text, Color? containerColor, Color circleColor) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Container(
          width: 220,
          height: 50,
          decoration: BoxDecoration(
              color: containerColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                )
              ]),
          child: Row(
            children: [
              const SizedBox(width: 10),
              CircleAvatar(
                radius: 15,
                backgroundColor: circleColor,
                child: Text(rank, style: const TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 10),
              Text(text,
                  style:
                      GoogleFonts.doHyeon(fontSize: 20, color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }

  String _getWeekOfMonth(DateTime dateTime) {
    String date = dateTime.toString();
    String firstDay = date.substring(0, 8) + '01' + date.substring(10);
    int weekDay = DateTime.parse(firstDay).weekday;
    DateTime testDate = dateTime;
    int weekOfMonth;

    weekDay--;
    weekOfMonth = ((testDate.day + weekDay) / 7).ceil();
    weekDay++;

    if (weekDay == 7) {
      weekDay = 0;
    }
    weekOfMonth = ((testDate.day + weekDay) / 7).ceil();
    return '${DateFormat.yMMM('ko').format(dateTime)} ${weekOfMonth.toString()}주차';
  }
}

class ScatterItem extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  const ScatterItem(
      {Key? key, required this.text, required this.color, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.poorStory(color: color, fontSize: size + 10));
  }
}
