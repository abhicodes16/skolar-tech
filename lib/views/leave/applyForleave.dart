import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pns_skolar/model/leave/get_leave_type.dart';

import 'package:pns_skolar/style/theme_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../style/palette.dart';
import '../../utils/api_constant.dart';
import '../../widget/error_dialouge.dart';
import '../../widget/success_dialouge.dart';

class ApplyForLeave extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ApplyForLeave_State();
  }
}

class ApplyForLeave_State extends State<ApplyForLeave>{


  var width = Get.width;
  var height = Get.height;

  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();

  TextEditingController leavePurposeController = TextEditingController();


  List<Data> data = [];
  List<Map<String, dynamic>> postLeaveData = [];
  var _selectedTypId = 1;

  var schoolCode;
  var token;

  var loading = false;

  Future<void> getLeaveType() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      schoolCode = pref.getString('schoolCode');
      token = pref.getString('token');
      print("--->$token");
    });

    final params = {
      'schoolCode': '$schoolCode',
    };

    final uri = Uri.parse(ApiConstant.GET_LEAVE_TYPE).replace(queryParameters: params);

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'apikey': ApiConstant.API_KEY,
      },
    );

    if (response.statusCode == 200) {
      try {
        final GetLeaveType leaveType = GetLeaveType.fromJson(json.decode(response.body));

        setState(() {
          data = leaveType.data ?? [];
        });
      } catch (e) {
        ErrorDialouge.showErrorDialogue(context, "Something is Wrong please try again later");
        print('Error decoding JSON: $e');
      }
    } else {
      print('Error: ${response.reasonPhrase}, Status Code: ${response.statusCode}');
    }
  }


  Future<void> postLeave() async {
    setState(() {
      loading = true;
      print("-->stdate $selectedStartDate");
      print('-->$_selectedTypId');
    });

    final params = {
      'schoolCode': '$schoolCode',
    };

    final uri = Uri.parse(ApiConstant.POST_LEAVE).replace(queryParameters: params);

    final response = await http.post(
      uri,
      headers: {
        'apikey': ApiConstant.API_KEY,
        'Content-Type': 'application/json',
        'token' : token
      },
      body: json.encode({
        'leaveTypeId' : '${_selectedTypId}',
        'fromDate': "${selectedStartDate.toLocal()}".split(' ')[0].toString(),
        'toDate' : "${selectedEndDate.toLocal()}".split(' ')[0].toString(),
        'leavePurpose' : leavePurposeController.text.toString()
      }),
    );


    try {
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body)['data'];
        print("-->response $responseData");
        setState(() {
          postLeaveData = List<Map<String, dynamic>>.from(responseData) ?? [];
          if (postLeaveData.isNotEmpty) {
            SuccessDialouge.showErrorDialogue(context, postLeaveData[0]['msg']);
          }
        });
      }
    } catch (e) {
      ErrorDialouge.showErrorDialogue(context, "Something is Wrong please try again later");
      print('Error decoding JSON: $e');
    } finally {
      setState(() {
        loading = false;
        leavePurposeController.clear();
        selectedEndDate = DateTime.now();
        selectedStartDate = DateTime.now();
      });
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLeaveType();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apply For Leave', style: Palette.appbarTitle),
        flexibleSpace: Container(decoration: Palette.appbarGradient),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 25,bottom: 25,left: 20,right: 20
        ),
        child: Column(
          children: [

            _leaveCard(),

            SizedBox(height: 20),

            _applybtn()


          ],
        ),
      ),
    );
  }

  Widget _applybtn(){
    return  InkWell(
      onTap: () {
        if(leavePurposeController.text.isNotEmpty){
          postLeave();
        }else{
          ErrorDialouge.showErrorDialogue(context, "Please enter the purpose of leave");
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: kThemeColor,
          borderRadius: BorderRadius.circular(15),
        ),
        height: 50,
        width: width,
        child:  loading ?
        Center(child: SizedBox(height: 30,width: 30,child: CircularProgressIndicator(color: Colors.white)),)
        :
        Center(child: Text("Apply",
          style: Palette.whiteBtnTxt,
        )),
      ),
    );

  }

  Widget _leaveCard(){
    return Expanded(
      child: ListView(
        children: [

          Align(
            alignment: Alignment.centerLeft,
            child: Text("Select Leave Type",
              style: Palette.titleT,
            ),
          ),

          SizedBox(height: 15,),

          _typeDropdown(),


          SizedBox(height: 20,),

          _selectStatEndDate(),

          SizedBox(height: 20,),


          Align(
            alignment: Alignment.centerLeft,
            child: Text("Leave Purpose :",
              style: Palette.titleT,
            ),
          ),

          SizedBox(height: 10,),

          _leavePurposeTextField()

        ],
      ),
    );
  }

  Widget _leavePurposeTextField(){
    return TextFormField(
      controller: leavePurposeController,
      maxLines: 5,
      decoration: InputDecoration(
        fillColor: kThemeColor.withOpacity(0.1),
        filled: true,
        suffixIcon: Icon(Icons.note_alt,color: kThemeColor),
        hintText: "Enter Pupose..",
        hintStyle: TextStyle(color: kThemeDarkColor.withOpacity(0.5)),
        contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: kThemeColor.withOpacity(0.1),width: 2)
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: kThemeColor.withOpacity(0.1),width:2)
        ),
      ),
    );
  }

  Widget _selectStatEndDate(){
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [

              Align(
                alignment: Alignment.centerLeft,
                child: Text("Start Date :",
                  style: Palette.titleT,
                ),
              ),

              SizedBox(height: 10,),


              TextFormField(
                readOnly: true,
                controller: TextEditingController(
                  text: "${selectedStartDate.toLocal()}".split(' ')[0],
                ),
                onTap: () => selectStartDate(context),
                decoration: InputDecoration(
                  fillColor: kThemeColor.withOpacity(0.1),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: kThemeColor.withOpacity(0.1),width:2)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: kThemeColor.withOpacity(0.1),width: 2)
                  ),
                  // labelText: 'Select Date',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today,color: kThemeColor),
                    onPressed: () => selectStartDate(context),
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(width: 20,),

        Expanded(
          child: Column(
            children: [

              Align(
                alignment: Alignment.centerLeft,
                child: Text("End Date :",
                  style: Palette.titleT,
                ),
              ),

              SizedBox(height: 10,),

              TextFormField(
                readOnly: true,
                controller: TextEditingController(
                  text: "${selectedEndDate.toLocal()}".split(' ')[0],
                ),
                onTap: () => selectEndDate(context),
                decoration: InputDecoration(
                  fillColor: kThemeColor.withOpacity(0.1),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: kThemeColor.withOpacity(0.1),width:2)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: kThemeColor.withOpacity(0.1),width: 2)
                  ),
                  // labelText: 'Select Date',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today,color: kThemeColor),
                    onPressed: () => selectEndDate(context),
                  ),
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }

  Widget _typeDropdown() {
    return Container(
      width: width,
      padding: const EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 2.0),
      decoration: BoxDecoration(
        color: kThemeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(width: 2.0, color: kThemeColor.withOpacity(0.1)),
      ),
      child: DropdownButton(
        isExpanded: true,
        underline: const SizedBox(),
        hint: const Text('Select Applicant Type'), // Not necessary for Option 1
        value: _selectedTypId,
        onChanged: (newValue) {
          setState(() {
            _selectedTypId = newValue!;
          });
        },
        items: data.map((Data val) {
          return DropdownMenuItem(
            value: val.leaveId,
            child: Text(val.leaveName ?? "", style: Palette.title),
          );
        }).toList(),
      ),
    );
  }

  Future<void> selectStartDate(BuildContext context) async{

    final pickedStartDate = await showDatePicker(
        context: context,
        initialDate: selectedStartDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101)
    );

    if(pickedStartDate != null && pickedStartDate != selectedStartDate){
      setState(() {
        selectedStartDate = pickedStartDate;
      });
    }

  }

  Future<void> selectEndDate(BuildContext context) async{

    final pickedEndDate = await showDatePicker(
        context: context,
        initialDate: selectedStartDate,
        firstDate: selectedStartDate,
        lastDate: DateTime(2101)
    );

    if(pickedEndDate != null && pickedEndDate != selectedEndDate){
      setState(() {
        selectedEndDate = pickedEndDate;
      });
    }
  }


}