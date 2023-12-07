import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pns_skolar/bloc/feedback/feedback_entity_bloc.dart';
import 'package:pns_skolar/model/feedback/feedback_entity_model.dart';
import 'package:pns_skolar/views/feedback/feedback_history.dart';
import 'package:pns_skolar/widget/success_dialouge.dart';

import '../../model/common_model.dart';
import '../../repo/feedback/feedback_repo.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/response.dart';
import '../../widget/error_dialouge.dart';
import '../../widget/error_message.dart';
import '../../widget/loading.dart';
import '../../widget/loading_dialogue.dart';
import '../../widget/no_data_foud.dart';

class FeedbackEntity extends StatefulWidget {
  const FeedbackEntity({super.key});

  @override
  State<FeedbackEntity> createState() => _FeedbackEntityState();
}

class _FeedbackEntityState extends State<FeedbackEntity> {
  FeedbackEntityBloc fedbackEntityBloc = FeedbackEntityBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback', style: Palette.appbarTitle),
        flexibleSpace: Container(decoration: Palette.appbarGradient),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FeedbackHistory(),
                ),
              );
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: fedbackEntityBloc.dataStream,
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

  Widget _listWidget(FeedbackEntityModel feedbackModel) {
    if (feedbackModel.data!.isEmpty) {
      return const NoDataFound();
    } else {
      return ListView.builder(
        itemCount: feedbackModel.data!.length,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        itemBuilder: (context, index) {
          return Card(
            margin: kStandardMargin * 2,
            shape: Palette.cardShape,
            elevation: 8,
            child: InkWell(
              onTap: () {
                _ratingDialog(
                  feedbackModel.data![index].eNTITID.toString(),
                  feedbackModel.data![index].eNTITNAME.toString(),
                );
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            feedbackModel.data![index].eNTITNAME.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: kThemeColor,
                              fontSize: 16.0,
                            ),
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

  Future<void> _ratingDialog(String entityId, String entityName) async {
    return showDialog(
        context: context,
        builder: (context) {
          int statusLvl = 3;

          List statusTextList = [
            'Satisfactory',
            'Average',
            'Good',
            'Very Good',
            'Excellent'
          ];

          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Add Feedback'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Divider(),
                  const SizedBox(height: 15),
                  Text(entityName, style: Palette.bntText),
                  const SizedBox(height: 25),
                  RatingBar.builder(
                    initialRating: statusLvl.toDouble(),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return const Icon(
                            Icons.sentiment_very_dissatisfied,
                            color: Colors.red,
                          );
                        case 1:
                          return const Icon(
                            Icons.sentiment_dissatisfied,
                            color: Colors.redAccent,
                          );
                        case 2:
                          return const Icon(
                            Icons.sentiment_neutral,
                            color: Colors.amber,
                          );
                        case 3:
                          return const Icon(
                            Icons.sentiment_satisfied,
                            color: Colors.lightGreen,
                          );
                        case 4:
                          return const Icon(
                            Icons.sentiment_very_satisfied,
                            color: Colors.green,
                          );
                      }
                      return const Icon(Icons.sentiment_very_satisfied);
                    },
                    onRatingUpdate: (rating) {
                      setState(() {
                        statusLvl = rating.toInt();
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  Text(
                    statusTextList[statusLvl - 1],
                    style: Palette.subTitleGrey,
                  )
                ],
              ),
              actions: <Widget>[
                MaterialButton(
                  color: kThemeColor.withOpacity(0.1),
                  elevation: 0,
                  textColor: Colors.black,
                  shape: Palette.btnShape,
                  child: const Text('Cancel'),
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                ),
                MaterialButton(
                  color: kThemeColor,
                  textColor: Colors.white,
                  elevation: 0,
                  shape: Palette.btnShape,
                  child: const Text('Submit'),
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                      _setDataToAPI(
                        entityId: entityId,
                        statusLevel: statusLvl.toString(),
                      );
                    });
                  },
                ),
              ],
            );
          });
        });
  }

  void _setDataToAPI(
      {required String entityId, required String statusLevel}) async {
    LoadingDialog.showLoadingDialog(context);
    FeedbackRepo feedbackRepo = FeedbackRepo();

    try {
      CommonModel? data = await feedbackRepo.sendFeedback(
        entityId: entityId,
        statusLevel: statusLevel,
      );
      Navigator.pop(context);
      if (data.success != null) {
        if (data.success!) {
          SuccessDialouge.showErrorDialogue(
              context, 'Feedback Submit Successfully');
        } else {
          ErrorDialouge.showErrorDialogue(context, data.message ?? '');
        }
      }
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(context, e.toString());
    }
  }
}
