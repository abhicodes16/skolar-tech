import 'package:flutter/material.dart';
import 'package:pns_skolar/model/notification/all_notification_model.dart';

import '../../bloc/notification/all_notification_bloc.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/response.dart';
import '../../widget/error_message.dart';
import '../../widget/loading.dart';
import '../../widget/no_data_foud.dart';

class AllNotification extends StatefulWidget {
  final String? ntfId;
  const AllNotification({super.key, required this.ntfId});

  @override
  State<AllNotification> createState() => _AllNotificationState();
}

class _AllNotificationState extends State<AllNotification> {
  AllNotificationBloc? allNotificationBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allNotificationBloc = AllNotificationBloc(ntfId: widget.ntfId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Notification',
          style: Palette.appbarTitle,
        ),
        flexibleSpace: Container(
          decoration: Palette.appbarGradient,
        ),
      ),
      body: StreamBuilder(
        stream: allNotificationBloc!.dataStream,
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
                  onRetryPressed: () =>
                      allNotificationBloc!.fetchdata(ntfId: widget.ntfId),
                );
            }
          }
          return Container();
        },
      ),
    );
  }

  Widget _listWidget(AllNotificationModel allNotificationModel) {
    if (allNotificationModel.data!.isEmpty) {
      return const NoDataFound();
    } else {
      return ListView.builder(
        itemCount: allNotificationModel.data!.length,
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        itemBuilder: (context, index) {
          return Card(
            margin: kStandardMargin * 2,
            clipBehavior: Clip.antiAlias,
            shape: Palette.cardShape,
            elevation: 8,
            child: Container(
              margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${allNotificationModel.data![index].ntfType}',
                    style: Palette.titleT,
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
