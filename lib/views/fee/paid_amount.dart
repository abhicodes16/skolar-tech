import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../bloc/fee/fee_bloc.dart';
import '../../model/fee/fee_model.dart';
import '../../style/assets_constants.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/response.dart';
import '../../widget/date_formatter.dart';
import '../../widget/error_message.dart';
import '../../widget/loading.dart';
import '../../widget/no_data_foud.dart';
import 'package:http/http.dart' as http;

class PaidAmount extends StatefulWidget {
  const PaidAmount({super.key});

  @override
  State<PaidAmount> createState() => _PaidAmountState();
}

class _PaidAmountState extends State<PaidAmount> {
  FeeBloc? feeBloc;

  String urlPDFPath = "";
  bool exists = true;
  bool loaded = false;

  Future<File> getFileFromUrl(String url, {name, extention}) async {
    var fileName = 'receipt';
    if (name != null) {
      fileName = name;
    }

    var fileExt = 'pdf';
    if (extention != null) {
      fileExt = extention;
    }

    try {
      var data = await http.get(Uri.parse(url));
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$fileName.$fileExt");
      print(dir.path);
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  void requestPersmission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
  }

  @override
  void initState() {
    super.initState();
    requestPersmission();
    feeBloc = FeeBloc();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: feeBloc!.dataStream,
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

  Widget _listWidget(FeeModel feeModel) {
    if (feeModel.data!.isEmpty) {
      return const NoDataFound();
    } else {
      return ListView.builder(
        itemCount: feeModel.data!.length,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        itemBuilder: (context, index) {
          var dateTime = feeModel.data![index].collectionDate;
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
                          feeModel.data![index].dueHead ?? '',
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
                  const SizedBox(width: 10),
                  Text(
                    '$kCurrency ${feeModel.data![index].amount ?? ''}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.orange,
                      fontSize: 16.0,
                    ),
                  ),
                  // const SizedBox(width: 10),
                  // InkWell(
                  //   onTap: () {
                  //     String fileUrl = feeModel.data![index].recipt.toString();
                  //     var ext = fileUrl.split('.');

                  //     getFileFromUrl(
                  //       fileUrl,
                  //       extention: ext.last,
                  //     ).then(
                  //       (value) => {
                  //         setState(() {
                  //           if (value != null) {
                  //             urlPDFPath = value.path;
                  //             loaded = true;
                  //             exists = true;
                  //             OpenFile.open(urlPDFPath);
                  //           } else {
                  //             exists = false;
                  //           }
                  //         })
                  //       },
                  //     );
                  //   },
                  //   child: Image.asset(
                  //     Assets.pdf,
                  //     width: 30,
                  //   ),
                  // )
                  
                ],
              ),
            ),
          );
        },
      );
    }
  }
}
