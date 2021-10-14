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

class MyReviewPage extends StatefulWidget {
  const MyReviewPage({Key? key}) : super(key: key);

  @override
  MyReviewPageState createState() => MyReviewPageState();
}

class MyReviewPageState extends State<MyReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('My 리뷰',
            style: GoogleFonts.doHyeon(fontSize: 24, color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 50),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                      height: 100,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(width: 10),
                              Text('${date_year[i]}.${date_month[i]}.${date_day[i]}',
                                  style: GoogleFonts.doHyeon(fontSize: 15)),
                            ],
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.amber.shade50,
                                border: Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    offset: const Offset(3, 3),
                                  )
                                ]
                              ),
                              child: Text(
                                pastReview[i],
                                style: GoogleFonts.doHyeon(fontSize: 15),
                                softWrap: true,
                              ),
                            )
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ]
                      )
                    )
                  );
                },
                itemCount: pastReview.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(color: Colors.grey.shade300, thickness: 1.0);
                },
              ),
            )
          ]
        ),
      ),
    );
  }
}
