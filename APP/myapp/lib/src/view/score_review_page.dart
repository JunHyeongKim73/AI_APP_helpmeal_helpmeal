import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/src/model/colors.dart';

import 'package:myapp/src/model/fonts.dart';

void main() => runApp(const ScoreReviewPage());

//api로부터 리뷰 데이터를 받아오는 작업이 필요
final List<String> name = <String>[
  "yangbaechu",
  "JunHyeongKim73",
  "star8041",
  "Army2021",
  "Dinner99",
  "osamkr",
  "abmin"
];
final List<String> review = <String>[
  "항상 맛있는 식사 감사합니다! 돈가스가 특히 맛있었습니다.",
  "오늘 점심의 소고기미역국이 좋았습니다. 그렇지만 돈가스의 양이 부족해서 아쉬워요.",
  "제발 버섯튀김 좀 안 나오게 해주세요...",
  "내 인생 최고의 맛집이자 미슐랭 가이드 등재 후보",
  "제 미역국에 소고기가 별로 없었습니다. 다음에는 좀만 더 많이 주세요.",
  "김치볶음 생각보다 맛있음",
  "오늘 점심을 먹고 제 인생이 360도 달라졌습니다."
];

class ScoreReviewPage extends StatefulWidget {
  const ScoreReviewPage({Key? key}) : super(key: key);

  @override
  ScoreReviewPageState createState() => ScoreReviewPageState();
}

class ScoreReviewPageState extends State<ScoreReviewPage> {
  final List<String> menu = <String>[
    "돈가스",
    "스팸마요덮밥",
    "김치볶음",
    "소고기미역국",
    "오삼불고기"
  ];
  List<int> score = <int>[0, 0, 0, 0, 0];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Row(
                children: CustomFont(fontSize: 28).logo,
              ),
              centerTitle: true,
              titleSpacing: 25,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
            ),
            body: SingleChildScrollView(
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 350,
                        height: 250,
                        child: ListView.builder(
                          itemCount: menu.length,
                          itemBuilder: (BuildContext context, int i) {
                            return SizedBox(
                              height: 50,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 40,
                                      child: Text(
                                        menu[i],
                                        style:
                                            GoogleFonts.doHyeon(fontSize: 20),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    //alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    width: 200,
                                    child: InkWell(
                                      onTap: () {},
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            score[i] > 1
                                                ? Icons.star_rounded
                                                : (score[i] == 1
                                                    ? Icons.star_half_rounded
                                                    : Icons
                                                        .star_border_rounded),
                                            color: CustomColor.themeColor,
                                            size: 30,
                                          ),
                                          Icon(
                                            score[i] > 3
                                                ? Icons.star_rounded
                                                : (score[i] == 3
                                                    ? Icons.star_half_rounded
                                                    : Icons
                                                        .star_border_rounded),
                                            color: CustomColor.themeColor,
                                            size: 30,
                                          ),
                                          Icon(
                                            score[i] > 5
                                                ? Icons.star_rounded
                                                : (score[i] == 5
                                                    ? Icons.star_half_rounded
                                                    : Icons
                                                        .star_border_rounded),
                                            color: CustomColor.themeColor,
                                            size: 30,
                                          ),
                                          Icon(
                                            score[i] > 7
                                                ? Icons.star_rounded
                                                : (score[i] == 7
                                                    ? Icons.star_half_rounded
                                                    : Icons
                                                        .star_border_rounded),
                                            color: CustomColor.themeColor,
                                            size: 30,
                                          ),
                                          Icon(
                                            score[i] > 9
                                                ? Icons.star_rounded
                                                : (score[i] == 9
                                                    ? Icons.star_half_rounded
                                                    : Icons
                                                        .star_border_rounded),
                                            color: CustomColor.themeColor,
                                            size: 30,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                          width: 350,
                          height: 200,
                          child: Row(children: <Widget>[
                            const SizedBox(
                                width: 270,
                                height: 200,
                                child: TextField(
                                  maxLines: 10,
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: CustomColor.themeColor),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            width: 2, color: Colors.grey),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                      ),
                                      hintText: '오늘의 리뷰를 남겨주세요!',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      )),
                                )),
                            const SizedBox(width: 10),
                            Container(
                              alignment: Alignment.center,
                              width: 70,
                              height: 30,
                              child: ElevatedButton(
                                child: const Text('저장',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                onPressed: () {},
                              ),
                            )
                          ])),
                      const SizedBox(height: 10),
                      const SizedBox(
                        width: 350,
                        child: Divider(color: Colors.grey, thickness: 3.0),
                      ),
                      const SizedBox(height: 10),
                      Container(
                          width: 350,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '전체 리뷰 ??개',
                            style: GoogleFonts.doHyeon(fontSize: 15),
                          )),
                      SizedBox(
                        width: 350,
                        height:
                            100 * (review.length + 2), //height 가변적으로 조정할 필요 있음
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: SizedBox(
                                  width: 350,
                                  height: 100,
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          child: CircleAvatar(
                                              child: Text(name[index][0]
                                                  .toUpperCase())),
                                        ),
                                        Expanded(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                              Text(name[index],
                                                  style: GoogleFonts.doHyeon(
                                                      fontSize: 18)),
                                              const SizedBox(height: 8),
                                              Text(
                                                review[index],
                                                style: GoogleFonts.doHyeon(
                                                    fontSize: 15),
                                                softWrap: true,
                                              ),
                                            ]))
                                      ])),
                            );
                          },
                          itemCount: review.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                                color: Colors.grey.shade200, thickness: 2.0);
                          },
                        ),
                      ),
                    ])))));
  }
}
