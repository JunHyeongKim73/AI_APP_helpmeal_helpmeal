import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myapp/src/controller/date_controller.dart';
import 'package:myapp/src/model/colors.dart';
import 'package:myapp/src/model/meal/menu.dart';
import 'package:myapp/src/model/meal/menu_repository.dart';
import 'package:myapp/src/model/user/user.dart';

class MealControlPage extends StatelessWidget {
  final User user = Get.arguments;

  MealControlPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('식단표 관리',
            style: GoogleFonts.doHyeon(fontSize: 24, color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: GetBuilder<DateController>(builder: (controller) {
          final TextEditingController breakController = TextEditingController();
          final TextEditingController lunchController = TextEditingController();
          final TextEditingController dinerController = TextEditingController();
          // final List<Menu> menuList =
          //     MenuRepository.loadMenusWithDate(controller.dateText);
          Future<List<Menu>> menuList =
              MenuRepository.getMenus(controller.dateText, user.groups!.troopId!);

          return FutureBuilder<List<Menu>>(
              future: menuList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    breakController.text = '';
                  } else {
                    breakController.text =
                        snapshot.data![0].foodNames.join('\n');
                    lunchController.text =
                        snapshot.data![1].foodNames.join('\n');
                    dinerController.text =
                        snapshot.data![2].foodNames.join('\n');
                  }
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(2018, 10, 20),
                                maxTime: DateTime(2022, 10, 20),
                                onChanged: (date) {}, onConfirm: (date) {
                              controller.updateDate(date: date);
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.ko);
                          },
                          iconSize: 16,
                          icon: const Icon(MdiIcons.calendarBlankOutline,
                              size: 20),
                        ),
                        Text(DateFormat.yMd('ko').format(controller.dateText),
                            style: GoogleFonts.roboto(fontSize: 18)),
                      ],
                    ),
                    _mealTextField(breakController, '아침'),
                    _mealTextField(lunchController, '점심'),
                    _mealTextField(dinerController, '저녁'),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text('음식들을 enter로 구분해주세요!',
                              style: TextStyle(color: Colors.grey)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: ElevatedButton(
                            onPressed: () {
                              _postMenu([
                                breakController,
                                lunchController,
                                dinerController,
                              ], controller.dateText);
                              _showToast(context);
                              controller.updateDateChanged();
                            },
                            child: const Text('수정',
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              });
        }),
      ),
    );
  }

  Widget _mealTextField(TextEditingController textController, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20),
          child:
              Text(text, style: const TextStyle(fontWeight: FontWeight.w800)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          child: TextField(
            autofocus: false,
            controller: textController,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              focusedBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: CustomColor.themeColor, width: 2.0),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
              ),
              hintText: textController.text == '' ? '식단을 입력해주세요!' : '',
            ),
            minLines: 1,
            maxLines: 5,
          ),
        ),
      ],
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('수정되었습니다'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: scaffold.hideCurrentSnackBar,
        ),
      ),
    );
  }

  List<Map> createFoodList(List<String> foods) {
    int orders = 1;
    List<Map> lists = [];
    for (var foodString in foods) {
      Map<String, dynamic> body = {
        'name': foodString,
        'allergy': [],
        'order': orders
      };
      lists.add(body);
      orders++;
    }
    return lists;
  }

  void _postMenu(List<TextEditingController> controllers, DateTime dateTime) {
    List<String> breakFoods = controllers[0].text.split('\n');
    List<String> lunchFoods = controllers[1].text.split('\n');
    List<String> dinerFoods = controllers[2].text.split('\n');

    List<Map> breakFoodList = createFoodList(breakFoods);
    List<Map> lunchFoodList = createFoodList(lunchFoods);
    List<Map> dinerFoodList = createFoodList(dinerFoods);

    MenuRepository.postMenu(
        dateTime, [breakFoodList, lunchFoodList, dinerFoodList], user.groups!.troopId!);
  }
}
