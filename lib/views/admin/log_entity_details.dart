import 'package:flutter/material.dart';
import 'package:pns_skolar/bloc/admin/log_entity_details_bloc.dart';

import '../../model/log_entity/log_entity_details_model.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/response.dart';
import '../../widget/error_message.dart';
import '../../widget/loading.dart';
import '../../widget/no_data_foud.dart';

class LogEntityDetails extends StatefulWidget {
  final String entityId;
  final String entityName;
  const LogEntityDetails({
    super.key,
    required this.entityId,
    required this.entityName,
  });

  @override
  State<LogEntityDetails> createState() => _LogEntityDetailsState();
}

class _LogEntityDetailsState extends State<LogEntityDetails> {
  LogEntityDetailsBloc? logEntityDetailsBloc;

  @override
  void initState() {
    logEntityDetailsBloc = LogEntityDetailsBloc(widget.entityId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGS - ${widget.entityName}', style: Palette.appbarTitle),
      ),
      body: StreamBuilder(
        stream: logEntityDetailsBloc!.dataStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Loading(loadingMessage: snapshot.data.message);
              case Status.COMPLETED:
                return _listWidget(snapshot.data.data);
              case Status.ERROR:
                return ErrorMessage(errorMessage: snapshot.data.message);
            }
          }
          return Container();
        },
      ),
    );
  }

  Widget _listWidget(LogEntityDetailsModel logEntityModel) {
    if (logEntityModel.data!.isEmpty) {
      return const NoDataFound();
    } else {
      return ListView.builder(
        itemCount: logEntityModel.data!.length,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        itemBuilder: (context, index) {
          return Card(
            margin: kStandardMargin * 2,
            shape: Palette.cardShape,
            elevation: 5,
            clipBehavior: Clip.antiAlias,
            child: Container(
              margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              //height: 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    logEntityModel.data![index].entity ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    logEntityModel.data![index].activityDatetime ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontSize: 12.0,
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
