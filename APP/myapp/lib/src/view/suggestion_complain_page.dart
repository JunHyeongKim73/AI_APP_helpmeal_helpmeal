import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/src/model/colors.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text('건의하기',
              style: GoogleFonts.doHyeon(fontSize: 24, color: Colors.white)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      width: 350,
                      height: 200,
                      child: TextField(
                        maxLines: 10,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                                width: 1, color: Colors.amber.shade400),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                                width: 1, color: Colors.amber.shade200),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          hintText: '건의사항을 입력해주세요!',
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      width: 350,
                      height: 30,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: 70,
                          height: 30,
                          child: ElevatedButton(
                            child: const Text(
                              '보내기',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                            ),
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                primary: CustomColor.themeColor),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 350,
                    height: 30,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "My 건의사항",
                        style: GoogleFonts.doHyeon(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                      width: 350,
                      height: (suggestion.length + 1) * 100,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: CustomColor.themeColor, width: 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: CustomColor.themeColor,
                      ),
                      child: ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                width: 350,
                                height: 100,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 2),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  color: Colors.white,
                                ),
                                child: Text(
                                  suggestion[index],
                                  style: GoogleFonts.doHyeon(fontSize: 15),
                                  softWrap: true,
                                ));
                          },
                          itemCount: suggestion.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                                color: Colors.grey, thickness: 2.0);
                          })),
                  const SizedBox(height: 30)
                ]))));
  }
}
