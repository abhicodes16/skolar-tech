import 'package:flutter/material.dart';

import '../../bloc/notification/notification_bloc.dart';
import '../../model/notification/notification_type_model.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/response.dart';
import '../../widget/error_message.dart';
import '../../widget/loading.dart';
import '../../widget/no_data_foud.dart';
import 'notification_by_id.dart';

class NotificationType extends StatefulWidget {
  const NotificationType({super.key});

  @override
  State<NotificationType> createState() => _NotificationTypeState();
}

class _NotificationTypeState extends State<NotificationType> {
  NotificationBloc notificationBloc = NotificationBloc();
  var colors = [
    Colors.red.shade50,
    Colors.blue.shade50,
    Colors.cyan.shade50,
    Colors.green.shade50,
    Colors.yellow.shade50,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification Type',
          style: Palette.appbarTitle,
        ),
        flexibleSpace: Container(
          decoration: Palette.appbarGradient,
        ),
      ),
      body: StreamBuilder(
        stream: notificationBloc.dataStream,
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
                  onRetryPressed: () => notificationBloc.fetchdata(),
                );
            }
          }
          return Container();
        },
      ),
    );
  }

  Widget _listWidget(NotificationTypeModel notificationTypeModel) {
    if (notificationTypeModel.data!.isEmpty) {
      return const NoDataFound();
    } else {
      return ListView.builder(
        itemCount: notificationTypeModel.data!.length,
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        itemBuilder: (context, index) {
          return Card(
            margin: kStandardMargin * 2,
            color: colors[index % colors.length],
            clipBehavior: Clip.antiAlias,
            shape: Palette.cardShape,
            elevation: 8,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationById(
                      categoryId:
                          notificationTypeModel.data![index].id.toString(),
                      name: notificationTypeModel.data![index].typeName,
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
                      '${notificationTypeModel.data![index].typeName}',
                      style: Palette.title,
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
