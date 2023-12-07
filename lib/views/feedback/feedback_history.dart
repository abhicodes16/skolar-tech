import 'package:flutter/material.dart';
import 'package:pns_skolar/bloc/feedback/feedback_history_bloc.dart';

import '../../model/feedback/feedback_history_model.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/response.dart';
import '../../widget/error_message.dart';
import '../../widget/loading.dart';
import '../../widget/no_data_foud.dart';

class FeedbackHistory extends StatefulWidget {
  const FeedbackHistory({super.key});

  @override
  State<FeedbackHistory> createState() => _FeedbackHistoryState();
}

class _FeedbackHistoryState extends State<FeedbackHistory> {
  FeedbackHistoryBloc feedbackHistory = FeedbackHistoryBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback History', style: Palette.appbarTitle),
        flexibleSpace: Container(decoration: Palette.appbarGradient),
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: feedbackHistory.dataStream,
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

  Widget _listWidget(FeedbackHistoryModel feedbackHistoryModel) {
    if (feedbackHistoryModel.data!.isEmpty) {
      return const NoDataFound();
    } else {
      return ListView.builder(
        itemCount: feedbackHistoryModel.data!.length,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        itemBuilder: (context, index) {
          String stsLvl = feedbackHistoryModel.data![index].sATSLVL ?? '';

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
                          feedbackHistoryModel.data![index].eNTITNAME
                              .toString(),
                          style: Palette.themeTitleSB,
                        ),
                        const SizedBox(height: 5),
                        Text(stsLvl, style: Palette.titleS),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      stsLvl == 'Satisfactory'
                          ? const Icon(
                              Icons.sentiment_very_dissatisfied,
                              color: Colors.red,
                            )
                          : stsLvl == 'Average'
                              ? const Icon(
                                  Icons.sentiment_dissatisfied,
                                  color: Colors.redAccent,
                                )
                              : stsLvl == 'Good'
                                  ? const Icon(
                                      Icons.sentiment_neutral,
                                      color: Colors.amber,
                                    )
                                  : stsLvl == 'Very Good'
                                      ? const Icon(
                                          Icons.sentiment_satisfied,
                                          color: Colors.lightGreen,
                                        )
                                      : stsLvl == 'Excellent'
                                          ? const Icon(
                                              Icons.sentiment_very_satisfied,
                                              color: Colors.green,
                                            )
                                          : const SizedBox()
                    ],
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
