import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/src/model/colors.dart';

import 'package:myapp/src/model/fonts.dart';
import 'package:myapp/src/model/meal/food.dart';
import 'package:myapp/src/model/review/review.dart';
import 'package:myapp/src/model/review/review_repository.dart';
import 'package:myapp/src/model/review/star.dart';
import 'package:myapp/src/model/user/user.dart';

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
  final Map<String, dynamic> mapData = Get.arguments;
  Future<List<Review>>? reviewList;
  User? user;
  DateTime? date;
  int? index;
  List<Food>? foods;
  bool canUpdatePage = true;

  List<int>? selected;
  List<Star>? starList = [];

  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    user = mapData['user'];
    date = mapData['date'];
    index = mapData['index'];
    foods = mapData['food'];
    selected = List.filled(foods!.length, 0);
    for (var food in foods!) {
      starList!.add(Star(name: food.name, order: food.order, stars: 0));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (canUpdatePage) {
      reviewList =
          ReviewRepository.getFoodReview(date!, user!.groups!.troopId!, index!);
      canUpdatePage = false;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: CustomFont(fontSize: 28).logo,
        ),
        centerTitle: true,
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
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.only(left: 15),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: foods!.length,
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
                                  foods![i].name,
                                  style: GoogleFonts.doHyeon(fontSize: 20),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            _starRating(i),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  maxLines: 10,
                  controller: controller,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(width: 2, color: CustomColor.themeColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 2, color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    hintText: '리뷰를 입력해주세요!\n리뷰를 작성하지 않아도 별점만 저장할 수 있어요!',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.only(right: 20),
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  width: 70,
                  height: 30,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('저장',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w800)),
                    onPressed: () async {
                      String result = await ReviewRepository.postStar(
                          date!, user!.groups!.troopId!, index!, starList!);
                      if (controller.text != '') {
                        result = await ReviewRepository.postReview(
                            date!,
                            user!.groups!.troopId!,
                            index!,
                            user!.userId!,
                            controller.text);
                        setState(() {
                          canUpdatePage = true;
                        });
                      }
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text(result),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () => Get.back(),
                                  child: const Text('확인'))
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(
                  color: Colors.grey,
                  thickness: 3.0,
                  indent: 15,
                  endIndent: 15),
              const SizedBox(height: 10),
              FutureBuilder<List<Review>>(
                future: reviewList,
                builder: (context, snapshot) {
                  return Container(
                    padding: const EdgeInsets.only(left: 15),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      snapshot.hasData
                          ? '전체 리뷰 ${snapshot.data!.length}개'
                          : '전체 리뷰 0개',
                      style: GoogleFonts.doHyeon(fontSize: 15),
                    ),
                  );
                },
              ),
              FutureBuilder<List<Review>>(
                  future: reviewList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 20),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    child: CircleAvatar(
                                        backgroundColor: CustomColor.themeColor,
                                        child: Text(
                                          snapshot.data![index].name![0],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800),
                                        )),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(snapshot.data![index].name!,
                                            style: GoogleFonts.doHyeon(
                                                fontSize: 18)),
                                        const SizedBox(height: 5),
                                        Text(
                                          snapshot.data![index].comment!,
                                          style:
                                              GoogleFonts.doHyeon(fontSize: 15),
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                                color: Colors.grey.shade200, thickness: 2.0);
                          },
                        ),
                      );
                    }
                    return Container(
                      padding: const EdgeInsets.only(left: 15, bottom: 20),
                      alignment: Alignment.center,
                      height: 100,
                      child: const Text('아무도 리뷰를 작성하지 않았어요!'),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  RatingBar _starRating(int i) {
    return RatingBar.builder(
      initialRating: 0,
      minRating: 1,
      direction: Axis.horizontal,
      itemCount: 5,
      itemSize: 30,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
      onRatingUpdate: (rating) {
        print(rating);
        setState(() {
          starList![i].mapData!['stars'] = rating as int?;
        });
      },
    );
  }
}
