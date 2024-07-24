import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pns_skolar/controller/leave_approval_cnt.dart';
import 'package:pns_skolar/style/theme_constants.dart';
import 'package:pns_skolar/views/leave/approve_leave.dart';
import 'package:pns_skolar/widget/date_formatter.dart';

import '../../style/palette.dart';
import '../../utils/network/general_exception.dart';
import '../../utils/network/internet_exceptions_widget.dart';
import '../../utils/response.dart';
import '../../widget/no_data_foud.dart';

class LeaveApprovalStatus extends StatefulWidget {
  const LeaveApprovalStatus({super.key});

  @override
  State<LeaveApprovalStatus> createState() => _LeaveApprovalStatusState();
}

class _LeaveApprovalStatusState extends State<LeaveApprovalStatus> {
  final LeaveApprovalCnt _approvalCnt = Get.put(LeaveApprovalCnt());

  var width = Get.width;
  var height = Get.height;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _approvalCnt.leaveListApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Leave Approval', style: Palette.appbarTitle),
          flexibleSpace: Container(decoration: Palette.appbarGradient),
          elevation: 0,
        ),
        body: Obx(() {
          switch (_approvalCnt.rxRequestStatus.value) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());
            case Status.ERROR:
              if (_approvalCnt.error.value == 'No internet') {
                return InterNetExceptionWidget(
                  onPress: () => _approvalCnt.refreshApi(),
                );
              } else {
                return GeneralExceptionWidget(
                    onPress: () => _approvalCnt.refreshApi());
              }
            case Status.COMPLETED:
              return _listWidget();
          }
        }));
  }

  Widget _listWidget() {
    if (_approvalCnt.leaveApprovalData.value.data!.isEmpty) {
      return const NoDataFound();
    } else {
      return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          itemCount: _approvalCnt.leaveApprovalData.value.data!.length,
          itemBuilder: (context, index) {
            var dataIndex = _approvalCnt.leaveApprovalData.value.data![index];

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
                          Text(
                            dataIndex.leaveName ?? '-',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.5,
                                color: Colors.grey.shade500),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Purpose : ",
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
                              dataIndex.leavePurpose ?? '-',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                  color: Colors.red.shade500),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              dataIndex.remarks ?? '-',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                  color: Colors.orange.shade500),
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
                      dataIndex.approvalStatus == "A" ||
                              dataIndex.approvalStatus == "R"
                          ? const SizedBox()
                          : Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return ApproveDialog(
                                              leaveId: "${dataIndex.leaveId}",
                                            status: "A",
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: width,
                                      height: 35,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          // border: Border.all(color: Colors.grey.shade600,width: 1),
                                          color: kThemeColor),
                                      child: const Center(
                                        child: Text("Approve",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17.0,
                                            )),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 5,),

                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return ApproveDialog(
                                              leaveId: "${dataIndex.leaveId}",
                                            status: "R",
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: width,
                                      height: 35,
                                      decoration:  BoxDecoration(
                                        // border: Border.all(color: kThemeColor,width: 1),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                          color: kThemeColor.withOpacity(0.3)),
                                      child: const Center(
                                        child: Text("Reject",
                                            style: TextStyle(
                                              color: kThemeColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17.0,
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
