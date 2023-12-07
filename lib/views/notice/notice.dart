import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import '../../bloc/notice/notice_bloc.dart';
import '../../model/common_model.dart';
import '../../model/notice/notice_model.dart';
import '../../model/notice/notice_summary_model.dart';
import '../../repo/notice/notice_repo.dart';
import '../../style/assets_constants.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/response.dart';
import '../../widget/date_formatter.dart';
import '../../widget/error_message.dart';
import '../../widget/loading.dart';
import '../../widget/no_data_foud.dart';
import 'package:badges/badges.dart' as badges;
import 'package:http/http.dart' as http;

class NoticePage extends StatefulWidget {
  final String? schoolCode;
  NoticePage({Key? key, this.schoolCode}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  bool isLoading = true;

  String? totalNotice = '';
  String? readNotice = '';
  String? unread = '';
  NoticeBloc? noticeBloc;

  String urlPDFPath = "";
  bool exists = true;
  bool loaded = false;

  @override
  void initState() {
    noticeBloc = NoticeBloc();

    super.initState();
    setDataFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NOTICE', style: Palette.appbarTitle),
        actions: [
          Align(
            child: badges.Badge(
              position: badges.BadgePosition.topEnd(top: -10, end: -12),
              badgeContent: Text(totalNotice ?? ''),
              child: const Icon(Icons.article_outlined),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Align(
            child: badges.Badge(
              position: badges.BadgePosition.topEnd(top: -10, end: -12),
              badgeContent: Text(unread ?? ''),
              child: const Icon(Icons.mark_email_unread_outlined),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Align(
            child: badges.Badge(
              position: badges.BadgePosition.topEnd(top: -10, end: -12),
              badgeContent: Text(readNotice ?? ''),
              child: const Icon(Icons.mark_chat_read_outlined),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
        flexibleSpace: Container(decoration: Palette.appbarGradient),
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: noticeBloc!.dataStream,
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
                  onRetryPressed: () => noticeBloc!.fetchdata(),
                );
            }
          }
          return Container();
        },
      ),
    );
  }

  Widget _listWidget(NoticeModel noticeModel) {
    if (noticeModel.data!.isEmpty) {
      return const NoDataFound();
    } else {
      return ListView.builder(
        itemCount: noticeModel.data!.length,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        itemBuilder: (context, index) {
          var dateTime = noticeModel.data![index].noticeDate;
          var fomattedDate = dateTime != null
              ? DateFormatterWD.convertDateFormat(dateTime)
              : '';

          String title = noticeModel.data![index].title ?? '';

          String noticeAvatar = '-';

          if (title.isNotEmpty) {
            noticeAvatar = title[0];
          }

          bool isViewed = false;
          if (noticeModel.data![index].isViewed == 'Yes') {
            isViewed = true;
          }

          String fileUrl = noticeModel.data![index].UploadFile.toString();
          var ext = fileUrl.split('.');

          return InkWell(
            onTap: () {
              if (!isViewed) {
                _setDataToAPI(
                    noticeCode: noticeModel.data![index].noticeCode ?? '');
              }

              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  scrollable: true,
                  title: Text(
                    title,
                  ),
                  content: Text(
                    noticeModel.data![index].noticeDesc ?? '-',
                    style: Palette.subTitle,
                  ),
                ),
              );
            },
            child: Card(
              margin: kStandardMargin * 2,
              shape: Palette.cardShape,
              elevation: 5,
              clipBehavior: Clip.antiAlias,
              child: Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                //height: 40,
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: isViewed
                          ? kThemeColor.withOpacity(0.2)
                          : kThemeColor.withOpacity(0.8),
                      child: Text(
                        noticeAvatar,
                        style: TextStyle(
                            color: isViewed ? kThemeColor : Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 3),
                          Text(
                            title,
                            style:
                                isViewed ? Palette.subTitle : Palette.subTitleB,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            fomattedDate,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 205, 204, 204),
                                fontSize: 12.0),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        getFileFromUrl(
                          fileUrl,
                          name: noticeModel.data![index].title,
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

  void _setDataToAPI({required String noticeCode}) async {
    //LoadingDialog.showLoadingDialog(context);
    NoticeRepo noticeRepo = NoticeRepo();

    try {
      CommonModel? data = await noticeRepo.fetchNoticeData(noticeCode);
      if (data.success != null) {
        if (data.success!) {
          noticeBloc!.fetchdata(isLoading: false);

          setDataFromAPI();
        }
      }
    } catch (e) {
      // print('>>>>>>>>>>$noticeCode<<<<<<<<<');
    }
  }

  void setDataFromAPI() async {
    NoticeRepo noticeRepo = NoticeRepo();
    NoticeSummaryModel noticeSummaryModel = await noticeRepo.fetchSummaryData();
    setState(() {
      isLoading = false;

      if (noticeSummaryModel.data != null) {
        if (noticeSummaryModel.data!.isNotEmpty) {
          totalNotice = noticeSummaryModel.data![0].totalNotice!;
          readNotice = noticeSummaryModel.data![0].readNotice!;
          unread = noticeSummaryModel.data![0].unread!;
        }
      }
    });
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
}
