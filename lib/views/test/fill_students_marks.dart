import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pns_skolar/model/test/insert_marks_model.dart';
import 'package:pns_skolar/utils/api_constant.dart';
import 'package:pns_skolar/views/body.dart';
import 'package:pns_skolar/widget/error_dialouge.dart';
import 'package:pns_skolar/widget/success_dialouge.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../model/attendance/student_attnc_detail_model.dart';
import '../../repo/attendance/student_attendance_dtl_repo.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';

class FillMarks extends StatefulWidget{
  final String cLS_CODE;
  final String sEME_CODE;
  final String sUBID;
  final String examTypeId;
  final String markEntityDate;
  const FillMarks({
    super.key,
    required this.cLS_CODE,
    required this.sEME_CODE,
    required this.sUBID,
    required this.examTypeId,
    required this.markEntityDate,
  });

  @override
  State<StatefulWidget> createState() {
    return FillMarks_State();
  }
}

class FillMarks_State extends State<FillMarks>{


  var selectedCheckbox = [];

  List<TypeData> _typeModelList = [];
  TypeData _selectedReportType = TypeData();

  var loading;
  var token;
  var schoolCode;

  bool isLoading = false;



  var InsertMarksData = <Data>[];
  var msg ;

  List<TextEditingController> textEditingControllerList = [];




