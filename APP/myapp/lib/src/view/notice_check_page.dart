import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/src/model/suggestion/suggestion.dart';
import 'package:myapp/src/model/suggestion/suggestion_repository.dart';
import 'package:myapp/src/model/user/user.dart';

class NoticeCheckPage extends StatefulWidget {
  const NoticeCheckPage({Key? key}) : super(key: key);

  @override
  NoticeCheckPageState createState() => NoticeCheckPageState();
}

const noticeList = [
  '모두 정숙해주시길 바랍니다.',
  '식당에 휴대폰 가져오지 마세요.',
  '마스크 쓰고 밥 받으시길 바랍니다'
];

class NoticeCheckPageState extends State<NoticeCheckPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('공지사항',
            style: GoogleFonts.doHyeon(fontSize: 24, color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30),
            Flexible(
                child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: noticeList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 8, top: 8),
                            child: Text(
                              noticeList[index],
                              style: GoogleFonts.doHyeon(fontSize: 15),
                              softWrap: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(color: Colors.grey.shade400, thickness: 1.0);
              },
            )),
          ],
        ),
      ),
    );
  }
}
