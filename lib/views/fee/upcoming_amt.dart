import 'package:flutter/material.dart';
import '../../bloc/fee/upcoming_amt_bloc.dart';
import '../../model/fee/dua_amt_model.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/response.dart';
import '../../widget/date_formatter.dart';
import '../../widget/error_message.dart';
import '../../widget/loading.dart';
import '../../widget/no_data_foud.dart';

class UpcomingAmt extends StatefulWidget {
  const UpcomingAmt({super.key});

  @override
  State<UpcomingAmt> createState() => _UpcomingAmtState();
}

class _UpcomingAmtState extends State<UpcomingAmt> {
  UpcomingAmtBloc upcomingAmtBloc = UpcomingAmtBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: upcomingAmtBloc.dataStream,
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
    );
  }

  Widget _listWidget(DuaAmtModel duaAmtModel) {
    if (duaAmtModel.data!.isEmpty) {
      return const NoDataFound();
    } else {
      return ListView.builder(
        itemCount: duaAmtModel.data!.length,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        itemBuilder: (context, index) {
          var dateTime = duaAmtModel.data![index].dueDate;
          var fomattedDate =
              dateTime != null ? DateFormatter.convertDateFormat(dateTime) : '';

          return Card(
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
                        Text(
                          duaAmtModel.data![index].dueHead ?? '',
                          style: Palette.titleSB,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          fomattedDate,
                          style: Palette.titleSL,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '$kCurrency ${duaAmtModel.data![index].amount ?? ''}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }
}
