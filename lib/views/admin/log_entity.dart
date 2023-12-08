import 'package:flutter/material.dart';
import 'package:pns_skolar/bloc/admin/log_entity_bloc.dart';
import 'package:pns_skolar/model/log_entity/log_entity_model.dart';
import 'package:pns_skolar/views/admin/log_entity_details.dart';

import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/response.dart';
import '../../widget/error_message.dart';
import '../../widget/loading.dart';
import '../../widget/no_data_foud.dart';

class LogEntity extends StatefulWidget {
  const LogEntity({super.key});

  @override
  State<LogEntity> createState() => _LogEntityState();
}

class _LogEntityState extends State<LogEntity> {
  LogEntityBloc logEntityBloc = LogEntityBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGS', style: Palette.appbarTitle),
      ),
      body: StreamBuilder(
        stream: logEntityBloc.dataStream,
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

  Widget _listWidget(LogEntityModel logEntityModel) {
    if (logEntityModel.data!.isEmpty) {
      return const NoDataFound();
    } else {
      return ListView.builder(
        itemCount: logEntityModel.data!.length,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LogEntityDetails(
                    entityId: logEntityModel.data![index].entityId.toString(),
                    entityName: logEntityModel.data![index].entityName ?? '',
                  ),
                ),
              );
            },
            child: Card(
              margin: kStandardMargin * 2,
              shape: Palette.cardShape,
              elevation: 5,
              clipBehavior: Clip.antiAlias,
              child: Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                //height: 40,
                child: Text(
                  logEntityModel.data![index].entityName ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
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
