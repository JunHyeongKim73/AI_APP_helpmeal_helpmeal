import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/src/model/review/review.dart';
import 'package:myapp/src/model/review/review_repository.dart';
import 'package:myapp/src/model/user/user.dart';

class MyReviewPage extends StatefulWidget {
  const MyReviewPage({Key? key}) : super(key: key);

  @override
  MyReviewPageState createState() => MyReviewPageState();
}

class MyReviewPageState extends State<MyReviewPage> {
  User user = Get.arguments;
  Future<List<Review>>? reviewList;

  @override
  void initState() {
    reviewList = ReviewRepository.getMyReview(user.userId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('My 리뷰',
            style: GoogleFonts.doHyeon(fontSize: 24, color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          const SizedBox(height: 30),
          Flexible(
            child: FutureBuilder<List<Review>>(
                future: reviewList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
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
                                    Text(
                                      snapshot.data![index].createdTime!,
                                      style: GoogleFonts.doHyeon(fontSize: 13),
                                    )
                                  ],
                                ),
                                Expanded(
                                    child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.amber.shade50,
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          offset: const Offset(3, 3),
                                        )
                                      ]),
                                  child: Text(
                                    snapshot.data![index].comment!,
                                    style: GoogleFonts.doHyeon(fontSize: 15),
                                    softWrap: true,
                                  ),
                                )),
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
                            color: Colors.grey.shade300, thickness: 1.0);
                      },
                    );
                  }
                  return Container();
                }),
          )
        ]),
      ),
    );
  }
}
