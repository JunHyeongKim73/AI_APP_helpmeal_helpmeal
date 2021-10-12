/*import 'package:flutter/material.dart';

class SuggestionCheckPage extends StatelessWidget {
  const SuggestionCheckPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('sugges check'),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final List<String> suggestionName = <String> ["yangbaechu","JunHyeongKim73","star8041","Army2021","abmin"];
final List<String> suggestionCheck = <String> ["버그가 너무 많아요 ㅠㅠ",
                                              "빵식 좀 적게 나왔으면 좋겠어요",
                                              "UI가 너무 구려요",
                                              "저희 사단 식단표대로 나오지 않는 것 같습니다",
                                              "너무 맛없고, 너무 정확도가 떨어지고, 너무 못 만들었어요. 미완성인 것처럼 보이기도 하고요. 좀 많이 개선점이 필요해보여요."];

void main() => runApp(SuggestionCheckPage());

class SuggestionCheckPage extends StatefulWidget {
  SuggestionCheckPageState createState() => SuggestionCheckPageState();
}

class SuggestionCheckPageState extends State<SuggestionCheckPage> {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('건의사항'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Container(
              width: 350,
              height: 1000, //height 크기 가변적 조정 필요
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 350,
                    height: 950,
                    child: ListView.separated(
                      itemBuilder: (BuildContext context, int i) {
                        return Container(
                          width: 350,
                          height: 110,
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: 350,
                                height: 30,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: 150,
                                    height: 30,
                                    child: Text(suggestionName[i], style: GoogleFonts.doHyeon(fontSize: 15))
                                  )
                                )
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5,),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        //spreadRadius: 3,
                                        //blurRadius: 5,
                                        offset: Offset(3, 3),
                                      )
                                    ]
                                  ),
                                  //alignment: Alignment.center,
                                  height: 70,
                                  width: 350,
                                  child: Text(
                                    suggestionCheck[i],
                                    style: GoogleFonts.doHyeon(fontSize: 15),
                                    softWrap: true,
                                  ),
                                )
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ]
                          )
                        );
                      },
                      itemCount: suggestionCheck.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(color: Colors.grey.shade400, thickness: 1.0);
                      }
                    )
                  )
                ]
              )
            )
          )
        )
      )
    );
  }
}