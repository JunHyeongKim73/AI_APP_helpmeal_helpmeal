import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void main() => runApp(RankingPage());

class RankingPage extends StatefulWidget {
  RankingPageState createState() => RankingPageState();
}

class RankingPageState extends State<RankingPage> {
  final isSelected = <bool>[false, false, false];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HelpMeal'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('1'),
            Text('2'),
          ]),
    );
  }
}
