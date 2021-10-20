import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/src/model/colors.dart';
import 'package:myapp/src/model/suggestion/suggestion.dart';
import 'package:myapp/src/model/suggestion/suggestion_repository.dart';
import 'package:myapp/src/model/user/user.dart';
import 'package:intl/date_symbol_data_local.dart' as intl;

final List<String> suggestion = <String>[
  "버그가 너무 많아요 ㅠㅠ",
  "빵식 좀 적게 나왔으면 좋겠어요",
  "UI가 너무 구려요",
  "저희 사단 식단표대로 나오지 않는 것 같습니다",
  "항상 고생이 많으십니다!"
];

class SuggestionComplainPage extends StatefulWidget {
  const SuggestionComplainPage({Key? key}) : super(key: key);

  @override
  SuggestionComplainPageState createState() => SuggestionComplainPageState();
}

class SuggestionComplainPageState extends State<SuggestionComplainPage> {
  User user = Get.arguments;
  TextEditingController controller = TextEditingController();
  Future<List<Suggestion>>? suggestionList;
  bool canBuildSuggestion = true;

  @override
  void initState() {
    super.initState();
    intl.initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    if (canBuildSuggestion) {
      suggestionList = SuggestionRepository.getSuggestionByUser(user.userId!);
      canBuildSuggestion = false;
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('건의하기',
            style: GoogleFonts.doHyeon(fontSize: 24, color: Colors.white)),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                const Text('식당 관리자에게 건의사항이 있으신가요?',
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),
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
                      hintText: '건의사항을 입력해주세요!',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.only(right: 15),
                  width: double.infinity,
                  height: 30,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 80,
                      height: 30,
                      child: ElevatedButton(
                        child: const Text(
                          '보내기',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w800),
                        ),
                        onPressed: () async {
                          await SuggestionRepository.postSuggestion(
                              user.userId!, controller.text);
                          setState(() {
                            canBuildSuggestion = true;
                          });
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: const Text('등록되었습니다'),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () => Get.back(),
                                      child: const Text('확인'))
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            primary: CustomColor.themeColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.only(left: 24),
                  width: double.infinity,
                  height: 30,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "My 건의사항",
                      style: GoogleFonts.doHyeon(fontSize: 20),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: CustomColor.themeColor,
                      ),
                      child: FutureBuilder<List<Suggestion>>(
                          future: suggestionList,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Container(
                                      height: 100,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                        horizontal: 10,
                                      ),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data![index].comment!,
                                            style: GoogleFonts.doHyeon(
                                                fontSize: 18),
                                            softWrap: true,
                                          ),
                                          const Spacer(),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Text(
                                              snapshot
                                                  .data![index].createdTime!,
                                              style: GoogleFonts.doHyeon(
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            return Container();
                          }),
                    ),
                  ),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
