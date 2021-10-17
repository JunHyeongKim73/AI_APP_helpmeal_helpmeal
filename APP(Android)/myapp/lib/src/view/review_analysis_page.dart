import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:myapp/src/controller/date_controller.dart';
import 'package:myapp/src/model/analysis/analysis_menu.dart';
import 'package:myapp/src/model/analysis/analysis_repository.dart';
import 'package:myapp/src/model/analysis/analysis_review.dart';
import 'package:flutter_scatter/flutter_scatter.dart';

class ReviewAnalysisPage extends StatefulWidget {
  const ReviewAnalysisPage({Key? key}) : super(key: key);

  @override
  State<ReviewAnalysisPage> createState() => _ReviewAnalysisPageState();
}

class _ReviewAnalysisPageState extends State<ReviewAnalysisPage> {
  static const int firstBound = 80;
  static const int secondBound = 50;
  static const int thirdBound = 30;

  final Future<List<MenuAnalysis>> bestList =
      AnalysisRepository.getMenuAnalysis('best');
  final Future<List<MenuAnalysis>> worstList =
      AnalysisRepository.getMenuAnalysis('worst');
  final Future<List<ReviewAnalysis>> postiveList =
      AnalysisRepository.getReviewAnalysis('positive');
  final Future<List<ReviewAnalysis>> negativeList =
      AnalysisRepository.getReviewAnalysis('negative');

  @override
  void initState() {
    
    // TODO: implement initState
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
          physics: const ScrollPhysics(),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                      // Best 5
                      Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              Text('Best 5',
                                  style: GoogleFonts.anton(
                                      fontSize: 28, color: Colors.blue)),
                            ],
                          ),
                          const SizedBox(height: 15),
                          FutureBuilder<List<MenuAnalysis>>(
                            future: bestList,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: _rankContainer(
                                          '${index + 1}',
                                          snapshot.data![index].name,
                                          Colors.lightBlue[100],
                                          Colors.blue),
                                    );
                                  },
                                );
                              }
                              return Container();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      // Worst 5
                      Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              Text('Worst 5',
                                  style: GoogleFonts.anton(
                                      fontSize: 28, color: Colors.red)),
                            ],
                          ),
                          const SizedBox(height: 15),
                          FutureBuilder<List<MenuAnalysis>>(
                            future: worstList,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: _rankContainer(
                                          '${index + 1}',
                                          snapshot.data![index].name,
                                          Colors.red[100],
                                          Colors.red),
                                    );
                                  },
                                );
                              }
                              return Container();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // 긍정 리뷰 분석
                Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Text('긍정',
                            style: GoogleFonts.doHyeon(
                                fontSize: 36, color: Colors.blue)),
                      ],
                    ),
                    FutureBuilder<List<ReviewAnalysis>>(
                      future: postiveList,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<ScatterItem> posWidgets = [];

                          int len = snapshot.data!.length;
                          int idx = 0;
                          for (var analysis in snapshot.data!) {
                            Map<String, dynamic> maps = analysis.mapData!;
                            posWidgets.add(
                              ScatterItem(
                                idx : idx,
                                text: maps['word'],
                                color: _setPositiveItemColor(idx, len),
                                size: _setItemSize(idx, len),
                                turn: _setTurn(idx, len),
                              ),
                            );
                            idx++;
                          }

                          posWidgets.shuffle();
                          setNumberOneFirstIndex(posWidgets);

                          return FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Scatter(
                                fillGaps: true,
                                alignment: Alignment.topLeft,
                                delegate:
                                    FermatSpiralScatterDelegate(ratio: ratio),
                                children: posWidgets,
                              ),
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // 부정 리뷰 분석
                Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Text('부정',
                            style: GoogleFonts.doHyeon(
                                fontSize: 36, color: Colors.red)),
                      ],
                    ),
                    FutureBuilder<List<ReviewAnalysis>>(
                      future: negativeList,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<ScatterItem> negWidgets = [];

                          int len = snapshot.data!.length;
                          int idx = 0;
                          for (var analysis in snapshot.data!) {
                            Map<String, dynamic> maps = analysis.mapData!;
                            negWidgets.add(
                              ScatterItem(
                                idx: idx,
                                text: maps['word'],
                                color: _setNegativeItemColor(idx, len),
                                size: _setItemSize(idx, len),
                                turn: _setTurn(idx, len),
                              ),
                            );
                            idx++;
                          }

                          negWidgets.shuffle();
                          setNumberOneFirstIndex(negWidgets);

                          return FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Scatter(
                                fillGaps: true,
                                alignment: Alignment.topLeft,
                                delegate:
                                  ArchimedeanSpiralScatterDelegate(ratio: ratio),
                                children: negWidgets,
                              ),
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Color _setPositiveItemColor(int idx, int len) {
    switch (idx) {
      case 0:
        return Colors.blueAccent;
      case 1:
        return Colors.lightBlue[400]!;
      case 2:
        return Colors.amber.shade900;
      default:
        int percent = (100 * ((len - idx) / len)).ceil();
        if (percent >= firstBound) {
          return Colors.purpleAccent;
        } else if (percent >= secondBound) {
          return Colors.greenAccent;
        } else if (percent >= thirdBound) {
          return Colors.cyan[200]!;
        } else {
          return Colors.black;
        }
    }
  }

  Color _setNegativeItemColor(int idx, int len) {
    switch (idx) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.redAccent;
      case 2:
        return Colors.amber;
      default:
        int percent = (100 * ((len - idx) / len)).ceil();
        if (percent >= firstBound) {
          return Colors.purple[800]!;
        } else if (percent >= secondBound) {
          return Colors.green[600]!;
        } else if (percent >= thirdBound) {
          return Colors.cyan[600]!;
        } else {
          return Colors.black;
        }
    }
  }

  double _setItemSize(int idx, int len) {
    switch (idx) {
      case 0:
        return 160;
      case 1:
        return 120;
      case 2:
        return 80;
      default:
        int percent = (100 * ((len - idx) / len)).ceil();
        if (percent >= firstBound) {
          return 50;
        } else if (percent >= secondBound) {
          return 20;
        } else if (percent >= thirdBound) {
          return 15;
        } else {
          return 10;
        }
    }
  }

  int _setTurn(int idx, int len) {
    switch (idx) {
      case 0:
      case 1:
      case 2:
        return 0;
      default:
        int percent = (100 * ((len - idx) / len)).ceil();
        if (percent >= firstBound) {
          return 0;
        } else if (percent >= secondBound) {
          return 1;
        } else if (percent >= thirdBound) {
          return 0;
        } else {
          return 1;
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

void setNumberOneFirstIndex(List<ScatterItem> lists) {
  int firstIndex = lists.indexWhere((item) => item.idx == 0);
  
  ScatterItem temp = lists[0];
  lists[0] = lists[firstIndex];
  lists[firstIndex] = temp;
  
}

class ScatterItem extends StatelessWidget {
  final int idx;
  final String text;
  final Color color;
  final double size;
  final int turn;
  const ScatterItem(
      {Key? key,
      required this.idx,
      required this.text,
      required this.color,
      required this.size,
      required this.turn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: turn,
      child: Text(text,
          style: GoogleFonts.poorStory(color: color, fontSize: size + 10)),
    );
  }
}



