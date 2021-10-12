/*import 'package:flutter/material.dart';

class SuggestionComplainPage extends StatelessWidget {
  const SuggestionComplainPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('suggest complaining'),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final List<String> suggestion = <String> ["버그가 너무 많아요 ㅠㅠ",
                                          "빵식 좀 적게 나왔으면 좋겠어요",
                                          "UI가 너무 구려요",
                                          "저희 사단 식단표대로 나오지 않는 것 같습니다",
                                          "항상 고생이 많으십니다!"];

void main() => runApp(SuggestionComplainPage());

class SuggestionComplainPage extends StatefulWidget {
  SuggestionComplainPageState createState() => SuggestionComplainPageState();
}

class SuggestionComplainPageState extends State<SuggestionComplainPage> {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("건의하기"),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 350,
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
                      hintText: '건의사항을 입력해주세요!',
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey,)
                    ),
                  )
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 350,
                  height: 30,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 70,
                      height: 30,
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 5,),
                        child: Text('보내기', style: TextStyle(fontSize: 15)),
                        onPressed: () {},
                        color: Colors.blue,
                        textColor: Colors.white,
                      ),
                    ),
                  )
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: 350,
                  height: 30,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "My 건의사항",
                      style: GoogleFonts.doHyeon(fontSize: 20),
                    )
                  )
                ),
                Container(
                  width: 350,
                  height: 1000,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10,),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.amber, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.amber.shade300,
                  ),
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: 350,
                        height: 100,
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10,),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                        ),
                        child: Text(
                          suggestion[index],
                          style: GoogleFonts.doHyeon(fontSize: 15),
                          softWrap: true,
                        )
                      );
                    },
                    itemCount: suggestion.length,
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
    );
  }
}