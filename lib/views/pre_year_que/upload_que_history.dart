import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pns_skolar/model/delete_que_model.dart';
import 'package:pns_skolar/model/questions_history_model.dart';
import 'package:pns_skolar/widget/success_dialouge.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../style/palette.dart';
import '../../utils/api_constant.dart';
import '../../widget/error_dialouge.dart';

class QuestionHistory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QuestionHistory_State();
  }
}

class QuestionHistory_State extends State<QuestionHistory> {
  var height = Get.height;
  var width = Get.width;

  List<Data> data = [];

  List<APIDATA> deleteData = [];

  var schoolCode;
  var token;

  bool loading = false;

  Future<void> getQuestionHistory() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      schoolCode = pref.getString('schoolCode');
      token = pref.getString('token');
      loading = true;
      print("--->$token");
    });

    final params = {
      'schoolCode': '$schoolCode',
    };

    final uri = Uri.parse(ApiConstant.QUESTION_HISTORY)
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
        final QuestionHistoryModel questionHistory =
            QuestionHistoryModel.fromJson(json.decode(response.body));

        setState(() {
          data = questionHistory.data ?? [];
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
      print(
          'Error: ${response.reasonPhrase}, Status Code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuestionHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Questions History',
          style: Palette.appbarTitle,
        ),
        flexibleSpace: Container(
          decoration: Palette.appbarGradient,
        ),
      ),
      body: loading
          ? Center(
              child: SizedBox(
                  height: 40, width: 40, child: CircularProgressIndicator()),
            )
          : Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, right: 15, left: 15),
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      print("-->tapped");

                      // await OpenFile.open(data[index].questionsDoc);
                      // final url = data[index].questionsDoc.toString();
                      // if (await canLaunch(url)) {
                      //   await launch(url);
                      // } else {
                      //   ErrorDialouge.showErrorDialogue(context, "Something is Wrong");
                      // }
                      _openFileFromUrl("${data[index].questionsDoc}");
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        width: width,
                        // height: 60,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 15, top: 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data[index].subjectName.toString() ?? "-"}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${data[index].semesterName.toString()?? "-"} (${data[index].branchName.toString()?? "-"})",
                                      style: TextStyle(
                                          color: Colors.deepOrange,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 20,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "View Questions",
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Colors.blue.shade600,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  removeItemDialoge(context,data[index].id);
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.grey,
                                    size: 25,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )),
    );
  }

  Future<void> _openFileFromUrl(pdfUrl) async {
   try{
     final url = pdfUrl;
     final filename = url.substring(url.lastIndexOf("/") + 1);
     final request = await http.get(Uri.parse(url));
     final bytes = request.bodyBytes;
     final tempDir = await getTemporaryDirectory();
     final file = File('${tempDir.path}/$filename');
     await file.writeAsBytes(bytes);
     OpenFile.open(file.path);
   }catch(e){
     ErrorDialouge.showErrorDialogue(context, "${e}");
   }
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      ErrorDialouge.showErrorDialogue(context, 'Could not launch $url');
    }
  }

  Future<void> removeItemDialoge(BuildContext context,id) async {

    var width = Get.width;
    var height = Get.height;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text('Delete Questions ?',
              style: TextStyle(
                  color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16
              ),
            ),
          ),
          content: Container(
            width: width*0.7,
            height: height*0.17,
            child: Column(
              children: [
                Text('Are you sure you want to delete ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500
                  ),
                ),

                Spacer(),

                InkWell(
                  onTap: () {
                    Get.back();
                    DeleteQuestion(id);
                  },
                  child: Container(
                    height: 35,
                    width: width,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.red.shade600,width: 1.5)
                    ),
                    child: Center(
                      child: Text("Yes, Delete it",
                        style: TextStyle(
                            color: Colors.red.shade600,fontWeight: FontWeight.w600,
                            fontSize: 13,fontFamily: "OpenSans"
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),


                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 35,
                    width: width,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.green.shade600,width: 1.5)
                    ),
                    child: Center(
                      child: Text("No, Let it be",
                        style: TextStyle(
                            color: Colors.green.shade600,fontWeight: FontWeight.w600,
                            fontSize: 13,fontFamily: "OpenSans"
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> DeleteQuestion(id) async {


    final params = {
      'schoolCode': '$schoolCode',
    };

    final body = {
      'id': id,
    };

    final uri = Uri.parse(ApiConstant.DELETE_QUESTIONS)
        .replace(queryParameters: params);

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'apikey': ApiConstant.API_KEY,
        'token': token
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      try {
        final DeleteQuestionModel deleteQuestionModel =
        DeleteQuestionModel.fromJson(json.decode(response.body));

        setState(() {
          deleteData = deleteQuestionModel.data ?? [];
        });
      } catch (e) {
        ErrorDialouge.showErrorDialogue(
            context, "Something is Wrong please try again later");
        print('Error decoding JSON: $e');
      } finally {
        SuccessDialouge.showErrorDialogue(context, deleteData[0].msg.toString());
        setState(() {
          getQuestionHistory();
        });
      }
    } else {
      print(
          'Error: ${response.reasonPhrase}, Status Code: ${response.statusCode}');
    }
  }


}
