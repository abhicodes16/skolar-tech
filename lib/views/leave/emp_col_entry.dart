import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pns_skolar/views/leave/add_col_entry.dart';

import '../../controller/emp_col_cnt.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/network/general_exception.dart';
import '../../utils/network/internet_exceptions_widget.dart';
import '../../utils/response.dart';
import '../../widget/no_data_foud.dart';

class EmpColEntry extends StatefulWidget {
  const EmpColEntry({super.key});

  @override
  State<EmpColEntry> createState() => _EmpColEntryState();
}

class _EmpColEntryState extends State<EmpColEntry> {

  var width = Get.width;
  var height = Get.height;

  final EmpColCnt _colEntry = Get.put(EmpColCnt());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _colEntry.getEntryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee COL Entry', style: Palette.appbarTitle),
        flexibleSpace: Container(decoration: Palette.appbarGradient),
        elevation: 0,
      ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return const AddColDialog();
              },
          );
        },
          backgroundColor: kThemeColor,
        child: const Center(child: Icon(Icons.add,size: 25,color: Colors.white,)),
        ),
        body: Obx(() {
          switch (_colEntry.rxRequestStatus.value) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());
            case Status.ERROR:
              if (_colEntry.error.value == 'No internet') {
                return InterNetExceptionWidget(
                  onPress: () => _colEntry.refreshApi(),
                );
              } else {
                return GeneralExceptionWidget(
                    onPress: () => _colEntry.refreshApi());
              }
            case Status.COMPLETED:
              return _listWidget();
          }
        })
    );
    
  }

  Widget _listWidget() {
    if (_colEntry.colEntryData.value.data!.isEmpty) {
      return const NoDataFound();
    } else {
      return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          itemCount: _colEntry.colEntryData.value.data!.length,
          itemBuilder: (context, index) {
            var dataIndex = _colEntry.colEntryData.value.data![index];

            return Card(
              elevation: 7,
              margin: const EdgeInsets.only(right: 15, left: 15, bottom: 10),
              child: Container(
                width: width,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              dataIndex.employeeName ?? "-",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                  color: kThemeColor),
                            ),
                          ),
                          dataIndex.approvalStatus == "A"
                              ? Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // border: Border.all(color: Colors.grey.shade600,width: 1),
                                color: Colors.green.shade600),
                            child: const Padding(
                              padding: EdgeInsets.only(
                                  left: 15, right: 15, bottom: 2, top: 2),
                              child: Text("Approved",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                  )),
                            ),
                          )
                              : dataIndex.approvalStatus == "R"
                              ? Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(10),
                                // border: Border.all(color: Colors.grey.shade600,width: 1),
                                color: Colors.red.shade600),
                            child: const Padding(
                              padding: EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                  bottom: 2,
                                  top: 2),
                              child: Text("Rejected",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                  )),
                            ),
                          )
                              : const SizedBox(),
                        ],
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Expanded(
                            child: Row(
                              children: [

                                Icon(Icons.date_range,size: 15,color: Colors.black,),
                                SizedBox(width: 10,),
                                Text(
                                  "${dataIndex.transactionDate ?? "-"}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13.0,
                                      color: Colors.black),
                                ),

                              ],
                            ),
                          ),

                          dataIndex.approvalDate == null ?
                          SizedBox()
                              :
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                "Approved On ${dataIndex.approvalDate}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13.0,
                                    color: Colors.green.shade500),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        dataIndex.descriptions ?? '-',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                            color: Colors.red.shade500),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Remark : ",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              dataIndex.approvalRemarks ?? '-',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                  color: Colors.orange.shade500),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "From : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  height: 25,
                                  width: width,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade600,
                                          width: 1)),
                                  child: Center(
                                    child: Text(dataIndex.fromDate ?? '-',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "To : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  height: 25,
                                  width: width,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade600,
                                          width: 1)),
                                  child: Center(
                                    child: Text(dataIndex.toDate ?? '-',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }

}
