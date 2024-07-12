import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pns_skolar/views/query/reply_dialoge.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../model/queries/get_teacher_queries_list.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/api_constant.dart';
import '../../widget/date_formatter.dart';
import '../../widget/error_dialouge.dart';

class ViewQueries extends StatefulWidget {
  const ViewQueries({super.key});

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

  String urlPDFPath = "";
  bool exists = true;
  bool loaded = false;

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
            ? const Center(
                child: SizedBox(
                    height: 40, width: 40, child: CircularProgressIndicator()),
              )
            : data.isEmpty
                ? const Center(
                    child: Text("No Data Available..!"),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: data.length,
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 20, right: 9, left: 9),
                    itemBuilder: (context, index) {
                      var dataIndex = data[index];
                      String fileUrl = dataIndex.queryAttachment.toString();
                      var ext = fileUrl.split('.');

                      return Card(
                        margin: const EdgeInsets.only(bottom: 15),
                        shape: Palette.cardShape,
                        elevation: 8,
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "${dataIndex.studentName ?? "-"}",
                                                style: Palette.themeTitle,
                                              ),
                                            ),
                                            Text(
                                              dataIndex.createdDatetime == null
                                                  ? "-"
                                                  : '${DateFormatter.convertDateFormat(dataIndex.createdDatetime.toString()) ?? "-"}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${dataIndex.queryTitle ?? "-"}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.0,
                                            color: Colors.orange.shade600,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${dataIndex.queryDetails ?? "-"}',
                                          style: Palette.titleSB,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // InkWell(
                            //   onTap: () {
                            //     if (context != null) {
                            //       showDialog(
                            //         context: context,
                            //         builder: (BuildContext
                            //             context) {
                            //           return ReplyDialog(
                            //               queryId:
                            //                   "${dataIndex.queryID ?? "-"}");
                            //         },
                            //       );
                            //     } else {
                            //       print(
                            //           "Error: Context is null!");
                            //     }
                            //   },
                            //   child: const CircleAvatar(
                            //     radius: 15,
                            //     child: Icon(
                            //       Icons.reply,
                            //       size: 20,
                            //       color: Colors.white,
                            //     ),
                            //   ),
                            // )

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        getFileFromUrl(
                                          fileUrl,
                                          name: dataIndex.queryTitle,
                                          extention: ext.last,
                                        ).then(
                                          (value) => {
                                            setState(() {
                                              if (value != null) {
                                                urlPDFPath = value.path;
                                                loaded = true;
                                                exists = true;
                                                OpenFile.open(urlPDFPath);
                                              } else {
                                                exists = false;
                                              }
                                            })
                                          },
                                        );
                                      },
                                      child: Container(
                                        height: 25,
                                        decoration: BoxDecoration(
                                            color: Colors.green.shade400,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.attach_file,
                                                color: Colors.white, size: 16),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Attachment",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        if (context != null) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return ReplyDialog(
                                                  queryId:
                                                      "${dataIndex.queryID ?? "-"}");
                                            },
                                          );
                                        } else {
                                          print("Error: Context is null!");
                                        }
                                      },
                                      child: Container(
                                        height: 25,
                                        decoration: BoxDecoration(
                                            color: Colors.blue.shade400,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.reply,
                                                color: Colors.white, size: 16),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Reply",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      );
                    },
                  ));
  }

  Future<File> getFileFromUrl(String url, {name, extention}) async {
    var fileName = 'notice';
    if (name != null) {
      fileName = name;
    }
    var fileExt = 'pdf';
    if (extention != null) {
      fileExt = extention;
    }

    try {
      var data = await http.get(Uri.parse(url));
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$fileName.$fileExt");
      print(dir.path);
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
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

    try {
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
        final GetTeacherQueries questionHistory =
            GetTeacherQueries.fromJson(json.decode(response.body));

        setState(() {
          data = questionHistory.data ?? [];
        });
      } else {
        ErrorDialouge.showErrorDialogue(
            context, "Something is Wrong please try again later");
        print(
            'Error: ${response.reasonPhrase}, Status Code: ${response.statusCode}');
      }
    } catch (e) {
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
