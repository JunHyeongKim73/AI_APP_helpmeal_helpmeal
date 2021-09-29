import 'package:flutter/material.dart';

class MyPage extends StatelessWidget{
  const MyPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("MY"),
      )
    );
  }
}