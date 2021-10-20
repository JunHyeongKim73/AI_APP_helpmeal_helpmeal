import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myapp/src/model/notice/notice.dart';
import 'package:myapp/src/model/notice/notice_repository.dart';
import 'package:myapp/src/model/user/user.dart';

class NoticeCheckPage extends StatefulWidget {
  const NoticeCheckPage({Key? key}) : super(key: key);

  @override
  NoticeCheckPageState createState() => NoticeCheckPageState();
}

class NoticeCheckPageState extends State<NoticeCheckPage>
    with TickerProviderStateMixin {
  User user = Get.arguments;
  Future<List<Notice>>? noticeList;

  List<bool>? lists;

  List<Animation<double>> _animation = [];
  List<AnimationController> _controller = [];

  bool buildPage = false;

  @override
  void initState() {
    noticeList = NoticeRepository.getNotice(user.groups!.troopId!);
    noticeList!.then((_noticeList) {

      lists = List.filled(_noticeList.length, false);

      for (var i = 0; i < _noticeList.length; i++) {
        AnimationController controller = AnimationController(
            vsync: this, duration: const Duration(milliseconds: 300));
        _controller.add(controller);

        Animation<double> animation =
            CurvedAnimation(parent: controller, curve: Curves.easeIn);
        animation.addListener(() {
          setState(() {});
        });
        _animation.add(animation);
      }
      setState(() {
        buildPage = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildPage ? mainScreen() : Scaffold();
  }

  Scaffold mainScreen() {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text('공지사항',
              style: GoogleFonts.doHyeon(fontSize: 24, color: Colors.white)),
          centerTitle: true,
          actions: <Widget>[
            user.isAdmin == 1
                ? TextButton(
                    onPressed: () => Get.offNamed('/noticeAdd',
                        arguments: user),
                    child: Text('추가',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  )
                : Container()
          ]),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30),
            Flexible(
              child: FutureBuilder<List<Notice>>(
                  future: noticeList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: Container(
                                    padding:
                                        const EdgeInsets.only(left: 8, top: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  snapshot.data![index].title!,
                                                  style: GoogleFonts.doHyeon(
                                                      fontSize: 18),
                                                ),
                                                index == 0
                                                    ? Text(
                                                        '  NEW  ',
                                                        style:
                                                            GoogleFonts.anton(
                                                                fontSize: 12,
                                                                color:
                                                                    Colors.red),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                            Text(
                                              snapshot.data![index].createdTime!,
                                              style: GoogleFonts.doHyeon(
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                lists![index] = !lists![index];

                                                if (lists![index]) {
                                                  _controller[index].forward();
                                                } else {
                                                  _controller[index].reverse();
                                                }
                                              });
                                            },
                                            icon: lists![index]
                                                ? const Icon(MdiIcons.chevronUp)
                                                : const Icon(
                                                    MdiIcons.chevronDown))
                                      ],
                                    ),
                                  ),
                                ),
                                _container(index, snapshot.data![index].content!)
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                              color: Colors.grey.shade400, thickness: 1.0);
                        },
                      );
                    }
                    return Container();
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _container(int index, String content) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      height: 150 * _animation[index].value,
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(content, style: GoogleFonts.gothicA1()),
      ),
    );
  }
}
