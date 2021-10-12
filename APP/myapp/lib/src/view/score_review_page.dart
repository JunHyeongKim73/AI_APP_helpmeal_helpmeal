import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(ScoreReviewPage());

//api로부터 리뷰 데이터를 받아오는 작업이 필요
final List<String> name = <String> ["yangbaechu","JunHyeongKim73","star8041","Army2021","Dinner99","osamkr","abmin"];
final List<String> review = <String> ["항상 맛있는 식사 감사합니다! 돈가스가 특히 맛있었습니다.",
                                      "오늘 점심의 소고기미역국이 좋았습니다. 그렇지만 돈가스의 양이 부족해서 아쉬워요.",
                                      "제발 버섯튀김 좀 안 나오게 해주세요...",
                                      "내 인생 최고의 맛집이자 미슐랭 가이드 등재 후보",
                                      "제 미역국에 소고기가 별로 없었습니다. 다음에는 좀만 더 많이 주세요.",
                                      "김치볶음 생각보다 맛있음",
                                      "오늘 점심을 먹고 제 인생이 360도 달라졌습니다."
                                      ];

class ScoreReviewPage extends StatefulWidget {
  ScoreReviewPageState createState() => ScoreReviewPageState();
}

class ScoreReviewPageState extends State<ScoreReviewPage> {
  final List<String> menu = <String> ["돈가스","스팸마요덮밥","김치볶음","소고기미역국","오삼불고기"];
  List<int> score = <int> [0,0,0,0,0];
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('HelpMeal'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 350,
                  height: 250,
                  child: ListView.builder(
                    itemCount: menu.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Container(
                        height: 50,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                child: Text(menu[i], style: GoogleFonts.doHyeon(fontSize: 20),),
                                color: Colors.grey.shade300,
                              )
                            ),
                            Container(
                              //alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 25,),
                              width: 200,
                              child: InkWell(
                                onTap: () {},
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      score[i]>1 ? Icons.star_rounded : (score[i]==1 ? Icons.star_half_rounded : Icons.star_border_rounded),
                                      color: Colors.amber.shade500,
                                      size: 30,
                                    ),
                                    Icon(
                                      score[i]>3 ? Icons.star_rounded : (score[i]==3 ? Icons.star_half_rounded : Icons.star_border_rounded),
                                      color: Colors.amber.shade500,
                                      size: 30,
                                    ),
                                    Icon(
                                      score[i]>5 ? Icons.star_rounded : (score[i]==5 ? Icons.star_half_rounded : Icons.star_border_rounded),
                                      color: Colors.amber.shade500,
                                      size: 30,
                                    ),
                                    Icon(
                                      score[i]>7 ? Icons.star_rounded : (score[i]==7 ? Icons.star_half_rounded : Icons.star_border_rounded),
                                      color: Colors.amber.shade500,
                                      size: 30,
                                    ),
                                    Icon(
                                      score[i]>9 ? Icons.star_rounded : (score[i]==9 ? Icons.star_half_rounded : Icons.star_border_rounded),
                                      color: Colors.amber.shade500,
                                      size: 30,
                                    ),
                                  ]
                                )
                              )
                            ),
                          ]
                        )
                      );
                    }
                  )
                ),
                Container(
                  width: 350,
                  height: 200,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 270,
                        height: 200,
                        child: TextField(
                          maxLines: 10,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(width: 1, color: Colors.amber.shade400),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(width: 1, color: Colors.amber.shade200),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                            hintText: '오늘의 리뷰를 남겨주세요!',
                            hintStyle: TextStyle(fontSize: 14, color: Colors.grey,)
                          ),
                        )
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 70,
                        height: 30,
                        child: RaisedButton(
                          padding: EdgeInsets.symmetric(horizontal: 5,),
                          child: Text('저장', style: TextStyle(fontSize: 15)),
                          onPressed: () {},
                          color: Colors.blue,
                          textColor: Colors.white,
                        ),
                      )
                    ]
                  )
                ),
                Container(
                  width: 350,
                  child: Divider(color: Colors.grey.shade300, thickness: 3.0),
                ),
                Container(
                  width: 350,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '전체 리뷰 ??개',
                    style: GoogleFonts.doHyeon(fontSize: 15),
                  )
                ),
                SizedBox(
                  width: 350,
                  height: 800, //height 가변적으로 조정할 필요 있음
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: 350,
                        height: 100,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget> [
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: CircleAvatar(child: Text(name[index][0])),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget> [
                                  Text(name[index], style: GoogleFonts.doHyeon(fontSize: 18)),
                                  Text(
                                    review[index],
                                    style: GoogleFonts.doHyeon(fontSize: 15),
                                    softWrap: true,
                                  ),
                                ]
                              )
                            )
                          ]
                        )
                      );
                    },
                    itemCount: review.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(color: Colors.grey.shade200, thickness: 1.0);
                    }
                  )
                )
              ]
            )
          )
        )
      )
    );
  }
}