import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pns_skolar/views/query/reply_dialoge.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../model/queries/get_teacher_queries_list.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/api_constant.dart';
import '../../widget/error_dialouge.dart';

class ViewQueries extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ViewQueries_State();
  }
}

class ViewQueries_State extends State<ViewQueries> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQueries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Queries',
            style: Palette.appbarTitle,
          ),
          flexibleSpace: Container(decoration: Palette.appbarGradient),
        ),
        body: loading
            ? Center(
                child: SizedBox(
                    height: 40, width: 40, child: CircularProgressIndicator()),
              )
            : data.isEmpty
                ? Center(
                    child: Text("No Data Available..!"),
                  )
                : ListView.builder(
                    itemCount: data.length,
                    padding: const EdgeInsets.only(
                        top: 15,
                        bottom: 20,
                      right: 9,left: 9
                    ),
                    itemBuilder: (context, index) {
                      var dataIndex = data[index];

                      var ApidateTime = dataIndex.createdDate;


                      DateTime dateTime = DateTime.parse(ApidateTime!);

                      String date = DateFormat('dd MMMM yyyy').format(dateTime);
                      String time = DateFormat('h:mm a').format(dateTime);
                      return Card(
                        margin: EdgeInsets.only(bottom: 15),
                        shape: Palette.cardShape,
                        elevation: 8,
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${dataIndex.branchName ?? "-"}",
                                              style: Palette.themeTitle,
                                            ),
                                          ),

                                          Text(
                                            '${date ?? "-"}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${dataIndex.studentName ?? "-"}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.0,
                                          color: Colors.orange.shade600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '${dataIndex.details ?? "-"}',
                                              style: Palette.titleSB,
                                            ),
                                          ),

                                          InkWell(
                                            onTap: () {
                                              if (context != null) {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return ReplyDialog(queryId: "${dataIndex.id ?? "-"}");
                                                  },
                                                );
                                              } else {
                                                print("Error: Context is null!");
                                              }
                                            },
                                            child: CircleAvatar(
                                              radius: 15,
                                              child: Icon(Icons.reply,
                                              size: 20,color: Colors.white,
                                              ),
                                            ),
                                          )

                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ));
  }

  var schoolCode;
  var token;

  bool loading = false;

  var data = <Data>[];

  Future<void> getQueries() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      schoolCode = pref.getString('schoolCode');
      token = pref.getString('token');
      loading = true;
      print("--->$token");
    });

    try{
      final params = {
        'schoolCode': '$schoolCode',
      };

      final uri = Uri.parse(ApiConstant.GET_QUERIES_TEACHER)
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
        final getTeacherQueries questionHistory =
        getTeacherQueries.fromJson(json.decode(response.body));

        setState(() {
          data = questionHistory.data ?? [];
        });

      } else {
        ErrorDialouge.showErrorDialogue(context, "Something is Wrong please try again later");
        print('Error: ${response.reasonPhrase}, Status Code: ${response.statusCode}');
      }
    }catch (e) {
      ErrorDialouge.showErrorDialogue(
          context, "Something is Wrong please try again later");
      print('Error decoding JSON: $e');
    } finally {
      setState(() {
        loading = false;
      });
    }
  }
}
