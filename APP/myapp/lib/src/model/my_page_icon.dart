import 'package:flutter/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MyPageIcon {
  final IconData iconData;
  final String pageName;
  final String text;

  MyPageIcon({
    required this.iconData,
    required this.pageName,
    required this.text,
  });

  static List<MyPageIcon> userMyPageIconList = <MyPageIcon>[
    MyPageIcon(iconData: MdiIcons.forumOutline, pageName: '/suggestComplain', text: '건의하기'),
    MyPageIcon(iconData: MdiIcons.bellOutline, pageName: '/noticeCheck', text: '공지사항'),
    MyPageIcon(iconData: MdiIcons.textBoxOutline, pageName: '/myReview', text: 'My 리뷰'),
  ];

  static List<MyPageIcon> adminMyPageIconList = <MyPageIcon>[
    MyPageIcon(iconData: MdiIcons.forumOutline, pageName: '/suggestCheck', text: '건의사항'),
    MyPageIcon(iconData: MdiIcons.bellOutline, pageName: '/noticePass', text: '공지하기'),
    MyPageIcon(iconData: MdiIcons.textBoxOutline, pageName: '/reviewAnalysis', text: '리뷰정리'),
    MyPageIcon(iconData: MdiIcons.viewDashboardOutline, pageName: 'mealControl', text: '식단표 관리'),
  ];
}
