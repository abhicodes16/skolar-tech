import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pns_skolar/style/theme_constants.dart';
import 'package:pns_skolar/model/exam/exam_schedule_model.dart';
import 'package:http/http.dart' as http;
import 'package:pns_skolar/views/exam/viewExamSchedule.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../style/palette.dart';
import '../../utils/api_constant.dart';
import '../../widget/error_dialouge.dart';

class ExamSchedule extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ExamSchedule_State();
  }
}

class ExamSchedule_State extends State<ExamSchedule> {
  List<Color> availableColors = [
    Colors.red.withOpacity(0.7),
    Colors.green.withOpacity(0.7),
    Colors.blue.withOpacity(0.7),
    Colors.purple.withOpacity(0.7),
    Colors.teal.withOpacity(0.7),
    // Add more colors as needed
  ];

  Color getRandomColor() {
    final random = Random();
    if (availableColors.isEmpty) {
      // If all colors are used, reset the list
      availableColors = [
        Colors.deepPurple.withOpacity(0.7),
        Colors.green.shade900.withOpacity(0.7),
        Colors.blue.shade900.withOpacity(0.7),
        Colors.teal.withOpacity(0.7),
        // Add more colors as needed
      ];
    }

    int index = random.nextInt(availableColors.length);
    Color selectedColor = availableColors[index];
    availableColors.removeAt(index);

    return selectedColor;
  }

  var width = Get.width;
  var height = Get.height;

  var schoolCode;
  var token;

  var loading = false;

  var ExamData = <Data>[];

  Future<void> fetchExamData() async {
    loading = true;

    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      schoolCode = pref.getString('schoolCode');
      token = pref.getString('token');
      print("--->$token");
    });

    final params = {
      'schoolCode': '$schoolCode',
    };

    final uri = Uri.parse(ApiConstant.GET_EXAM_DECLARATION)
        .replace(queryParameters: params);

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'apikey': ApiConstant.API_KEY,
        'token': token
      },
    );

    if (response.statusCode == 200) {
      try {
        final getExamDeclaration examDeclaration =
            getExamDeclaration.fromJson(json.decode(response.body));

        setState(() {
          ExamData = examDeclaration.data ?? [];
        });
      } catch (e) {
        ErrorDialouge.showErrorDialogue(
            context, "Something is Wrong please try again later");
        print('Error decoding JSON: $e');
      } finally {
        setState(() {
          loading = false;
        });
      }
    } else {
      ErrorDialouge.showErrorDialogue(
          context, "Something is Wrong please try again later");
      print(
          'Error: ${response.reasonPhrase}, Status Code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchExamData();
  }

  String extractDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDate =
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Exam Schedule', style: Palette.appbarTitle),
          flexibleSpace: Container(decoration: Palette.appbarGradient),
          elevation: 0,
        ),
        body: loading
            ? Center(
                child: SizedBox(
                    height: 40, width: 40, child: CircularProgressIndicator()),
              )
            : ExamData.isEmpty
                ? Center(
                child: Text("No Data Found..!"),
                  )
                : _examList());
  }

  Widget _examList() {
    return ListView.builder(
      itemCount: ExamData.length,
      itemBuilder: (context, index) {
        final dataIndex = ExamData[index];

        Color containerColor = getRandomColor();

        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: GestureDetector(
            onTap: () {
              Get.to(ViewExamSchedule(),
                  arguments: {'declarationId': dataIndex.declarationId});
            },
            child: Card(
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              elevation: 4,
              shadowColor: kThemeColor,
              child: Container(
                width: width * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width,
                      height: 10,
                      color: containerColor,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  dataIndex.examName ?? "",
                                  style: TextStyle(
                                      color: containerColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Text(
                                extractDate(dataIndex.examDate ?? ""),
                                style: TextStyle(
                                    color: kThemeColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              dataIndex.examTitle ?? "",
                              style: TextStyle(
                                  color: kThemeColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Row(
                            children: [
                              _titleText("Scheduled :  "),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: dataIndex.isScheduled == "Y"
                                      ? Colors.green
                                      : Colors.red.withOpacity(0.5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 5, top: 5),
                                  child: Text(
                                    dataIndex.isScheduled == "Y" ? "Yes" : "No",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              Expanded(child: SizedBox()),
                              _titleText("Marks Published :  "),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: dataIndex.isMarkPublished == "Y"
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 5, top: 5),
                                  child: Text(
                                    dataIndex.isMarkPublished == "Y"
                                        ? "Yes"
                                        : "No",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Row(
                            children: [
                              _titleText("Backpapers Entered :  "),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: dataIndex.isBackpapersEntered == "Y"
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 5, top: 5),
                                  child: Text(
                                    dataIndex.isBackpapersEntered == "Y"
                                        ? "Yes"
                                        : "No",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _titleText(title) {
    return Text(
      title,
      style: TextStyle(
          color: kThemeColor, fontSize: 14, fontWeight: FontWeight.w600),
    );
  }
}
