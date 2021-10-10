import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:myapp/src/controller/date_controller.dart';
import 'package:myapp/src/model/colors.dart';

class ReviewAnalysisPage extends StatelessWidget {
  const ReviewAnalysisPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                const SizedBox(height: 30),
                Row(
                  children: const [
                    SizedBox(width: 20),
                    Text(
                      '리뷰 정리본은 매주 월요일에 제공됩니다.',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  _getWeekOfMonth(controller.dateText),
                  style: GoogleFonts.roboto(fontSize: 18),
                ),
                const SizedBox(height: 30),
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
                _rankContainer('2', '치킨마요', Colors.lightBlue[100], Colors.blue),
                const SizedBox(height: 10),
                _rankContainer('3', '참치마요', Colors.lightBlue[100], Colors.blue),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Text('Worst 3',
                        style:
                            GoogleFonts.anton(fontSize: 28, color: Colors.red)),
                  ],
                ),
                const SizedBox(height: 15),
                _rankContainer('1', '햄소시지찌개', Colors.red[100], Colors.red),
                const SizedBox(height: 10),
                _rankContainer('2', '고등어순살조림', Colors.red[100], Colors.red),
                const SizedBox(height: 10),
                _rankContainer('3', '오이무침', Colors.red[100], Colors.red),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Text('개선점', style: GoogleFonts.doHyeon(fontSize: 28, color: CustomColor.themeColor)),
                  ],
                ),
                const Image(
                  image: AssetImage('assets/wordcloud.jpg'),
                  height: 300,
                ),
                Row(
                  children: const [
                    SizedBox(width: 10),
                    Text('밥 바꿔야해요!'),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Text('긍정', style: GoogleFonts.doHyeon(fontSize: 28, color: Colors.blue)),
                  ],
                ),
                const Image(
                  image: AssetImage('assets/wordcloud.jpg'),
                  height: 300,
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Text('부정', style: GoogleFonts.doHyeon(fontSize: 28, color: Colors.red)),
                  ],
                ),
                const Image(
                  image: AssetImage('assets/wordcloud.jpg'),
                  height: 300,
                ),
              ],
            ),
          ),
        ),
      );
    });
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
