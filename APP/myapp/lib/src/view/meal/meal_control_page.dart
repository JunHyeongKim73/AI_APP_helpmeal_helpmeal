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

class MealControlPage extends StatelessWidget {
  const MealControlPage({Key? key}) : super(key: key);

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
          final TextEditingController dinnerController =
              TextEditingController();
          final List<Menu> menuList =
              MenuRepository.loadMenusWithDate(controller.dateText);
          if (menuList.isEmpty) {
            breakController.text = '';
          } else {
            breakController.text = menuList[0].meals.join('\n');
            lunchController.text = menuList[1].meals.join('\n');
            dinnerController.text = menuList[2].meals.join('\n');
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
                      }, currentTime: DateTime.now(), locale: LocaleType.ko);
                    },
                    iconSize: 16,
                    icon: const Icon(MdiIcons.calendarBlankOutline, size: 20),
                  ),
                  Text(DateFormat.yMd('ko').format(controller.dateText),
                      style: GoogleFonts.roboto(fontSize: 18)),
                ],
              ),
              _mealTextField(breakController, '아침'),
              _mealTextField(lunchController, '점심'),
              _mealTextField(dinnerController, '저녁'),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text('음식들을 enter로 구분해주세요!',
                        style: TextStyle(color: Colors.grey)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ElevatedButton(
                      onPressed: () => _showToast(context),
                      child: Text('수정', style: TextStyle(color: Colors.white)),
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
        }),
      ),
    );
  }

  Widget _mealTextField(TextEditingController textController, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20, left: 20),
          child: Text(text, style: TextStyle(fontWeight: FontWeight.w800)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          child: TextField(
            autofocus: false,
            controller: textController,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: CustomColor.themeColor, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
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
        action: SnackBarAction(label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}