import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
//나중에 MaterialApp 제거해야함

class RankingPage extends StatefulWidget {
  RankingPageState createState() => RankingPageState();
}

class RankingPageState extends State<RankingPage> {
  final isSelected = <bool>[true, false, false];
  //메뉴와 별점을 api에서 전달받는 것을 나중에 추가로 구현해야 함
  final List<String> menuRank = <String>[
    "돈가스",
    "스팸마요덮밥",
    "김치볶음",
    "소고기미역국",
    "오삼불고기"
  ];
  final List<int> score = <int>[10, 9, 8, 6, 5];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HelpMeal'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ToggleButtons(
                  color: Colors.grey.shade800,
                  selectedColor: Colors.amber.shade700,
                  selectedBorderColor: Colors.amber.shade700,
                  fillColor: Colors.amber.shade200,
                  splashColor: Colors.amber.shade300,
                  borderRadius: BorderRadius.circular(4.0),
                  constraints: BoxConstraints(minHeight: 36.0),
                  isSelected: isSelected,
                  onPressed: (index) {
                    setState(() {
                      if (!isSelected[index]) {
                        isSelected[0] = false;
                        isSelected[1] = false;
                        isSelected[2] = false;
                        isSelected[index] = true;
                      }
                    });
                  },
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child:
                          Text('일간', style: GoogleFonts.doHyeon(fontSize: 15)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child:
                          Text('주간', style: GoogleFonts.doHyeon(fontSize: 15)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child:
                          Text('월간', style: GoogleFonts.doHyeon(fontSize: 15)),
                    ),
                  ]),
              SizedBox(
                height: 60,
              ),
              Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 5,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  width: 350,
                  height: 300,
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemCount: menuRank.length,
                    itemBuilder: (BuildContext context, int i) {
                      final int rank = i + 1;
                      return Container(
                          height: 40,
                          child: Row(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  width: 40,
                                  child: Text(
                                    "$rank",
                                    style: GoogleFonts.doHyeon(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  color: Colors.amber.shade400,
                                ),
                                Expanded(
                                    child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    menuRank[i],
                                    style: GoogleFonts.doHyeon(fontSize: 20),
                                  ),
                                )),
                                Row(children: <Widget>[
                                  Icon(
                                    score[i] > 1
                                        ? Icons.star_rounded
                                        : (score[i] == 1
                                            ? Icons.star_half_rounded
                                            : Icons.star_border_rounded),
                                    color: Colors.amber.shade500,
                                    size: 30,
                                  ),
                                  Icon(
                                    score[i] > 3
                                        ? Icons.star_rounded
                                        : (score[i] == 3
                                            ? Icons.star_half_rounded
                                            : Icons.star_border_rounded),
                                    color: Colors.amber.shade500,
                                    size: 30,
                                  ),
                                  Icon(
                                    score[i] > 5
                                        ? Icons.star_rounded
                                        : (score[i] == 5
                                            ? Icons.star_half_rounded
                                            : Icons.star_border_rounded),
                                    color: Colors.amber.shade500,
                                    size: 30,
                                  ),
                                  Icon(
                                    score[i] > 7
                                        ? Icons.star_rounded
                                        : (score[i] == 7
                                            ? Icons.star_half_rounded
                                            : Icons.star_border_rounded),
                                    color: Colors.amber.shade500,
                                    size: 30,
                                  ),
                                  Icon(
                                    score[i] > 9
                                        ? Icons.star_rounded
                                        : (score[i] == 9
                                            ? Icons.star_half_rounded
                                            : Icons.star_border_rounded),
                                    color: Colors.amber.shade500,
                                    size: 30,
                                  ),
                                ])
                              ]));
                    },
                  )),
            ]),
      ),
    );
  }
}
