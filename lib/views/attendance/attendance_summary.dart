import 'package:flutter/material.dart';
import '../../bloc/attendance/att_summary_bloc.dart';
import '../../model/attendance/attndc_summary_model.dart';
import '../../style/assets_constants.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/response.dart';
import '../../widget/date_formatter.dart';
import '../../widget/error_message.dart';
import '../../widget/loading.dart';
import '../../widget/no_data_foud.dart';
import 'monthly_attendance.dart';

class AttendanceSummary extends StatefulWidget {
  const AttendanceSummary({
    Key? key,
  }) : super(key: key);

  @override
  _AttendanceSummaryState createState() => _AttendanceSummaryState();
}

class _AttendanceSummaryState extends State<AttendanceSummary> {
  Animation? animation, delayedAnimation;
  AnimationController? animationController;

  AttendanceSummaryBloc? attendanceSummaryBloc;

  @override
  void initState() {
    attendanceSummaryBloc =
        AttendanceSummaryBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ATTENDANCE SUMMARY', style: Palette.appbarTitle),
          flexibleSpace: Container(decoration: Palette.appbarGradient),
          elevation: 0,
        ),
        body: StreamBuilder(
          stream: attendanceSummaryBloc!.dataStream,
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
                    onRetryPressed: () => attendanceSummaryBloc!
                        .fetchdata(),
                  );
              }
            }
            return Container();
          },
        ));
  }

  Widget _listWidget(AttendanceSummaryModel attendanceSummaryModel) {
    if (attendanceSummaryModel.data!.isEmpty) {
      return const NoDataFound();
    } else {
      return ListView.builder(
        itemCount: attendanceSummaryModel.data!.length,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        itemBuilder: (context, index) {
          return Card(
            margin: kStandardMargin * 2,
            shape: Palette.cardShape,
            elevation: 2,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MonthlyAttendance(
                      monthName: attendanceSummaryModel.data![index].monthName,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.1), BlendMode.dstATop),
                    image: AssetImage(
                      Assets.calendar,
                    ),
                  ),
                ),
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     Image(
                          //       image: AssetImage(Assets.calendar),
                          //       height: 50,
                          //       color: Colors.white.withOpacity(0.9),
                          //       colorBlendMode: BlendMode.modulate,
                          //     )
                          //   ],
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${attendanceSummaryModel.data![index].monthName}',
                                style: Palette.titleSafeD,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${attendanceSummaryModel.data![index].yearName}',
                                style: Palette.titleSafeD,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'Days :',
                                style: Palette.title,
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                width: 56,
                              ),
                              Text(
                                '${attendanceSummaryModel.data![index].dayTotal}',
                                style: Palette.titleDanger,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Text(
                                'Holiday :',
                                style: Palette.themeTitleSB,
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Text(
                                '${attendanceSummaryModel.data![index].holiday}',
                                style: Palette.titleDanger,
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Weekly Off :',
                                style: Palette.themeTitleSB,
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                width: 26,
                              ),
                              Text(
                                '${attendanceSummaryModel.data![index].weeklyOff}',
                                style: Palette.titleDanger,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Present :',
                                style: Palette.themeTitleSB,
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                width: 46,
                              ),
                              Text(
                                '${attendanceSummaryModel.data![index].presentTotal}',
                                style: Palette.titleDanger,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Text(
                                'Absent :',
                                style: Palette.themeTitleSB,
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Text(
                                '${attendanceSummaryModel.data![index].absentTotal}',
                                style: Palette.titleDanger,
                                textAlign: TextAlign.right,
                              ),
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
      );
    }
  }
}
