import 'package:flutter/material.dart';
import '../../bloc/attendance/monthly_attendance_bloc.dart';
import '../../model/attendance/monthly_attendance_model.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/response.dart';
import '../../widget/error_message.dart';
import '../../widget/loading.dart';
import '../../widget/no_data_foud.dart';

class MonthlyAttendance extends StatefulWidget {
  final String? monthName;
  final String? year;
  MonthlyAttendance({Key? key, this.monthName, this.year}) : super(key: key);

  @override
  State<MonthlyAttendance> createState() => _MonthlyAttendanceState();
}

class _MonthlyAttendanceState extends State<MonthlyAttendance> {
  MonthlyAttendanceBloc? monthlyAttendanceBloc;

  @override
  void initState() {
    monthlyAttendanceBloc = MonthlyAttendanceBloc(
      monthName: widget.monthName,
      year: widget.year,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.monthName!, style: Palette.appbarTitle),
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
                  // onRetryPressed: () => monthlyAttendanceBloc!.fetchdata(
                  //   monthName: widget.monthName,
                  // ),
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
