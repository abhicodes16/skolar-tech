import 'package:flutter/material.dart';

import '../../bloc/fee/fee_structure_bloc.dart';
import '../../model/fee/fees_structure_model.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/response.dart';
import '../../widget/error_message.dart';
import '../../widget/loading.dart';
import '../../widget/no_data_foud.dart';

class FeeSturcture extends StatefulWidget {
  const FeeSturcture({super.key});

  @override
  State<FeeSturcture> createState() => _FeeSturctureState();
}

class _FeeSturctureState extends State<FeeSturcture> {
  FeeStructureBloc feeStructureBloc = FeeStructureBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FEEs Structure', style: Palette.appbarTitle),
        flexibleSpace: Container(decoration: Palette.appbarGradient),
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: feeStructureBloc.dataStream,
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

  Widget _listWidget(FeesStructureModel feeStructureModel) {
    if (feeStructureModel.data!.isEmpty) {
      return const NoDataFound();
    } else {
      return ListView.builder(
        itemCount: feeStructureModel.data!.length,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        itemBuilder: (context, index) {
          String className = feeStructureModel.data![index].className ?? '';
          bool isClassNameShow = true;

          if (feeStructureModel.data!.length > 1 && index != 0) {
            if (className == feeStructureModel.data![index - 1].className) {
              isClassNameShow = false;
            }
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              isClassNameShow
                  ? Container(
                      margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Text(
                        className,
                        style: Palette.themeHeader2,
                      ),
                    )
                  : const SizedBox(),
              Card(
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
                              feeStructureModel.data![index].feeHead ?? '',
                              style: Palette.titleSL,
                            ),
                            const SizedBox(height: 3),
                            Text(
                              feeStructureModel.data![index].period ?? '',
                              style: Palette.subTitle,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '$kCurrency ${feeStructureModel.data![index].amount ?? ''}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: kThemeColor,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }
}
