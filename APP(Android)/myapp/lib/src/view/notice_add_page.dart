import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/src/model/colors.dart';

class NoticeAddPage extends StatelessWidget {
  const NoticeAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('공지사항 추가',
            style: GoogleFonts.doHyeon(fontSize: 24, color: Colors.white)),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 20, bottom: 10),
              child: TextField(
                decoration: InputDecoration(
                  labelText: '제목',
                  hintText: '제목을 입력하세요',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide:
                        BorderSide(width: 1, color: CustomColor.themeColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 10, bottom: 10),
              child: TextField(
                maxLines: 10,
                decoration: InputDecoration(
                  labelText: '내용',
                  hintText: '내용을 입력하세요',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide:
                        BorderSide(width: 1, color: CustomColor.themeColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
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
                  child: const Text(
                    '보내기',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(width: 20),
              ],
            )
          ],
        ),
      ),
    );
  }
}
