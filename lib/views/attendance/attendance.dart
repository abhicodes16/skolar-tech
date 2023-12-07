import 'package:flutter/material.dart';

import '../../bloc/attendance/monthly_attendance_bloc.dart';
import '../../model/attendance/monthly_attendance_model.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/response.dart';
import '../../widget/error_message.dart';
import '../../widget/loading.dart';
import '../../widget/no_data_foud.dart';
import 'attendance_summary.dart';

class Attendance extends StatefulWidget {
  Attendance({
    Key? key,
  }) : super(key: key);

  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  MonthlyAttendanceBloc? monthlyAttendanceBloc;

  List months = [
    'jan',
    'feb',
    'mar',
    'apr',
    'may',
    'jun',
    'jul',
    'aug',
    'sep',
    'oct',
    'nov',
    'dec'
  ];
  var now = new DateTime.now();
  late var current_mon = now.month;

  @override
  void initState() {
    monthlyAttendanceBloc = MonthlyAttendanceBloc(
      monthName: months[current_mon - 1],
      year: now.year.toString(),
    );
    print('current month::::::$current_mon');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('ATTENDANCE', style: Palette.appbarTitle),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttendanceSummary(),
                  ),
                );
              },
              icon: Icon(Icons.calendar_month_outlined))
        ],
        flexibleSpace: Container(decoration: Palette.appbarGradient),
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: monthlyAttendanceBloc!.dataStream,
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
                  // onRetryPressed: () => monthlyAttendanceBloc!
                  //     .fetchdata(monthName: months[current_mon - 1]),
                );
            }
          }
          return Container();
        },
      ),
    );
  }

  Widget _listWidget(MonthlyAttendanceModel monthlyAttendanceModel) {
    if (monthlyAttendanceModel.data!.isEmpty) {
      return const NoDataFound();
    } else {
      return ListView.builder(
        itemCount: monthlyAttendanceModel.data!.length,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        itemBuilder: (context, index) {
          String? dayStatus = monthlyAttendanceModel.data![index].dayStatus;
          String? inTime = monthlyAttendanceModel.data![index].inTime;
          return Card(
            color: inTime == "Sunday"
                ? Colors.red.shade100
                : Colors.green.shade100,
            child: ListTile(
              leading: Text(monthlyAttendanceModel.data![index].dayName ?? '-',
                  style: const TextStyle(color: kBlue)),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '$inTime',
                    style: TextStyle(
                      color: inTime == "Sunday" ? kRed : kGreen,
                    ),
                  ),
                  Text(
                    monthlyAttendanceModel.data![index].outTime ?? '',
                    style: Palette.titleDanger,
                  )
                ],
              ),
              trailing: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  '$dayStatus',
                  style: TextStyle(
                    color:
                        dayStatus == "A" || dayStatus == "H" || dayStatus == "W"
                            ? Colors.red
                            : Colors.green,
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
