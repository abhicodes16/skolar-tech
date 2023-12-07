import 'package:flutter/material.dart';
import '../../bloc/examResultBloc/exam_result_name_bloc.dart';
import '../../model/exam/exam_result_name_model.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/response.dart';
import '../../widget/error_message.dart';
import '../../widget/loading.dart';
import '../../widget/no_data_foud.dart';
import 'exam_result_details.dart';

class ExamResult extends StatefulWidget {
  const ExamResult({super.key});

  @override
  State<ExamResult> createState() => _ExamResultState();
}

class _ExamResultState extends State<ExamResult> {
  ExamResultNameBloc examResultNameBloc = ExamResultNameBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Result', style: Palette.appbarTitle),
        flexibleSpace: Container(decoration: Palette.appbarGradient),
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: examResultNameBloc.dataStream,
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
                  onRetryPressed: () => examResultNameBloc.fetchdata(),
                );
            }
          }
          return Container();
        },
      ),
    );
  }

  Widget _listWidget(ExamResultNameModel examModel) {
    if (examModel.data!.isEmpty) {
      return const NoDataFound();
    } else {
      return ListView.builder(
        itemCount: examModel.data!.length,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        itemBuilder: (context, index) {
          String totalMarkSecured = examModel.data![index].marksSecured ?? '';
          String totalMarks = examModel.data![index].totalMark ?? '';
          String isResultPublished =
              examModel.data![index].isResultPublished ?? '';

          return Card(
            margin: kStandardMargin * 2,
            shape: Palette.cardShape,
            elevation: 8,
            child: InkWell(
              onTap: () {
                if (isResultPublished == 'Y') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExamResultDetails(
                        testId: examModel.data![index].examCode.toString(),
                        testName: examModel.data![index].examTitle ?? '',
                        conductDt: examModel.data![index].examDate ?? '',
                        totalMarkSecured: totalMarkSecured,
                        totalMarks: totalMarks,
                      ),
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => const AlertDialog(
                      scrollable: true,
                      title: Text(
                        'Result Not Published',
                      ),
                      // content: Text(
                      //   noticeModel.data![index].noticeDesc ?? '-',
                      //   style: Palette.subTitle,
                      // ),
                    ),
                  );
                }
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            examModel.data![index].examTitle.toString(),
                            style: Palette.themeTitleSB,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Total Marks: $totalMarks',
                            style: Palette.titleS,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Total Secured: $totalMarkSecured',
                            style: Palette.titleS,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          examModel.data![index].examDate ?? '',
                          style: Palette.subTitleL,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          examModel.data![index].percentageSecured ?? '',
                          style: Palette.themeTitle,
                        ),
                        const SizedBox(height: 3),
                        isResultPublished == 'Y'
                            ? Text(
                                'Result Published',
                                style: Palette.subTitleGrey,
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
