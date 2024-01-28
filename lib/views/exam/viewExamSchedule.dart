import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pns_skolar/model/exam/view_exam_schedule_model.dart';
import 'package:http/http.dart' as http;
import 'package:pns_skolar/style/theme_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../style/palette.dart';
import '../../utils/api_constant.dart';
import '../../widget/error_dialouge.dart';

class ViewExamSchedule extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ViewExamSchedule_State();
  }
}

class ViewExamSchedule_State extends State<ViewExamSchedule>{


  var declarationId;

  var schoolCode;
  var token;

  var loading = false;

  var ExamScheduleData = <Data>[];

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

    final uri = Uri.parse(ApiConstant.VIEw_EXAM_SCHEDULE).replace(
      queryParameters: params,
    );

    final body = {
      'declarationId': declarationId.toString(),
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
        final viewExamSchedule ExamSchedules = viewExamSchedule.fromJson(
          json.decode(response.body),
        );

        setState(() {
          ExamScheduleData = ExamSchedules.data ?? [];
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
      print('Error: ${response.reasonPhrase}, Status Code: ${response.statusCode}');
    }
  }




  var width = Get.width;
  var height = Get.height;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final arguments = Get.arguments;
    setState(() {
      declarationId = arguments['declarationId'];
    });

    fetchExamData();
  }

  String extractDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDate = "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Exam Schedule', style: Palette.appbarTitle),
        flexibleSpace: Container(decoration: Palette.appbarGradient),
        elevation: 0,
      ),
      body:
      loading ?
      Center(child: SizedBox(height: 40,width: 40,child: CircularProgressIndicator()),)
          :
          _scheduleExamList()
    );
  }

  Widget _scheduleExamList(){
    return  ListView.builder(
      itemCount: ExamScheduleData.length,
      itemBuilder:  (context, index) {
        final dataIndex = ExamScheduleData[index];

        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
            elevation: 4,
            shadowColor: kThemeColor,
            child: Container(
              width: width*0.9,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10,bottom: 10,right: 15,left: 15
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [
                        Expanded(
                          child: Text(dataIndex.subjectName ?? "",
                            style: TextStyle(
                                color: kThemeDarkColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),

                        CircleAvatar(
                            radius: 15,
                            child: Icon(CupertinoIcons.pen,color: Colors.white,size: 17,)
                        )
                      ],
                    ),

                    SizedBox(height: 10,),

                    Divider(thickness: 0.5,color: Colors.grey,),

                    SizedBox(height: 10,),

                    Row(

                      children: [

                        Icon(CupertinoIcons.clock_fill,size: 20,color: kThemeColor),

                        SizedBox(width: 5,),

                        _titleText("Time : "),

                        SizedBox(width: 10,),

                        Text(dataIndex.timeofExam ?? ""),

                      ],
                    ),

                    SizedBox(height: 10,),

                    Row(

                      children: [

                        Icon(Icons.date_range,size: 20,color: kThemeColor),

                        SizedBox(width: 5,),

                        _titleText("Date : "),

                        SizedBox(width: 10,),

                        Text(extractDate(dataIndex.dateOfExam ?? "")),

                      ],
                    ),


                    SizedBox(height: 10,),

                    Row(
                      children: [

                        Icon(Icons.account_circle,size: 20,color: kThemeColor),

                        SizedBox(width: 5,),

                        _titleText("Sitting Id :"),

                        SizedBox(width: 10,),

                        Text("${dataIndex.sittingId} (${dataIndex.sittingtypeName})")

                      ],
                    )



                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _titleText(title){
    return Text(title,
      style: TextStyle(
          color:kThemeColor,
          fontSize: 14,
          fontWeight: FontWeight.w600
      ),
    );
  }
  
  
}