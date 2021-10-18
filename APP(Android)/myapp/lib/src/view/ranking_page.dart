import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:myapp/src/model/fonts.dart';
import 'package:myapp/src/model/ranking/ranking.dart';
import 'package:myapp/src/model/ranking/ranking_repository.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({Key? key}) : super(key: key);

  @override
  RankingPageState createState() => RankingPageState();
}

class RankingPageState extends State<RankingPage> {
  final isSelected = <bool>[true, false, false];

  Future<List<Ranking>>? rankingList;
  String unit = '일간';

  @override
  Widget build(BuildContext context) {
    rankingList = RankingRepository.getBestMenu(unit);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: CustomFont(fontSize: 28).logo,
        ),
        elevation: 10,
        titleSpacing: 25,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Center(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 30),
              ToggleButtons(
                  color: Colors.grey.shade800,
                  selectedColor: Colors.amber.shade700,
                  selectedBorderColor: Colors.amber.shade700,
                  fillColor: Colors.amber.shade200,
                  splashColor: Colors.amber.shade300,
                  borderRadius: BorderRadius.circular(4.0),
                  constraints: BoxConstraints(minHeight: 36.0),
                  isSelected: isSelected,
                  onPressed: (index) {
                    setState(() {
                      if (!isSelected[index]) {
                        isSelected[0] = false;
                        isSelected[1] = false;
                        isSelected[2] = false;
                        isSelected[index] = true;
                        if (index == 0) unit = '일간';
                        if (index == 1) unit = '주간';
                        if (index == 2) unit = '월간';
                      }
                    });
                  },
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child:
                          Text('일간', style: GoogleFonts.doHyeon(fontSize: 15)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child:
                          Text('주간', style: GoogleFonts.doHyeon(fontSize: 15)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child:
                          Text('월간', style: GoogleFonts.doHyeon(fontSize: 15)),
                    ),
                  ]),
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: 250,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: FutureBuilder<List<Ranking>>(
                    future: rankingList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                          scrollDirection: Axis.vertical,
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int i) {
                            return SizedBox(
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        width: 30,
                                        child: Text(
                                          "${i + 1}",
                                          style: GoogleFonts.doHyeon(
                                              fontSize: 16, color: Colors.white),
                                        ),
                                        color: Colors.amber.shade400,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        snapshot.data![i].name!,
                                        style: GoogleFonts.doHyeon(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${snapshot.data![i].averageStar!} / 5.0',
                                    style: GoogleFonts.doHyeon(fontSize: 20),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
