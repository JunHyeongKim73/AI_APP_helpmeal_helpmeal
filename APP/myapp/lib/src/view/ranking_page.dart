import 'package:flutter/material.dart';

void main() => runApp(const RankingPage());

class RankingPage extends StatefulWidget {
  const RankingPage({Key? key}) : super(key: key);

  @override
  RankingPageState createState() => RankingPageState();
}

class RankingPageState extends State<RankingPage> {
  final isSelected = <bool>[false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HelpMeal'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            Text('1'),
            Text('2'),
          ]),
    );
  }
}