  @override
  void initState() {
    getTypeApi();
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in textEditingControllerList) {
      controller.dispose();
    }
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Enter Marks',
          style: Palette.appbarTitle,
        ),
        flexibleSpace: Container(
          decoration: Palette.appbarGradient,
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            isLoading?
            Expanded(child: Center(child: CircularProgressIndicator()))
            :
            _typeModelList.isEmpty
                ? Expanded(
                  child: Center(
              child: Text("No Data Found..!"),
            ),
                )
            :
           _studentListAndMarks()
          ],
        ),
      ),
    );
  }

  Widget _studentListAndMarks(){
    return  Expanded(
      child: Column(children: [

        SizedBox(height: 20,),

        Container(
          margin: EdgeInsets.only(left: 10,right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Container(
                decoration: BoxDecoration(
                    color: kThemeColor,
                    border: Border.all(color: kThemeColor,width: 1.5),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0,left: 15,bottom: 3,top: 3),
                  child: Text(
                    "Index",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,fontWeight: FontWeight.w600
                    ) ,
                  ),
                ),
              ),

              Container(
                decoration: BoxDecoration(
                    color: kThemeColor,
                    border: Border.all(color: kThemeColor,width: 1.5),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0,left: 15,bottom: 3,top: 3),
                  child: Text(
                    "Enter Marks",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,fontWeight: FontWeight.w600
                    ) ,
                  ),
                ),
              )

            ],
          ),
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              itemCount: _typeModelList.length,
              itemBuilder: (context, index) {
                // print("-->$marksValues");
                textEditingControllerList[index].text = '0';
                return ListTile(
                  title:  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${index + 1}.  '),
                      Expanded(
                        child: Text(
                          _typeModelList[index].sTDNAME ?? '',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,fontWeight: FontWeight.w600
                          ),
                        ),
                      ),

                      SizedBox(width: 20),

                      Container(
                        width: 100,
                        height: 55,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          readOnly: false,
                          controller: textEditingControllerList[index],
                          decoration: etBoxDecoration("Marks", "${index+1}"),
                        ),
                      ),

                    ],
                  ),
                );
              },
            ),
          ),
        ),
        _subMit(),
      ],),
    );
  }

  InputDecoration etBoxDecoration(String label,index) {
    return InputDecoration(
      fillColor: white,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kThemeColor.withOpacity(0.1), width: 2.0),
        borderRadius: BorderRadius.circular(7.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kThemeColor.withOpacity(0.1), width: 2.0),
        borderRadius: BorderRadius.circular(7.0),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: kThemeColor.withOpacity(0.1), width: 2.0),
        borderRadius: BorderRadius.circular(7.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kThemeColor.withOpacity(0.1), width: 2.0),
        borderRadius: BorderRadius.circular(7.0),
      ),
      // contentPadding: const  EdgeInsets.symmetric(vertical: 10,horizontal: 25),
      hintText: label,
      contentPadding: EdgeInsets.all(15)
      /*prefixIconConstraints: BoxConstraints.tight(Size.fromRadius(10)),
      hintStyle: const TextStyle(color: Colors.grey,fontSize: 13),
      prefixIcon: CircleAvatar(
        radius: 2,child: Text(index,style: TextStyle(fontSize: 15,color: Colors.red),
      ))*/
    );
  }


  Widget _subMit() {
    return Container(
      margin: const EdgeInsets.fromLTRB(40, 0, 40, 15),
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          List<String> textFieldsValues = textEditingControllerList.map((controller) {
            return controller.text.isEmpty ? '0' : controller.text;
          }).toList();

          String marks = textFieldsValues.join(':');
          print('marks Values: $marks');

          String studentCodes = _typeModelList.map((model) => model.sTDCODE ?? '').join(':');
          print("Stud codes : ${studentCodes.toString()}");

          uploadMarksAPI(studentCodes.toString(),marks.toString());
        },
        style: ElevatedButton.styleFrom(
          elevation: 5,
          fixedSize: const Size(200, 50),
          primary: kThemeColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              50,
            ),
          ),
        ),
        child: const Text(
          'SUBMIT',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }


  Future<void> uploadMarksAPI(String studCode,String marks) async{
    loading = true;

    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString('token');
      schoolCode = pref.getString('schoolCode');
      print("--->$token");
    });

    final params = {
      'schoolCode' : '$schoolCode'
    };

    final uri = Uri.parse(ApiConstant.INSERT_MARKS).replace(
      queryParameters: params
    );

    final body = {
      'branchCode': widget.cLS_CODE,
      'semesterCode':widget.sEME_CODE,
      'subjectCode':widget.sUBID,
      'examTypeId':widget.examTypeId,
      'markEntryDate':widget.markEntityDate,
      'studentCode': studCode,
      'studentMark': marks,
    };

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'apikey': ApiConstant.API_KEY,
        'token': token,
      },
      body: jsonEncode(body)
    );


      try{
        if(response.statusCode == 200){
          final InsertMarksModel insertMarksModel = InsertMarksModel.fromJson(json.decode(response.body));
          setState(() {
            InsertMarksData = insertMarksModel.data ?? [];
            msg = InsertMarksData[0].msg;
            if(msg.toString() == "Success"){
              Get.offAll(()=>Body());
            }
          });
          SuccessDialouge.showErrorDialogue(context,msg.toString());
        }else{
          ErrorDialouge.showErrorDialogue(
              context, "Something is wrong, please try again later");
          print('Error: ${response.reasonPhrase}, Status Code: ${response.statusCode}');
        }
      }catch(e){
        ErrorDialouge.showErrorDialogue(
            context, "Something is wrong, please try again later");
        print('Error decoding JSON: $e');
      }finally{
        setState(() {
          loading = false;
        });
      }

  }

    Future<void> getTypeApi() async {
    isLoading = true;
      // LoadingDialog.showLoadingDialog(context);
      StudentAttendanceRepo attendanceRepo = StudentAttendanceRepo();
      try {
        StudentAttendanceModel data = await attendanceRepo.fetchData(
            cLS_CODE: widget.cLS_CODE, sEME_CODE: widget.sEME_CODE);

        if (data.success!) {
          setState(() {
            for (var i = 0; i < data.data!.length; i++) {
              selectedCheckbox.add(true);
              textEditingControllerList.add(TextEditingController());
            }
            _typeModelList = data.data!;
            if (_typeModelList.isNotEmpty) {
              _selectedReportType = _typeModelList.first;
            }
          });
        }
      } catch (e) {
        print('Exeption $e');
      }finally{
        setState(() {
          isLoading = false;
        });
      }
    }

}