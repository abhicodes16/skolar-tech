import 'package:flutter/material.dart';
import 'package:pns_skolar/style/theme_constants.dart';

import '../../bloc/notification/notification_byId_bloc.dart';
import '../../model/notification/notification_by_id_model.dart';
import '../../style/palette.dart';
import '../../utils/response.dart';
import '../../widget/error_message.dart';
import '../../widget/loading.dart';
import '../../widget/no_data_foud.dart';
import 'all_notification.dart';

class NotificationById extends StatefulWidget {
  final String? categoryId;
  final String? name;
  const NotificationById(
      {super.key, required this.categoryId, required this.name});

  @override
  State<NotificationById> createState() => _NotificationByIdState();
}

class _NotificationByIdState extends State<NotificationById> {
  NotificationByIdBloc? notificationByIdBloc;

  @override
  void initState() {
    notificationByIdBloc = NotificationByIdBloc(id: widget.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name ?? '',
          style: Palette.appbarTitle,
        ),
        flexibleSpace: Container(
          decoration: Palette.appbarGradient,
        ),
      ),
      body: StreamBuilder(
        stream: notificationByIdBloc!.dataStream,
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
                      notificationByIdBloc!.fetchdata(id: widget.categoryId),
                );
            }
          }
          return Container();
        },
      ),
    );
  }

  Widget _listWidget(NotificationByIdModel notificationByIdModel) {
    if (notificationByIdModel.data!.isEmpty) {
      return const NoDataFound();
    } else {
      return ListView.builder(
        itemCount: notificationByIdModel.data!.length,
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        itemBuilder: (context, index) {
          return Card(
            margin: kStandardMargin * 2,
            clipBehavior: Clip.antiAlias,
            shape: Palette.cardShape,
            elevation: 8,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllNotification(
                      ntfId:
                          notificationByIdModel.data![index].ntfId.toString(),
                      // categoryId: index.toString(),
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${notificationByIdModel.data![index].ntfType}',
                      style: Palette.titleT,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      '${notificationByIdModel.data![index].ntfbody}',
                      style: Palette.title,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      '${notificationByIdModel.data![index].ntfDatetime}',
                      style: Palette.subTitleGrey,
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
