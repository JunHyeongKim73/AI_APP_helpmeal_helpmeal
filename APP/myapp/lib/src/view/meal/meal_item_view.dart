import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/src/model/meal/meal.dart';
// 아침, 점심, 저녁 위젯
class MealItem extends StatelessWidget {
  final Meal mealData;

  const MealItem({Key? key, required this.mealData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(mealData.startColor),
            Color(mealData.endColor),
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
            Text(mealData.titleText, style: GoogleFonts.doHyeon(color: Colors.white, fontSize: 20)),
            const SizedBox(height: 10),
            Text(mealData.meals.join('\n'), style: GoogleFonts.cuteFont(color: Colors.white, fontSize: 20, wordSpacing: 4)),
          ],
        ),
      ),
    );
  }
}