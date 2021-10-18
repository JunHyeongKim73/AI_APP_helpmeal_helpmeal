import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/src/controller/date_controller.dart';
import 'package:myapp/src/model/meal/meal.dart';
import 'package:myapp/src/model/user/user.dart';

// 아침, 점심, 저녁 위젯
class MealItem extends StatefulWidget {
  final Meal mealData;
  final User user;
  final int index;

  const MealItem({
    Key? key,
    required this.mealData,
    required this.user,
    required this.index,
  }) : super(key: key);

  @override
  State<MealItem> createState() => _MealItemState();
}

class _MealItemState extends State<MealItem> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DateController>(builder: (controller) {
      return InkWell(
        onTap: () {
          if (widget.mealData.foodList.isNotEmpty) {
            Get.toNamed('/scoreReview', arguments: {
              'user': widget.user,
              'date': controller.dateText,
              'index': widget.index + 1,
              'food': widget.mealData.foodList
            });
          }
        },
        child: Container(
          width: 160,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(widget.mealData.startColor),
                Color(widget.mealData.endColor),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(54),
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(widget.mealData.titleText,
                    style:
                        GoogleFonts.doHyeon(color: Colors.white, fontSize: 20)),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.mealData.foodList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(
                        widget.mealData.foodList[index].name,
                        style: GoogleFonts.cuteFont(
                          color: widget.mealData.foodList[index]
                                  .hasAllergy(widget.user.allergyList!)
                              ? Colors.yellowAccent
                              : Colors.white,
                          fontSize: 20,
                          wordSpacing: 4,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
