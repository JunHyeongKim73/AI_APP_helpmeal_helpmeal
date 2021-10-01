import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.local_restaurant,
              size: 200,
            ),
            Text.rich(TextSpan(text: '', children: <TextSpan>[
              TextSpan(
                  text: 'H',
                  style: TextStyle(
                    fontSize: 80.0,
                    color: Colors.red.shade400,
                    fontWeight: FontWeight.bold,
                  )),
              TextSpan(
                  text: 'elp',
                  style: TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                  ))
            ])),
            Text.rich(TextSpan(text: '', children: <TextSpan>[
              TextSpan(
                  text: 'M',
                  style: TextStyle(
                    fontSize: 80.0,
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  )),
              TextSpan(
                  text: 'eal',
                  style: TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                  ))
            ])),
            SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ButtonTheme(
                  minWidth: 200,
                  height: 50,
                  child: RaisedButton(
                    child: Text('로그인', style: TextStyle(fontSize: 20)),
                    onPressed: () {},
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                ),
                ButtonTheme(
                  minWidth: 200,
                  height: 50,
                  child: RaisedButton(
                    child: Text('로그인 없이 시작', style: TextStyle(fontSize: 20)),
                    onPressed: () {},
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
