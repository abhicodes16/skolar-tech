import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pns_skolar/style/theme_constants.dart';
import 'package:pns_skolar/model/academic_calendar_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../model/course/semester_select_model.dart';
import '../repo/Course/select_class_repo.dart';
import '../style/palette.dart';
import '../utils/api_constant.dart';
import '../widget/error_dialouge.dart';

class AcademicCalender extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AcademicCalender_State();
  }
}

class AcademicCalender_State extends State<AcademicCalender> {
  var width = Get.width;
  var height = Get.height;

  var schoolCode;
  var token;

  var loading = true;

  var CalendarData = <Data>[];

  List<SemesterSelectDataModel> _selectSemesterModelList = [];
  int? selectedSemValue;

  Future<void> selectSemesterApi() async {
    //LoadingDialog.showLoadingDialog(context);
    SelectClassRepo selectClassRepo = SelectClassRepo();
    try {
      SemesterSelectModel data = await selectClassRepo.fetchSemData();

      if (data.success!) {
        setState(() {
          _selectSemesterModelList = data.data!;
          if (_selectSemesterModelList.isNotEmpty) {
            selectedSemValue = _selectSemesterModelList[0].sEMECODE;
            fetchCalendarData();
          }
        });
      }
    } catch (e) {
      print('Exeption $e');
      print('$selectedSemValue');
    }
  }

  Future<void> fetchCalendarData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
      schoolCode = pref.getString('schoolCode');
      token = pref.getString('token');
      print("--->$token");
    });

    final params = {
      'schoolCode': '$schoolCode',
    };

    final uri = Uri.parse(ApiConstant.ACADEMIC_CALENDAR).replace(
      queryParameters: params,
    );

    final body = {
      'semesterId': selectedSemValue,
    };

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'apikey': ApiConstant.API_KEY,
        'token': token,
      },
      body: jsonEncode(body), // Encode the body as JSON
    );

    if (response.statusCode == 200) {
      try {
        final academicCalendarModel AcademicCalendar =
            academicCalendarModel.fromJson(
          json.decode(response.body),
        );

        setState(() {
          CalendarData = AcademicCalendar.data ?? [];
        });
      } catch (e) {
        ErrorDialouge.showErrorDialogue(
            context, "Something is wrong, please try again later");
        print('Error decoding JSON: $e');
      } finally {
        setState(() {
          loading = false;
        });
      }
    } else {
      ErrorDialouge.showErrorDialogue(
          context, "Something is wrong, please try again later");
      print(
          'Error: ${response.reasonPhrase}, Status Code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    selectSemesterApi();
  }

  Map<String, int> extractDayAndMonth(String dateString) {
    List<String> dateParts = dateString.split("//");

    int day = int.tryParse(dateParts[0]) ?? 0;

    List<String> monthParts = dateParts[1].split("/");
    int month = int.tryParse(monthParts[0]) ?? 0;

    return {'day': day, 'month': month};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Academic Calendar', style: Palette.appbarTitle),
          flexibleSpace: Container(decoration: Palette.appbarGradient),
          elevation: 0,
        ),
        body: loading
            ? Center(
                child: SizedBox(
                    height: 40, width: 40, child: CircularProgressIndicator()),
              )
            : Column(
                children: [
                  _selectSemesterWidget(),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: CalendarData.length,
                      itemBuilder: (context, index) {
                        final dataIndex = CalendarData[index];

                        Map<String, int> dateInfo =
                            extractDayAndMonth(dataIndex.calDate ?? "");

                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 15, right: 15),
                          child: Card(
                            elevation: 4,
                            shadowColor: kThemeColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            clipBehavior: Clip.hardEdge,
                            child: Container(
                              width: width,
                              height: 100,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      height: height,
                                      decoration: BoxDecoration(
                                          color: Colors.yellow.shade900,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              getMonthName(dateInfo['month']!),
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              dateInfo['day'].toString(),
                                              style: TextStyle(
                                                fontSize: 25,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            dataIndex.entity ?? "",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: kThemeColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            width: width * 0.6,
                                            child: Text(
                                              dataIndex.remarks ?? "",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ));
  }

  Widget _selectSemesterWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 5),
          child: Text('Semester :', style: Palette.title),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          width: MediaQuery.of(context).size.width,
          child: Wrap(
            children: List.generate(_selectSemesterModelList.length, (i) {
              String semName =
                  _selectSemesterModelList[i].semesterName ?? '???';

              return InkWell(
                onTap: () {
                  setState(() {
                    selectedSemValue = _selectSemesterModelList[i].sEMECODE;
                  });
                  fetchCalendarData();
                },
                child: Card(
                  elevation: 0,
                  shape: Palette.cardShape,
                  color:
                      selectedSemValue == _selectSemesterModelList[i].sEMECODE
                          ? Colors.amber[700]
                          : Colors.amber.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                    child: SizedBox(
                      height: 18,
                      child: Wrap(
                        children: [
                          Text(
                            '${semName[0]}',
                            style: selectedSemValue ==
                                    _selectSemesterModelList[i].sEMECODE
                                ? Palette.titlez
                                : Palette.title,
                          ),
                          const SizedBox(width: 1),
                          Text(
                            '${semName[1]}${semName[2]}',
                            style: selectedSemValue ==
                                    _selectSemesterModelList[i].sEMECODE
                                ? const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10.0,
                                    color: Colors.white,
                                  )
                                : const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10.0,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  String getMonthName(int monthNumber) {
    switch (monthNumber) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }
}
