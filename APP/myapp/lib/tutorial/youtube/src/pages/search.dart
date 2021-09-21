import 'package:flutter/material.dart';

class Search extends StatelessWidget{
  const Search({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("SEARCH"),
      )
    );
  }
}