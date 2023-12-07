import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pns_skolar/model/previous_year_questions/previous_year_quation_model.dart';

import '../../bloc/pre_year_que_bloc.dart';
import '../../style/assets_constants.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/response.dart';
import '../../widget/error_message.dart';
import '../../widget/loading.dart';
import '../../widget/no_data_foud.dart';
import 'package:http/http.dart' as http;

class PreYearQue extends StatefulWidget {
  final String subCode;
  final String semCode;
  final String classCode;
  const PreYearQue({
    super.key,
    required this.subCode,
    required this.semCode,
    required this.classCode,
  });

  @override
  State<PreYearQue> createState() => _PreYearQueState();
}

class _PreYearQueState extends State<PreYearQue> {
  PreYearQueBloc? preYearQueBloc;

  String urlPDFPath = "";
  bool exists = true;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    preYearQueBloc = PreYearQueBloc(subCode: widget.subCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Previous Year Questions', style: Palette.appbarTitle),
        flexibleSpace: Container(decoration: Palette.appbarGradient),
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: preYearQueBloc!.dataStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Loading(loadingMessage: snapshot.data.message);
              case Status.COMPLETED:
                return _listWidget(snapshot.data.data);
              case Status.ERROR:
                return ErrorMessage(
                  errorMessage: snapshot.data.message,
                  // onRetryPressed: () => noticeBloc!.fetchdata(),
                );
            }
          }
          return Container();
        },
      ),
    );
  }

  Widget _listWidget(PreviousYearQuestionModel preYearQueModel) {
    if (preYearQueModel.data!.isEmpty) {
      return const NoDataFound();
    } else {
      return ListView.builder(
        itemCount: preYearQueModel.data!.length,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        itemBuilder: (context, index) {
          String title = preYearQueModel.data![index].title ?? '';

          String noticeAvatar = '-';

          if (title.isNotEmpty) {
            noticeAvatar = title[0];
          }

          // bool isViewed = false;
          // if (noticeModel.data![index].isViewed == 'Yes') {
          //   isViewed = true;
          // }

          String fileUrl = preYearQueModel.data![index].questionsDoc.toString();
          var ext = fileUrl.split('.');

          return InkWell(
            onTap: () {
              // if (!isViewed) {
              //   _setDataToAPI(
              //       noticeCode: noticeModel.data![index].noticeCode ?? '');
              // }

              // showDialog(
              //   context: context,
              //   builder: (context) => AlertDialog(
              //     scrollable: true,
              //     title: Text(
              //       title,
              //     ),
              //     content: Text(
              //       noticeModel.data![index].noticeDesc ?? '-',
              //       style: Palette.subTitle,
              //     ),
              //   ),
              // );

              getFileFromUrl(
                fileUrl,
                name: preYearQueModel.data![index].title,
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
            child: Card(
              margin: kStandardMargin * 2,
              shape: Palette.cardShape,
              elevation: 5,
              clipBehavior: Clip.antiAlias,
              child: Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                height: 40,
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: kThemeColor.withOpacity(0.2),
                      child: Text(
                        noticeAvatar,
                        style: const TextStyle(color: kThemeColor),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(child: Text(title, style: Palette.title)),
                    Image.asset(
                      ext.last == 'pdf' ? Assets.pdf : Assets.doc,
                      width: 30,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  Future<File> getFileFromUrl(String url, {name, extention}) async {
    var fileName = 'questions';
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
}
