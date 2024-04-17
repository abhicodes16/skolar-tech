import 'dart:convert';
import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pns_skolar/widget/success_dialouge.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../model/course/branch_select_model.dart';
import '../../repo/Course/select_class_repo.dart';
import '../../style/assets_constants.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/api_constant.dart';
import '../../widget/error_dialouge.dart';
import '../../widget/loading_dialogue.dart';
import '../../widget/toast.dart';

class PostQueryDialog extends StatefulWidget {


  @override
  _PostQueryDialogState createState() => _PostQueryDialogState();
}

class _PostQueryDialogState extends State<PostQueryDialog> {
  final TextEditingController _queryController = TextEditingController();


  bool submitLoading = false;

  var height = Get.height;
  var width = Get.width;

  final SelectClassRepo _selectClassRepo = SelectClassRepo();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectBranchApi();
  }

  bool loading = false;
  List<BranchSelectDataModel> _selectBranchModelList = [];
  int? selectedBranchValue;


  Future<void> selectBranchApi() async {

    setState(() {
      loading = true;
    });
    SelectClassRepo selectClassRepo = SelectClassRepo();
    try {
      BranchSelectModel data = await selectClassRepo.fetchBranchData();

      if (data.success!) {
        setState(() {
          _selectBranchModelList = data.data!;
        });
      }
    } catch (e) {
      print('Exeption $e');
      print('$selectedBranchValue');
    }finally{
      setState(() {
        loading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // Assuming 'width' is defined somewhere in your class.

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Stack(
          alignment: Alignment.topCenter,
          children: [

            Padding(
              padding: const EdgeInsets.only(
                  top: 20
              ),
              child: AlertDialog(
                //key: key,
                //backgroundColor: Colors.white,
                content: Container(
                  width: width,
                  child:
                  loading ?
                  Container(height: height*0.4,child: Center(child: SizedBox(width: 30,height: 30,child: CircularProgressIndicator())),)
                      :
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      SizedBox(height: 30,),

                      Align(
                          alignment: Alignment.center,
                          child: Text("Enter Your Query")
                      ),

                      SizedBox(height: 20,),


                      CustomDropdown<String>(
                        decoration: CustomDropdownDecoration(expandedFillColor: Colors.white,closedFillColor: Colors.grey.shade200),
                        hintText: 'Select Month',
                        items: List.generate(_selectBranchModelList.length, (index) {

                          return "${_selectBranchModelList[index].cLSNAME.toString()}";
                        }),
                        initialItem: "${_selectBranchModelList[0].cLSNAME.toString()}",
                        onChanged: (value) {
                          setState(() {
                            selectedBranchValue = _selectBranchModelList
                                .firstWhere((branch) => branch.cLSNAME == value).cLSCODE; // Assuming id is the property storing the ID

                            print("code --->${selectedBranchValue}");
                          });
                        },
                      ),

                      SizedBox(height: 20,),



                      TextFormField(
                          controller: _queryController,
                          maxLines: 1,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          decoration: _MobiletextFieldDecoration(
                              label:
                              "Query")
                      ),

                      SizedBox(height: 20,),

                      _sbmitBtn()
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(radius: 35,
                child: Icon(Icons.question_mark,color: Colors.white,size: 35),
              ),
            ),
          ],
        )
      ],
    );
  }

  InputDecoration _MobiletextFieldDecoration({String? label}) {
    return InputDecoration(
      hintText: "Enter Query",
      suffixIcon: Icon(Icons.messenger,),
      counter: const Offstage(),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:
          BorderSide(width: 2.0, color: Colors.grey.withOpacity(0.1))),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:
          BorderSide(width: 2.0, color: Colors.grey.withOpacity(0.1))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:
          BorderSide(width: 2.0, color: Colors.grey.withOpacity(0.1))),
      contentPadding: const EdgeInsets.all(15.0),
      filled: true,
      fillColor: Colors.grey.withOpacity(0.1),
      labelText: "$label",
      alignLabelWithHint: true,
      labelStyle: const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w400,
      ),
    );
  }



  Widget _sbmitBtn(){
    return InkWell(
      onTap: () {
        if(_queryController.text.isEmpty){
          Utils().themetoast("Please Enter Your Query");
        }else{
          _submitAPi("${selectedBranchValue}",_queryController.text.toString());
        }
      },
      child: Container(
        width: width*1,
        height: 45,
        decoration: BoxDecoration(
          color: kThemeColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child:
        submitLoading?
        Center(child:  SizedBox(width: 30,height: 30,child: CircularProgressIndicator(color: Colors.white,)),)
            :
        Center(child: Text("Submit",style: Palette.whiteBtnTxt,)),
      ),
    );
  }

  var schoolCode;
  var token;
  var userID;



  Future<void> _submitAPi(branchId, query) async {



    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      schoolCode = pref.getString('schoolCode');
      token = pref.getString('token');
      userID = pref.getString('userId');
      submitLoading = true;
      print("--->$token");
    });


    try{
      final params = {
        'schoolCode': '$schoolCode',
      };

      final uri = Uri.parse(ApiConstant.POST_QUERY).replace(queryParameters: params);


      final response = await http.post(
        uri,
        headers: {
          'apikey': ApiConstant.API_KEY,
          'Content-Type': 'application/json',
          'token' : token
        },
        body: json.encode({
          'branchId' : '${branchId}',
          'typeName' : "Teacher",
          'fromId' : userID.toString(),
          'details' : query.toString(),
        }),
      );

      print('Request Fields:');
      print('branchId: $branchId');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body)['data'];
        print("-->response $responseData");
        if(json.decode(response.body)['success'] == true){
          Get.back();
          SuccessDialouge.showErrorDialogue(context, "${responseData[0]['msg']}");
        }
      }
    } catch (e) {
      Utils().themetoast(e.toString());
    } finally {
      setState(() {
        submitLoading = false;
      });
    }
  }




  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }
}
