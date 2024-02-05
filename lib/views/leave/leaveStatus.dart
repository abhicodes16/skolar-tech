import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pns_skolar/style/theme_constants.dart';
import 'package:pns_skolar/model/leave/get_leave_status.dart';
import 'package:http/http.dart' as http;
import 'package:pns_skolar/widget/error_dialouge.dart';
import 'package:pns_skolar/widget/loading_dialogue.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../style/palette.dart';
import '../../utils/api_constant.dart';

class LeaveSatus extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LeaveSatus_State();
  }
}

class LeaveSatus_State extends State<LeaveSatus>{

  var width = Get.width;
  var height = Get.height;

  var schoolCode;
  var token;

  var loading = false;

  var leaveStatusData = <Data>[];

  Future<void> fetchLeaveStatus() async {
    loading = true;

    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      schoolCode = pref.getString('schoolCode');
      token = pref.getString('token');
      print("--->$token");
    });

      final params = {
        'schoolCode': '$schoolCode',
      };

      final uri = Uri.parse(ApiConstant.GET_LEAVE_STATUS).replace(
          queryParameters: params);


      final response = await http.get(uri,
        headers: {
          'Content-Type': 'application/json',
          'apikey': ApiConstant.API_KEY,
          'token' : token
        },
      );

      if (response.statusCode == 200) {
        try {
          final GetLeaveStatus leaveStatus = GetLeaveStatus.fromJson(
              json.decode(response.body));

          setState(() {
            leaveStatusData = leaveStatus.data ?? [];
          });
        } catch (e) {
          ErrorDialouge.showErrorDialogue(
              context, "Something is Wrong please try again later");
          print('Error decoding JSON: $e');
        }finally{
          setState(() {
            loading = false;
          });
        }
      } else {
        ErrorDialouge.showErrorDialogue(
            context, "Something is Wrong please try again later");
        print('Error: ${response.reasonPhrase}, Status Code: ${response
            .statusCode}');
    }
  }

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      fetchLeaveStatus();
    }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Leave Status List', style: Palette.appbarTitle),
          flexibleSpace: Container(decoration: Palette.appbarGradient),
          elevation: 0,
        ),
        body: loading ?
        Center(child: SizedBox(height: 40,width: 40,child: CircularProgressIndicator()),)
        :
        _statusList(),
      );
    }

    Widget _statusList(){
    return ListView.builder(
      itemCount: leaveStatusData.length,
      itemBuilder: (context, index) {

        final dataIndex = leaveStatusData[index];

        return Padding(
          padding: const EdgeInsets.only(
              left: 20,right: 20,top: 10,bottom: 10
          ),
          child: Card(
            elevation: 4,
            shadowColor: kThemeColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
            child: Container(
              width: width,
              // height: 60,
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 18, left: 18, top: 15, bottom: 15
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(dataIndex.leaveTypeName ?? "-", style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 17.0,
                              color: Colors.black
                          ),),
                        ),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: dataIndex.approvalStatus == 'A'
                                  ? Colors.green.withOpacity(0.8)
                                  : (dataIndex.approvalStatus == 'R'
                                  ? Colors.red.withOpacity(0.8)
                                  : Colors.orange.withOpacity(0.8)
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                bottom: 5,
                                top: 5,
                              ),
                              child: Center(
                                child: Text(
                                  dataIndex.approvalStatus == 'P'
                                      ? "Pending"
                                      : (dataIndex.approvalStatus == 'A'
                                      ? "Approved"
                                      : "Rejected"),
                                  style:  TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13.0,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )

                      ],
                    ),

                    SizedBox(height: 15,),

                    Row(
                      children: [

                        Icon(Icons.calendar_today,size: 17,),

                        SizedBox(width: 5,),

                        Text('Leave From : ', style:Palette.titlestatus3),

                        Center(child: Text(
                            dataIndex.fromDate ?? "-" , style: Palette.titlestatus2)),

                        Text("  -  ",style: TextStyle(color: Colors.black)),

                        Center(child: Text(
                            dataIndex.toDate ?? "-" , style:Palette.titlestatus2)),


                        Expanded(child: SizedBox()),


                      ],
                    ),

                    SizedBox(height: 10,),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        Icon(Icons.question_mark,size: 17,),

                        SizedBox(width: 5,),

                        Text('Purpose : ', style: Palette.titlestatus3,),

                        Expanded(child: Text(
                          dataIndex.leavePurpose ?? "-" ,
                          style: Palette.titlestatus2,)),

                      ],
                    ),

                    SizedBox(height: 10,),


                    Row(
                      children: [

                        Icon(Icons.edit_calendar_sharp,size: 17,),

                        SizedBox(width: 5,),


                        Text('Approval Date : ', style:Palette.titlestatus3),

                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: kThemeColor.withOpacity(0.5)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 5, top: 5
                              ),
                              child:
                              dataIndex.approvalDate == '' ?
                              Center(child: Text(
                                "-" , style: Palette.dateStatus,))
                                  :
                              Center(child: Text(
                                dataIndex.approvalDate ?? "-" , style: Palette.dateStatus,)),
                            )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    }

}