import 'package:flutter/material.dart';
import '../../bloc/holiday/holiday_bloc.dart';
import '../../model/holiday/holiday_model.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/response.dart';
import '../../widget/date_formatter.dart';
import '../../widget/error_message.dart';
import '../../widget/loading.dart';
import '../../widget/no_data_foud.dart';

class HolidayList extends StatefulWidget {
  const HolidayList({
    Key? key,
  }) : super(key: key);

  @override
  State<HolidayList> createState() => _HolidayListState();
}

class _HolidayListState extends State<HolidayList> {
  HolidayBloc? holidayBloc;
  late List serialList;
  var colors = [
    Colors.red.shade50,
    Colors.cyan.shade50,
    Colors.green.shade50,
    Colors.yellow.shade50,
    Colors.blue.shade50,
  ];

  @override
  void initState() {
    holidayBloc = HolidayBloc();
    super.initState();
    serialList = List.generate(100, (index) => "${index + 1}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOLIDAY', style: Palette.appbarTitle),
        flexibleSpace: Container(decoration: Palette.appbarGradient),
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: holidayBloc!.dataStream,
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
                  onRetryPressed: () => holidayBloc!.fetchdata(),
                );
            }
          }
          return Container();
        },
      ),
    );
  }

  Widget _listWidget(HolidayModel holidayModel) {
    if (holidayModel.data!.isEmpty) {
      return const NoDataFound();
    } else {
      return ListView.builder(
        itemCount: holidayModel.data!.length,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        itemBuilder: (context, index) {
          var dateTime = holidayModel.data![index].holidayDate;
          var fomattedDate = dateTime != null
              ? DateFormatterDMYD.convertDateFormat(dateTime)
              : '';

          return Card(
            color: colors[index % colors.length],
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: kThemeDarkColor.withOpacity(0.8),
                child: Text(
                  serialList[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: kWhiteColor,
                  ),
                ),
              ),
              title: Text(
                holidayModel.data![index].holidayName ?? '-',
              ),
              subtitle: Text(fomattedDate),
            ),
          );
        },
      );
    }
  }
}
