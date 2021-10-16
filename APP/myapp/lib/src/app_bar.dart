import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart' as intl;

import 'package:myapp/src/controller/date_controller.dart';
import 'model/fonts.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  void initState() {
    super.initState();
    intl.initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DateController>(builder: (controller) {
      return AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: CustomFont(fontSize: 28).logo,
          ),
          elevation: 10,
          titleSpacing: 25,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () => controller.updateDate(i: -1),
              iconSize: 12,
              icon: const Icon(MdiIcons.chevronLeft, size: 16),
              constraints: const BoxConstraints(maxHeight: 24),
            ),
            Row(
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
                  icon: const Icon(MdiIcons.calendarBlankOutline, size: 16),
                ),
                Text(DateFormat.yMd('ko').format(controller.dateText),
                    style: GoogleFonts.roboto(fontSize: 14)),
              ],
            ),
            IconButton(
              onPressed: () => controller.updateDate(i: 1),
              iconSize: 12,
              icon: const Icon(MdiIcons.chevronRight, size: 16),
              constraints: const BoxConstraints(maxHeight: 24),
            ),
          ]);
    });
  }
}
