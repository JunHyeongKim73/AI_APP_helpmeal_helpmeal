/*import 'package:flutter/material.dart';

class MyReviewPage extends StatelessWidget {
  const MyReviewPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('myReview'),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/*
class Date {
  int year;
  int month;
  int day;
  date(this.year, this.month, this.day);
}

class PastReview {
  Date date;
  int score;
  String review;
  pastReview(this.date, this.score, this.review);
}

class PastReviewTile {
  final PastReview pastReview;
  PastReviewTile(this.pastReview);
  Widget build(
    
  )
}*/
//자료를 담는 list를 구성하는 방식 개선 필요
final List<int> date_year = <int>[2021, 2021, 2021, 2021, 2021];
final List<int> date_month = <int>[7, 8, 8, 9, 10];
final List<int> date_day = <int>[30, 6, 25, 13, 2];
//final List<Date> date; = <Date> [{2021,7,30},{2021,8,6},{2021,8,25},{2021,9,13},{2021,10,2}];
final List<int> score = <int>[7, 5, 10, 8, 9];
final List<String> pastReview = <String>[
  "그럭저럭 괜찮은 것 같아요",
  "너무 맛이 없어요 ㅠㅠ",
  "매일이 오늘같았으면 좋겠어요!!",
  "생각보다 맛있는 것 같아요",
  "맛있는 식사 만들어주셔서 감사합니다!",
];

void main() => runApp(MyReviewPage());

class MyReviewPage extends StatefulWidget {
  const MyReviewPage({Key? key}) : super(key: key);

  @override
  MyReviewPageState createState() => MyReviewPageState();
}

class MyReviewPageState extends State<MyReviewPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My 리뷰'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Container(
              width: 350,
              height: 1000, //height 크기 가변적 조정 필요
              child: ListView.separated(
                itemBuilder: (BuildContext context, int i) {
                  return Container(
                    width: 350,
                    height: 100,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 350,
                          height: 30,
                          child: Row(
                            children: <Widget>[
                              Container(
                                  width: 100,
                                  child: Text(
                                      '${date_year[i]}.${date_month[i]}.${date_day[i]}')
                                  /*Text.rich(
                                  TextSpan(
                                    text: Text('${date[i].year}'),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: Text('${date[i].month}'),
                                      ),
                                      TextSpan(
                                        text: Text('${date[i].day}'),
                                      )
                                    ]
                                  )
                                )*/
                                  ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: <Widget>[
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
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 5,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            //alignment: Alignment.center,
                            height: 40,
                            width: 350,
                            child: Text(
                              pastReview[i],
                              style: GoogleFonts.doHyeon(fontSize: 15),
                              softWrap: true,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: pastReview.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(color: Colors.grey.shade200, thickness: 1.0);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
