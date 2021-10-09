import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/src/model/meal/meal.dart';
import 'package:myapp/src/model/user/user.dart';

// 아침, 점심, 저녁 위젯
class MealItem extends StatefulWidget {
  final Meal mealData;
  User user;

  MealItem({
    Key? key,
    required this.mealData,
    required this.user,
  }) : super(key: key);

  @override
  State<MealItem> createState() => _MealItemState();
}

class _MealItemState extends State<MealItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Text(widget.mealData.titleText,
                style: GoogleFonts.doHyeon(color: Colors.white, fontSize: 20)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: widget.mealData.foodList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(
                    widget.mealData.foodList[index].name,
                    style: GoogleFonts.cuteFont(
                      color: widget.mealData.foodList[index]
                              .hasAllergy(widget.user.allergyList)
                          ? Colors.red
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
    );
  }
}
