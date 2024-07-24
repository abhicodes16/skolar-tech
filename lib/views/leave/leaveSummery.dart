import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pns_skolar/style/theme_constants.dart';
import 'package:pns_skolar/model/leave/get_leave_summery.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../style/palette.dart';
import '../../utils/api_constant.dart';
import '../../widget/error_dialouge.dart';

class LeaveSummery extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LeaveSummery_State();
  }
}

class LeaveSummery_State extends State<LeaveSummery>{

  var width = Get.width;
  var height = Get.height;

  var leaveSummeryData = <Data>[];

  var schoolCode;
  var token;

  var loading = false;

  Future<void> fetchLeaveSummery() async {
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

    final uri = Uri.parse(ApiConstant.GET_LEAVE_SUMMERY).replace(
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
        final GetLeaveSummery leaveStatus = GetLeaveSummery.fromJson(
            json.decode(response.body));

        setState(() {
          leaveSummeryData = leaveStatus.data ?? [];
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
    fetchLeaveSummery();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leave Summary', style: Palette.appbarTitle),
        flexibleSpace: Container(decoration: Palette.appbarGradient),
        elevation: 0,
      ),
      body:
      loading ?
      Center(child: SizedBox(height: 40,width: 40,child: CircularProgressIndicator()),)
      :
      _summeryList(),
    );
  }

  Widget _summeryList(){
    return ListView.builder(
      itemCount: leaveSummeryData.length,
      itemBuilder: (context, index) {

        final dataIndex = leaveSummeryData[index];
        return Padding(
          padding: const EdgeInsets.only(
              top: 15,bottom: 15,right: 20,left: 20
          ),
          child: Card(
            elevation: 4,
            shadowColor: kThemeColor,
            child: Container(
              width: width,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 18,bottom: 15,top: 15,right: 18
                ),
                child: Column(
                  children: [

                    Row(
                      children: [


                        Expanded(
                          child: Text(dataIndex.leavename ?? "", style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 17.0,
                              color: Colors.black
                          ),),
                        ),


                        Icon(Icons.label_important_sharp,size: 25,color: kThemeColor,)

                      ],
                    ),

                    SizedBox(
                      height: 5,
                    ),

                    Divider(thickness:0.5 ,color: Colors.grey,),

                    SizedBox(
                      height: 5,
                    ),

                    Row(
                      children: [


                        _titleText("Total Balanace : "),

                        SizedBox(width: 10,),

                        Text("${dataIndex.totalBalance ?? "-"}", style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 17.0,
                            color: Colors.black
                        ),),

                      ],
                    ),

                    SizedBox(height: 10,),

                    Row(
                      children: [

                        _titleText("Used : "),

                        SizedBox(width: 5,),

                        Text("${dataIndex.usedTotal ?? "-"}", style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 17.0,
                            color: Colors.red
                        ),),

                        Spacer(),


                        _titleText("Available : "),

                        SizedBox(width: 5,),

                        Text("${dataIndex.availableBalance ?? "-"}", style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 17.0,
                            color: Colors.green
                        ),),


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

  Widget _titleText(title){
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 15.0,
          color: kThemeColor
      ),),
    );
  }
}