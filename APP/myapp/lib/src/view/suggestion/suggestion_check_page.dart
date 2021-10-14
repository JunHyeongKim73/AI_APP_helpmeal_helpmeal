import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/src/model/suggestion/suggestion.dart';
import 'package:myapp/src/model/suggestion/suggestion_repository.dart';
import 'package:intl/date_symbol_data_local.dart' as intl;
import 'package:myapp/src/model/user/user.dart';

class SuggestionCheckPage extends StatefulWidget {
  const SuggestionCheckPage({Key? key}) : super(key: key);

  @override
  SuggestionCheckPageState createState() => SuggestionCheckPageState();
}

class SuggestionCheckPageState extends State<SuggestionCheckPage> {
  User user = Get.arguments;
  Future<List<Suggestion>>? suggestionList;

  @override
  void initState() {
    suggestionList = SuggestionRepository.getSuggestion(user.groups!.troopId!);
    intl.initializeDateFormatting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('건의사항',
            style: GoogleFonts.doHyeon(fontSize: 24, color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            const Text('식당을 이용한 장병들의 건의사항입니다',
                style: TextStyle(color: Colors.grey, fontSize: 10)),
            const SizedBox(height: 20),
            Flexible(
              child: FutureBuilder<List<Suggestion>>(
                future: suggestionList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: SizedBox(
                            height: 100,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(width: 10),
                                    Text(snapshot.data![i].name!,
                                        style:
                                            GoogleFonts.doHyeon(fontSize: 15)),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        // border:
                                        //     Border.all(color: Colors.grey, width: 1),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            //spreadRadius: 3,
                                            //blurRadius: 5,
                                            offset: const Offset(3, 3),
                                          )
                                        ]),
                                    //alignment: Alignment.center,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data![i].comment!,
                                          style:
                                              GoogleFonts.doHyeon(fontSize: 15),
                                          softWrap: true,
                                        ),
                                        const Spacer(),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            snapshot.data![i].createdTime!,
                                            style: GoogleFonts.doHyeon(
                                                fontSize: 15),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                            indent: 10,
                            endIndent: 10,
                            color: Colors.grey.shade400,
                            thickness: 1.0);
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
