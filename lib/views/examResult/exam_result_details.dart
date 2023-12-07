import 'package:flutter/material.dart';
import '../../bloc/examResultBloc/exam_result_bloc.dart';
import '../../model/exam/exam_result_column_model.dart';
import '../../model/exam/exam_result_column_val_model.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/response.dart';
import '../../widget/error_message.dart';
import '../../widget/loading.dart';
import '../../widget/no_data_foud.dart';

class ExamResultDetails extends StatefulWidget {
  final String testId, testName, conductDt, totalMarkSecured, totalMarks;
  const ExamResultDetails({
    super.key,
    required this.testId,
    required this.testName,
    required this.conductDt,
    required this.totalMarkSecured,
    required this.totalMarks,
  });

  @override
  State<ExamResultDetails> createState() => _ExamResultDetailsState();
}

class _ExamResultDetailsState extends State<ExamResultDetails> {
  //ExamDetailsBloc? examDetailsBloc;

  String totalMarks = '';
  String totalSecured = '';

  ExamResultBloc? examResultBloc;

  ResultColumnData? columnData;
  bool isNoData = false;

  @override
  void initState() {
    // examDetailsBloc = ExamDetailsBloc(
    //   widget.testId,
    //   onData: (value) {
    //     if (value.data != null) {
    //       if (value.data!.isNotEmpty) {
    //         totalMarks = value.data!.first.totalMarks ?? '';
    //         totalSecured = value.data!.first.totalSecured ?? '';
    //       }
    //     }
    //   },
    // );
    examResultBloc = ExamResultBloc(
      examCode: widget.testId,
      onResultColumnData: (value) {
        columnData = value;
      },
      noData: (value) => isNoData = value,
    );
    totalSecured = widget.totalMarkSecured;
    totalMarks = widget.totalMarks;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.testName} ${widget.conductDt}',
            style: Palette.appbarTitle),
        flexibleSpace: Container(decoration: Palette.appbarGradient),
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: examResultBloc!.dataStream,
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
                );
            }
          }
          return Container();
        },
      ),
    );
  }

  Widget _listWidget(ExamResultColumnValModel examDetailsModel) {
    if (examDetailsModel.data!.isEmpty) {
      return const NoDataFound();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tableHeader(),
          ListView.builder(
            itemCount: examDetailsModel.data!.length,
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.fromLTRB(15, 3, 15, 3),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Text(
                        examDetailsModel.data![index].col1 ?? '',
                        style: Palette.title,
                      ),
                    ),
                    if (columnData!.col2IsVisible == 'Y')
                      Expanded(
                        flex: 1,
                        child: Text(
                          examDetailsModel.data![index].col2 ?? '',
                          style: Palette.title,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    if (columnData!.col3IsVisible == 'Y')
                      Expanded(
                        flex: 1,
                        child: Text(
                          examDetailsModel.data![index].col3 ?? '',
                          style: Palette.title,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    if (columnData!.col4IsVisible == 'Y')
                      Expanded(
                        flex: 1,
                        child: Text(
                          examDetailsModel.data![index].col4 ?? '',
                          style: Palette.title,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    if (columnData!.col5IsVisible == 'Y')
                      Expanded(
                        flex: 1,
                        child: Text(
                          examDetailsModel.data![index].col5 ?? '',
                          style: Palette.title,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        examDetailsModel.data![index].col6 ?? '',
                        style: Palette.title,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          const Divider(height: 3),
          totalRow(),
        ],
      );
    }
  }

  Widget tableHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      color: kThemeColor.withOpacity(0.1),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              '${columnData!.col1}',
              style: Palette.title,
            ),
          ),
          if (columnData!.col2IsVisible == 'Y')
            Expanded(
              flex: 1,
              child: Text(
                '${columnData!.col2}',
                style: Palette.subTitle,
                textAlign: TextAlign.center,
              ),
            ),
          if (columnData!.col3IsVisible == 'Y')
            Expanded(
              flex: 1,
              child: Text(
                '${columnData!.col3}',
                style: Palette.subTitle,
                textAlign: TextAlign.center,
              ),
            ),
          if (columnData!.col4IsVisible == 'Y')
            Expanded(
              flex: 1,
              child: Text(
                '${columnData!.col4}',
                style: Palette.subTitle,
                textAlign: TextAlign.center,
              ),
            ),
          if (columnData!.col5IsVisible == 'Y')
            Expanded(
              flex: 1,
              child: Text(
                '${columnData!.col5}',
                style: Palette.subTitle,
                textAlign: TextAlign.center,
              ),
            ),
          Expanded(
            flex: 1,
            child: Text(
              '${columnData!.col6}',
              style: Palette.subTitle,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget totalRow() {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      //color: kThemeColor.withOpacity(0.1),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Text(
              'Total : ',
              style: Palette.title,
              textAlign: TextAlign.end,
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: Text(
          //     totalMarks,
          //     style: Palette.title,
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          Expanded(
            flex: 1,
            child: Text(
              totalSecured,
              style: Palette.title,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
