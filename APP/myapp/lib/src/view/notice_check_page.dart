import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myapp/src/model/colors.dart';
import 'package:myapp/src/model/suggestion/suggestion.dart';
import 'package:myapp/src/model/suggestion/suggestion_repository.dart';
import 'package:myapp/src/model/user/user.dart';

class NoticeCheckPage extends StatefulWidget {
  const NoticeCheckPage({Key? key}) : super(key: key);

  @override
  NoticeCheckPageState createState() => NoticeCheckPageState();
}

const noticeTitleList = [
  '모두 정숙해주시길 바랍니다.',
  '식당에 휴대폰 가져오지 마세요.',
  '마스크 쓰고 밥 받으시길 바랍니다'
];

const noticeDetailList = [
  '요즘 식당이 시끄러운 현상을 많이 목격하고 있습니다. 모두 아시다시피 식당은 다같이 밥을 먹는 공간입니다. 식당에서 밥을 먹을 때는 정숙해주시길 바랍니다.',
  '요즘 식당이 시끄러운 현상이 많이 목격되고 있습니다. 모두 아시다시피 식당은 다같이 밥을 먹는 공간입니다. 식당에서 밥을 먹을 때는 정숙해주시길 바랍니다.',
  '요즘 식당이 시끄러운 현상이 많이 목격되고 있습니다. 모두 아시다시피 식당은 다같이 밥을 먹는 공간입니다. 식당에서 밥을 먹을 때는 정숙해주시길 바랍니다.',
];

class NoticeCheckPageState extends State<NoticeCheckPage>
    with TickerProviderStateMixin {
  List<bool> lists = List.filled(noticeTitleList.length, false);

  List<Animation<double>> _animation = [];
  List<AnimationController> _controller = [];

  @override
  void initState() {
    // TODO: implement initState
    for (var i = 0; i < noticeTitleList.length; i++) {
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
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text('공지사항',
              style: GoogleFonts.doHyeon(fontSize: 24, color: Colors.white)),
          centerTitle: true,
          actions: <Widget>[
            TextButton(
              onPressed: () => Get.toNamed('/noticeAdd'),
              child: Text(
                '추가',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            )
          ]),
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
                itemCount: noticeTitleList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: Container(
                            padding: const EdgeInsets.only(left: 8, top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          noticeTitleList[index],
                                          style:
                                              GoogleFonts.doHyeon(fontSize: 18),
                                        ),
                                        index == 0
                                            ? Text(
                                                '  NEW  ',
                                                style: GoogleFonts.anton(
                                                    fontSize: 12,
                                                    color: Colors.red),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                    Text(
                                      '2021.10.14 18:00',
                                      style: GoogleFonts.doHyeon(
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        lists[index] = !lists[index];

                                        if (lists[index]) {
                                          _controller[index].forward();
                                        } else {
                                          _controller[index].reverse();
                                        }
                                      });
                                    },
                                    icon: lists[index]
                                        ? const Icon(MdiIcons.chevronUp)
                                        : const Icon(MdiIcons.chevronDown))
                              ],
                            ),
                          ),
                        ),
                        _container(index)
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(color: Colors.grey.shade400, thickness: 1.0);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _container(int index) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      height: 150 * _animation[index].value,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(noticeDetailList[index], style: GoogleFonts.gothicA1()),
      ),
    );
  }
}
