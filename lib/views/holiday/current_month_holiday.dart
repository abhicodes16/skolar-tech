import 'package:flutter/material.dart';
import '../../bloc/holiday/current_holiday_bloc.dart';
import '../../model/holiday/current_holiday_model.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/response.dart';
import '../../widget/date_formatter.dart';
import '../../widget/error_message.dart';
import '../../widget/loading.dart';
import '../../widget/no_data_foud.dart';
import 'holidays.dart';

class CurMnthHolidayList extends StatefulWidget {
  CurMnthHolidayList({
    Key? key,
  }) : super(key: key);

  @override
  State<CurMnthHolidayList> createState() => _CurMnthHolidayListState();
}

class _CurMnthHolidayListState extends State<CurMnthHolidayList> {
  CurrentHolidayBloc? currentHolidayBloc;

  List months = [
    'january',
    'february',
    'march',
    'april',
    'may',
    'june',
    'july',
    'august',
    'september',
    'october',
    'november',
    'december',
  ];

  DateTime nowDate = DateTime.now();
  late int currYear = nowDate.year;
  late String currMonth = months[nowDate.month - 1];

  late List serialList;

  @override
  void initState() {
    currentHolidayBloc = CurrentHolidayBloc(
      monthName: currMonth,
      yearName: currYear.toString(),
    );
    serialList = List.generate(100, (index) => "${index + 1}");
    super.initState();
    print('current month::::::$currMonth');
    print('current year::::::$currYear');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOLIDAY LIST', style: Palette.appbarTitle),
        flexibleSpace: Container(decoration: Palette.appbarGradient),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HolidayList(),
                  ),
                );
              },
              icon: const Icon(Icons.calendar_month))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _imageWid(),
            StreamBuilder(
              stream: currentHolidayBloc!.dataStream,
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
                        onRetryPressed: () => currentHolidayBloc!.fetchdata(
                          monthName: currMonth.toString(),
                          yearName: currYear.toString(),
                        ),
                      );
                  }
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Column _imageWid() {
    return Column(
      children: [
        Image.network('https://ntier.in/myskolarholiday.jpg'),
      ],
    );
  }

  Widget _listWidget(CurrentHolidayModel currentHolidayModel) {
    if (currentHolidayModel.data!.isEmpty) {
      return const NoDataFound();
    } else {
      return ListView.builder(
        itemCount: currentHolidayModel.data!.length,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 20, bottom: 30),
        itemBuilder: (context, index) {
          var dateTime = currentHolidayModel.data![index].holidayDate;
          var fomattedDate = dateTime != null
              ? DateFormatterDay.convertDateFormat(dateTime)
              : '';
          var day = currentHolidayModel.data![index].holidayDate;
          var fomattedDay =
              day != null ? DateFormatterE.convertDateFormat(day) : '';
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: ListTile(
              leading: Transform.translate(
                offset: const Offset(0, -4),
                child: Column(
                  children: [
                    Text(
                      fomattedDay,
                      style: const TextStyle(color: kDarkGrey),
                    ),
                    CircleAvatar(
                      backgroundColor: kThemeDarkColor,
                      radius: 18,
                      child: Text(
                        fomattedDate,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, color: kWhiteColor),
                      ),
                    ),
                  ],
                ),
              ),
              title: SizedBox(
                height: 40,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: const Color.fromARGB(255, 76, 180, 126),
                  child: Center(
                    child: Text(
                      currentHolidayModel.data![index].holidayName ?? '-',
                      style: const TextStyle(color: white),
                    ),
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
