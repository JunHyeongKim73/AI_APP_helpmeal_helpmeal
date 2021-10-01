import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
void main() => runApp(rankPage());

class rankPage extends StatefulWidget {
    rankPageState createState() => rankPageState();
}

class rankPageState extends State<rankPage> {
    final isSelected = <bool>[false, false, false];
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('HelpMeal'),
            ),
            body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [
                    ToggleButtons
                    Text('1'),
                    Text('2'),
                ]
            ),
            /*bottomNavigationBar: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                    ),
                    boxShadow: [
                        BoxShadow(
                            color: Colors.black38,
                            spreadRadius: 0,
                            blurRadius: 10,
                        )
                    ]
                ),
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                    ),
                    child: BottomNavigationBar(
                        //elevation: 0,
                        backgroundColor: Colors.white,
                        type: BottomNavigationBarType.fixed,
                        onTap: controller.changeTabIndex,
                        currentIndex: controller.tabIndex,
                        showSelectedLabels: false,
                        showUnselectedLabels: false,
                        items: const [
                            BottomNavigationBarItem(
                                icon: Icon(
                                    MdiIcons.viewDashboard,
                                    size: 24,
                                ),
                                label: '식단표',
                            ),
                            BottomNavigationBarItem(
                                icon: Icon(
                                    MdiIcons.crown,
                                    size: 24,
                                ),
                                label: '랭킹',
                            ),
                            BottomNavigationBarItem(
                                icon: Icon(
                                    MdiIcons.account,
                                    size: 24,
                                ),
                                label: 'My',
                            ),
                        ],
                    ),
                ),
            ),*/
        );
    }
}