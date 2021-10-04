import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:myapp/src/model/colors.dart';
import 'package:myapp/src/view/allergy_page.dart';
import 'package:myapp/src/view/first_page.dart';
import 'package:myapp/src/view/login_page.dart';
import 'package:myapp/src/view/meal_control_page.dart';
import 'package:myapp/src/view/my_review.dart';
import 'package:myapp/src/view/notice_check_page.dart';
import 'package:myapp/src/view/notice_pass_page.dart';
import 'package:myapp/src/view/review_analysis_page.dart';
import 'package:myapp/src/view/sign_up_page.dart';
import 'package:myapp/src/view/troop_select_page.dart';
import 'package:myapp/src/view/suggestion_check_page.dart';
import 'package:myapp/src/view/suggestion_complain_page.dart';
import 'src/app.dart';
import 'src/binding/init_binding.dart';

void main() {
  runApp(const MyAPP());
}

class MyAPP extends StatelessWidget {
  const MyAPP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: CustomColor.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: CustomColor.orangeColor,
        ),
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      initialRoute: '/',
      initialBinding: InitBinding(),
      getPages: [
        GetPage(name: '/', page: () => const App()),
        GetPage(name: '/first', page: () => const FirstPage()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/allergy', page: () => const AllergyPage()),
        GetPage(name: '/suggestComplain', page: () => const SuggestionComplainPage()),
        GetPage(name: '/noticeCheck', page: () => const NoticeCheckPage()),
        GetPage(name: '/myReview', page: () => const MyReviewPage()),
        GetPage(name: '/suggestCheck', page: () => const SuggestionCheckPage()),
        GetPage(name: '/noticePass', page: () => const NoticePassPage()),
        GetPage(name: '/reviewAnalysis', page: () => const ReviewAnalysisPage()),
        GetPage(name: '/mealControl', page: () => const MealControlPage()),
        GetPage(name: '/troopSelect', page: () => const TroopSelectPage()),
        GetPage(name: '/signUp', page: () => const SignUpPage()),
      ],
    );
  }
}
