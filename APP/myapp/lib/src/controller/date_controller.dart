import 'package:get/get.dart';

const int plus = 1;
const int minus = -1;

class DateController extends GetxController {
  //var dateText = DateFormat.yMd('ko').format(DateTime.now());
  var dateText = DateTime.now();

  void updateDate({DateTime? date, int i = 0}) {

    switch (i) {
      case plus:
        DateTime newDate = dateText.add(const Duration(days: 1));
        dateText = DateTime(newDate.year, newDate.month, newDate.day);
        break;

      case minus:
        var newDate = dateText.subtract(const Duration(days: 1));
        dateText = DateTime(newDate.year, newDate.month, newDate.day);
        break;

      default:
        dateText = DateTime(date!.year, date.month, date.day);
        break;
    }

    update();
  }
}