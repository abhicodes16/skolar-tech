import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../utils/response.dart';
import '../model/menu_control_model.dart';
import '../repo/menu_control_repo.dart';

class MenuControlBloc {
  late MenuControlRepo menuControlRepo;
  late StreamController _dataController;

  StreamSink get dataSink => _dataController.sink;
  Stream get dataStream => _dataController.stream;

  MenuControlBloc({ValueChanged<MenuControlData>? onMenuControl}) {
    _dataController = StreamController();
    menuControlRepo = MenuControlRepo();
    fetchdata(onMenuControl: onMenuControl);
  }

  fetchdata({ValueChanged<MenuControlData>? onMenuControl}) async {
    dataSink.add(Response.loading('Loading Data..!'));

    try {
      MenuControlModel data = await menuControlRepo.fetchData();
      dataSink.add(Response.completed(data));
      // if (data.data != null) {
      //   if (data.data!.isNotEmpty) {
      //     onMenuControl!(data.data!.first);
      //   }
      // }
    } catch (e) {
      dataSink.add(Response.error('$e'));
    }
  }
}
