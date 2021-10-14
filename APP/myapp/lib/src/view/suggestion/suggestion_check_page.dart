import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/src/model/suggestion/suggestion.dart';
import 'package:myapp/src/model/suggestion/suggestion_repository.dart';
import 'package:intl/date_symbol_data_local.dart' as intl;
import 'package:myapp/src/model/user/user.dart';

final List<String> suggestionName = <String>[
  "yangbaechu",
  "JunHyeongKim73",
  "star8041",
  "Army2021",
  "abmin"
];
final List<String> suggestionCheck = <String>[
  "버그가 너무 많아요 ㅠㅠ",
  "빵식 좀 적게 나왔으면 좋겠어요",
  "UI가 너무 구려요",
  "저희 사단 식단표대로 나오지 않는 것 같습니다",
  "너무 맛없고, 너무 정확도가 떨어지고, 너무 못 만들었어요. 미완성인 것처럼 보이기도 하고요. 좀 많이 개선점이 필요해보여요."
];

class SuggestionCheckPage extends StatefulWidget {
  const SuggestionCheckPage({Key? key}) : super(key: key);

  @override
  SuggestionCheckPageState createState() => SuggestionCheckPageState();
}

class SuggestionCheckPageState extends State<SuggestionCheckPage> {
  //User user = Get.arguments;
  Future<List<Suggestion>> suggestionList =
      SuggestionRepository.getSuggestion(4);

  @override
  void initState() {
    super.initState();
    intl.initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('건의사항',
            style: GoogleFonts.doHyeon(fontSize: 24, color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            const Text('식당을 이용한 장병들의 건의사항입니다',
                style: TextStyle(color: Colors.grey, fontSize: 10)),
            const SizedBox(height: 20),
            Flexible(
              child: FutureBuilder<List<Suggestion>>(
                future: suggestionList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
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
                                    Text(snapshot.data![i].name!,
                                        style:
                                            GoogleFonts.doHyeon(fontSize: 15)),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        // border:
                                        //     Border.all(color: Colors.grey, width: 1),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            //spreadRadius: 3,
                                            //blurRadius: 5,
                                            offset: const Offset(3, 3),
                                          )
                                        ]),
                                    //alignment: Alignment.center,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data![i].comment!,
                                          style:
                                              GoogleFonts.doHyeon(fontSize: 15),
                                          softWrap: true,
                                        ),
                                        const Spacer(),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            snapshot.data![i].createdTime!,
                                            style: GoogleFonts.doHyeon(
                                                fontSize: 15),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                            indent: 10,
                            endIndent: 10,
                            color: Colors.grey.shade400,
                            thickness: 1.0);
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
