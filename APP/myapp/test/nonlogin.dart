import 'package:flutter/material.dart';

//void main() => runApp(nLogin());

class nLogin extends StatefulWidget {
    nLoginState createState() => nLoginState();
}

class nLoginState extends State<nLogin> {
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'HelpMeal',
            home: Scaffold(
                body: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget> [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget> [
                                    Text('군종 : '),
                                    ButtonTheme(
                                        minWidth: 150,
                                        height: 50,
                                        child: OutlineButton.icon(
                                            onPressed: () {},
                                            icon: Icon(Icons.add, size: 30),
                                            label: Text('선택'),
                                        ),
                                    ),
                                ]
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget> [
                                    Text('사단 : '),
                                    ButtonTheme(
                                        minWidth: 150,
                                        height: 50,
                                        child: OutlineButton.icon(
                                            onPressed: () {},
                                            icon: Icon(Icons.add, size: 30),
                                            label: Text('선택'),
                                        ),
                                    ),
                                ]
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget> [
                                    Text('여단 : '),
                                    ButtonTheme(
                                        minWidth: 150,
                                        height: 50,
                                        child: OutlineButton.icon(
                                            onPressed: () {},
                                            icon: Icon(Icons.add, size: 30),
                                            label: Text('선택'),
                                        ),
                                    ),
                                ]
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget> [
                                    Text('이하 대대 : '),
                                    ButtonTheme(
                                        minWidth: 150,
                                        height: 50,
                                        child: OutlineButton.icon(
                                            onPressed: () {},
                                            icon: Icon(Icons.add, size: 30),
                                            label: Text('선택'),
                                        ),
                                    ),
                                ]
                            ),
                            SizedBox(
                                height: 100,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget> [
                                    ButtonTheme(
                                        minWidth: 150,
                                        height: 70,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0)),
                                        child: RaisedButton.icon(
                                            onPressed: () {
                                                Navigator.pop(context);
                                            },
                                            icon: Icon(Icons.arrow_back, size: 50),
                                            label: Text('Back',style: TextStyle(fontSize: 20)),
                                            color: Colors.indigo,
                                        )
                                    ),
                                    ButtonTheme(
                                        minWidth: 150,
                                        height: 70,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0)),
                                        child: RaisedButton.icon(
                                            onPressed: () {},
                                            icon: Icon(Icons.arrow_forward, size: 50),
                                            label: Text('Next',style: TextStyle(fontSize: 20)),
                                            color: Colors.indigo,
                                        )
                                    )
                                ]
                            )
                        ]
                    )
                )
            )
        );
    }
}