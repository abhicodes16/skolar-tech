import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../bloc/homework/homework_bloc.dart';
import '../../model/common_model.dart';
import '../../model/homework/home_work_summary_model.dart';
import '../../model/homework/homework_model.dart';
import '../../repo/homework/homework_repo.dart';
import '../../style/assets_constants.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/response.dart';
import '../../widget/error_dialouge.dart';
import '../../widget/error_message.dart';
import '../../widget/loading.dart';
import '../../widget/loading_dialogue.dart';
import '../../widget/no_data_foud.dart';
import 'package:popup_banner/popup_banner.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:badges/badges.dart' as badges;

class HomeWorkPage extends StatefulWidget {
  final String? schoolCode;
  HomeWorkPage({Key? key, this.schoolCode}) : super(key: key);

  @override
  State<HomeWorkPage> createState() => _HomeWorkPageState();
}

class _HomeWorkPageState extends State<HomeWorkPage> {
  bool isLoading = true;
  HomeWorkBloc? homeWorkBloc;

  String urlPDFPath = "";
  bool exists = true;
  bool loaded = false;

  String? totalHW = '';
  String? completedHW = '';
  String? incompleteHW = '';

  final TextEditingController _txtRemarkCnt = TextEditingController();

  Future<File> getFileFromUrl(String url, {name, extention}) async {
    var fileName = 'homework';
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

  void requestPersmission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
  }

  @override
  void initState() {
    homeWorkBloc = HomeWorkBloc(schoolCode: widget.schoolCode);
    requestPersmission();
    super.initState();
    setDataFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOMEWORK', style: Palette.appbarTitle),
        flexibleSpace: Container(decoration: Palette.appbarGradient),
        elevation: 0,
        actions: [
          Align(
            child: badges.Badge(
              position: badges.BadgePosition.topEnd(top: -10, end: -12),
              badgeContent: Text(totalHW ?? ''),
              child: const Icon(Icons.calculate_outlined),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Align(
            child: badges.Badge(
              position: badges.BadgePosition.topEnd(top: -10, end: -12),
              badgeContent: Text(incompleteHW ?? ''),
              child: const Icon(Icons.pending_actions_outlined),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Align(
            child: badges.Badge(
              position: badges.BadgePosition.topEnd(top: -10, end: -12),
              badgeContent: Text(completedHW ?? ''),
              child: const Icon(Icons.mark_chat_read_outlined),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: StreamBuilder(
        stream: homeWorkBloc!.dataStream,
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
                  onRetryPressed: () =>
                      homeWorkBloc!.fetchdata(schoolCode: widget.schoolCode),
                );
            }
          }
          return Container();
        },
      ),
    );
  }

  Widget _listWidget(HomeworkModel homeworkModel) {
    if (homeworkModel.data!.isEmpty) {
      return const NoDataFound();
    } else {
      return ListView.builder(
        itemCount: homeworkModel.data!.length,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        itemBuilder: (context, index) {
          bool isCompleted = false;
          if (homeworkModel.data![index].isCompleted == 'Yes') {
            isCompleted = true;
          }

          String fileUrl = homeworkModel.data![index].attachment.toString();
          var ext = fileUrl.split('.');

          return InkWell(
            onTap: () {
              if (!isCompleted) {
                _displayTextInputDialog(
                  context,
                  homeworkModel.data![index].AsignCode.toString(),
                );
              } else {
                getFileFromUrl(
                  fileUrl,
                  name: homeworkModel.data![index].workSubject,
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
              }
            },
            child: Card(
              margin: kStandardMargin * 2,
              shape: Palette.cardShape,
              elevation: 8,
              child: Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              const Text('Subject :  '),
                              Text(
                                homeworkModel.data![index].workSubject ?? '',
                                style: Palette.themeTitleSB,
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Text('Work Date :  '),
                              Text(
                                homeworkModel.data![index].workDate ?? '',
                                style: Palette.titleSB,
                              ),
                            ],
                          ),
                          Visibility(
                            visible: isCompleted,
                            child: Container(
                              margin: const EdgeInsets.only(top: 4),
                              child: Text(
                                'Completed',
                                style: Palette.subTitleGrey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        getFileFromUrl(
                          fileUrl,
                          name: homeworkModel.data![index].workSubject,
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
                      child: Image.asset(
                        ext.last == 'pdf' ? Assets.pdf : Assets.doc,
                        width: 30,
                      ),
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

  Future<void> _displayTextInputDialog(
      BuildContext context, String assignCode) async {
    return showDialog(
        context: context,
        builder: (context) {
          bool isCheckComplted = false;

          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Complete Remark'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (value) {
                      // setState(() {
                      //   valueText = value;
                      // });
                    },
                    controller: _txtRemarkCnt,
                    decoration:
                        const InputDecoration(hintText: "Enter Remarks"),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: isCheckComplted,
                        onChanged: (value) => setState(() {
                          isCheckComplted = value ?? false;
                        }),
                      ),
                      Expanded(
                        child: Text(
                          'Homework is completed',
                          style: Palette.titleSL,
                        ),
                      )
                    ],
                  )
                ],
              ),
              actions: <Widget>[
                MaterialButton(
                  color: kThemeColor.withOpacity(0.1),
                  elevation: 0,
                  textColor: Colors.black,
                  shape: Palette.btnShape,
                  child: const Text('Cancel'),
                  onPressed: () {
                    setState(() {
                      _txtRemarkCnt.text = '';
                      Navigator.pop(context);
                    });
                  },
                ),
                Visibility(
                  visible: isCheckComplted,
                  child: MaterialButton(
                    color: kThemeColor,
                    textColor: Colors.white,
                    elevation: 0,
                    shape: Palette.btnShape,
                    child: const Text('Submit'),
                    onPressed: () {
                      setState(() {
                        _setDataToAPI(
                            assignCode: assignCode, remark: _txtRemarkCnt.text);
                        _txtRemarkCnt.text = '';
                        Navigator.pop(context);
                      });
                    },
                  ),
                ),
              ],
            );
          });
        });
  
  }

  void setDataFromAPI() async {
    HomeWorkRepo homeworkRepo = HomeWorkRepo();
    HomeWorkSummaryModel noticeSummaryModel =
        await homeworkRepo.fetchSummaryData();
    setState(() {
      isLoading = false;

      if (noticeSummaryModel.data != null) {
        if (noticeSummaryModel.data!.isNotEmpty) {
          totalHW = noticeSummaryModel.data![0].totalHW!;
          completedHW = noticeSummaryModel.data![0].completedHW!;
          incompleteHW = noticeSummaryModel.data![0].incompleteHW!;
        }
      }
    });
  }

  void _setDataToAPI(
      {required String assignCode, required String remark}) async {
    LoadingDialog.showLoadingDialog(context);
    HomeWorkRepo homeworkRepo = HomeWorkRepo();

    try {
      CommonModel? data = await homeworkRepo.sendRemarkData(
        assignCode: assignCode,
        remark: remark,
      );
      Navigator.pop(context);
      if (data.success != null) {
        if (data.success!) {
          homeWorkBloc!
              .fetchdata(schoolCode: widget.schoolCode, isLoading: false);

          setDataFromAPI();
        } else {
          ErrorDialouge.showErrorDialogue(context, data.message ?? '');
        }
      }
    } catch (e) {
      // print('>>>>>>>>>>$noticeCode<<<<<<<<<');
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(context, e.toString());
    }
  }
}
