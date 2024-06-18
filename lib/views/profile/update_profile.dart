import 'dart:convert';
import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:pns_skolar/widget/error_dialouge.dart';
import 'package:pns_skolar/widget/success_dialouge.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/profile/department_model.dart';
import '../../model/profile/designation_model.dart';
import '../../style/assets_constants.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/api_constant.dart';
import '../../widget/loading_dialogue.dart';
import '../../widget/success_home_dialog.dart';

class UpdateProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UpdateProfile_State();
  }
}

class UpdateProfile_State extends State<UpdateProfile> {
  var width = Get.width;
  var heigth = Get.height;

  TextEditingController eMPNAME = TextEditingController();
  TextEditingController eMPPHTURL = TextEditingController();
  TextEditingController eMPDEPTCODE = TextEditingController();
  TextEditingController eMPMAILID = TextEditingController();
  TextEditingController eMPMOB = TextEditingController();
  TextEditingController eMPDOB = TextEditingController();
  TextEditingController eMPDOJ = TextEditingController();
  TextEditingController eMPGNDR = TextEditingController();
  TextEditingController eMPCODE = TextEditingController();
  TextEditingController eMPADHNO = TextEditingController();
  TextEditingController eMPPANNO = TextEditingController();
  TextEditingController eMPFTHNM = TextEditingController();
  TextEditingController eMPADRSPRMN = TextEditingController();
  TextEditingController eMPADRSPRSN = TextEditingController();
  TextEditingController eMPDESGCODE = TextEditingController();
  TextEditingController eMPTYPCODE = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final argument = Get.arguments;
    setState(() {
      eMPNAME.text = argument["eMPNAME"];
      eMPPHTURL.text = argument["eMPPHTURL"];
      eMPDEPTCODE.text = argument["eMPDEPTCODE"];
      eMPMAILID.text = argument["eMPMAILID"];
      eMPMOB.text = argument["eMPMOB"];
      eMPDOB.text = argument["eMPDOB"];
      eMPDOJ.text = argument["eMPDOJ"];
      eMPGNDR.text = argument["eMPGNDR"];
      eMPCODE.text = argument["eMPCODE"];
      eMPADHNO.text = argument["eMPADHNO"];
      eMPPANNO.text = argument["eMPPANNO"];
      eMPFTHNM.text = argument["eMPFTHNM"];
      eMPADRSPRMN.text = argument["eMPADRSPRMN"];
      eMPADRSPRSN.text = argument["eMPADRSPRSN"];
      eMPDESGCODE.text = argument["eMPDESGCODE"];
      eMPTYPCODE.text = argument["eMPTYPCODE"];
    });
    getDesigantions();
  }

  var selectedDesgCode ;
  var selectedDepartmentCode ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Profile',
          style: Palette.appbarTitle,
        ),
        flexibleSpace: Container(
          decoration: Palette.appbarGradient,
        ),
      ),
      body:
      designationLoading
          ? Center(child: SizedBox(width: 30,height: 30,child: CircularProgressIndicator(),))
          :
      Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              InkWell(
                onTap: () {
                  _openImagePicker();
                },
                child: Container(
                  height: 150,
                  width: 150,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kThemeColor.withOpacity(0.1)),
                  child: eMPPHTURL.text.toString()  != "null" && _imgFilePath == null ? Image(image: NetworkImage(eMPPHTURL.text)) :  _imgFilePath == null ? Image.asset(Assets.profile) : Image.file(_image!, fit: BoxFit.contain),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.black,
                  child:
                      Icon(CupertinoIcons.pen, color: Colors.white, size: 20),
                ),
              )
            ],
          ),

          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(bottom: 20, top: 20),
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                _textField(eMPNAME, "Employee Name"),
                _textField(eMPFTHNM, "Father's Name"),
                _dobTextfield(),
                _textField(eMPMOB, "Mobile Number"),
                _textField(eMPMAILID, "Mail ID"),
                _genderSelect(),
                designationLoading ?
                SizedBox()
                    :
                Padding(
                        padding: const EdgeInsets.fromLTRB(18, 0, 18, 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text("Designation Type",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Card(
                              elevation: 2,
                              child: CustomDropdown<String>(
                                decoration: CustomDropdownDecoration(
                                    expandedFillColor: Colors.white,
                                    closedFillColor: Colors.white),
                                hintText: 'Select Month',
                                items: List.generate(designationData.length,
                                    (index) {
                                  return "${designationData[index].desgName.toString()}";
                                }),
                                initialItem:
                                    "${designationData[0].desgName.toString()}",
                                onChanged: (value) {
                                  setState(() {
                                    selectedDesgCode = designationData.firstWhere((branch) => branch.desgName == value).desgId.toString(); // Assuming id is the property storing the ID
                                    eMPDESGCODE.text = value; // Assuming id is the property storing the ID
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                departmentLoading ?
                SizedBox()
                    :
                Padding(
                        padding: const EdgeInsets.fromLTRB(18, 0, 18, 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text("Department Name",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Card(
                              elevation: 2,
                              child: CustomDropdown<String>(
                                decoration: CustomDropdownDecoration(
                                    expandedFillColor: Colors.white,
                                    closedFillColor: Colors.white),
                                hintText: 'Select Month',
                                items: List.generate(departmentData.length,
                                    (index) {
                                  return "${departmentData[index].deptName}";
                                }),
                                initialItem:
                                    "${departmentData[0].deptName.toString()}",
                                onChanged: (value) {
                                  setState(() {
                                    selectedDepartmentCode = departmentData.firstWhere((branch) => branch.deptName == value).deptId.toString(); // Assuming id is the property storing the ID
                                    eMPDEPTCODE.text = value; // Assuming id is the property storing the ID
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                _textField(eMPDOJ, "Date Of Joining"),
                _textField(eMPADHNO, "Aadhaar No"),
                _textField(eMPPANNO, "PAN No"),
                _textField(eMPTYPCODE, "Employee Type"),
                _textField(eMPADRSPRSN, "Address"),
                _textField(eMPADRSPRMN, "Parmanent Address"),
              ],
            ),
          ),

          InkWell(
            onTap: () {
              _update();
            },
            child: Container(
              width: width,
              height: 50,
              margin: EdgeInsets.only(right: 15, left: 15),
              decoration: BoxDecoration(
                  color: kThemeColor,
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                  child: Text(
                    "Update",
                    style: Palette.whiteBtnTxt,
                  )),
            ),
          ),

          SizedBox(
            height: 20,
          ),

        ],
      ),
    );
  }

  final _picker = ImagePicker();

  File? _image;
  String? _imgFilePath;
  String? documentImg;

  Future<void> _openImagePicker() async {
    XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        _imgFilePath = pickedImage.path;
      });
    }
  }

  Future<void> _update() async {
    LoadingDialog.showLoadingDialog(context);
    SharedPreferences pref = await SharedPreferences.getInstance();

    String schoolCode = pref.getString('schoolCode') ?? '';
    final params = {
      'schoolCode': '$schoolCode',
    };

    var request = http.MultipartRequest("POST",
        Uri.parse('${ApiConstant.UPDATE_PRPOFILE}').replace(queryParameters: params));

    request.headers['token'] = pref.getString('token')!;
    request.headers['apikey'] = ApiConstant.API_KEY;
    request.headers['Content-Type'] = 'multipart/form-data';

    request.fields['EMP_NAME'] = eMPNAME.text.toString();
    request.fields['EMP_DOB'] = eMPDOB.text.toString();
    request.fields['EMP_MOB'] = eMPMOB.text.toString();
    request.fields['EMP_MAIL_ID'] = eMPMAILID.text.toString();
    request.fields['EMP_GNDR'] = eMPGNDR.text.toString();
    request.fields['EMP_DOJ'] = eMPDOB.text.toString();
    request.fields['EMP_DESG_CODE'] = selectedDesgCode.toString();
    request.fields['EMP_QUAL'] = "";
    request.fields['EMP_ADH_NO'] = eMPADHNO.text.toString();
    request.fields['EMP_PAN_NO'] = eMPPANNO.text.toString();
    request.fields['EMP_FTH_NM'] = eMPFTHNM.text.toString();
    request.fields['EMP_TYP_CODE'] = eMPTYPCODE.text.toString();
    request.fields['EMP_TYP_CODE'] = eMPTYPCODE.text.toString();
    request.fields['EMP_DEPT_CODE'] = selectedDepartmentCode.toString();
    request.fields['EMP_ADRS_PRSN'] = eMPADRSPRSN.toString();
    request.fields['EMP_ADRS_PRMN'] = eMPADRSPRMN.toString();

    if (_imgFilePath != null) {
      var logoImage = await http.MultipartFile.fromPath("EMP_PHT_URL", _imgFilePath!, contentType: MediaType('image', 'png'));
      request.files.add(logoImage);
    } else {
      request.fields['EMP_PHT_URL'] = eMPPHTURL.text;
    }

    print('Requested Fields:');
    print('Fields: ${request.fields}');
    print('File Details:');
    request.files.forEach((element) {
      print("field :::::: ${element.field}");
      print('File Name: ${element.filename}');
      print('Content Type: ${element.contentType}');
      print('Size: ${element.length}');
    });

    // Send JSON payload using POST request
    var response = await request.send();

    var responsed = await http.Response.fromStream(response);
    // Listen for response
    try {
      if (response.statusCode == 200) {
        var decode = json.decode(responsed.body);
        print("${json.decode(responsed.body)}");
        Navigator.pop(context);
        // Set response
        if (decode['success'] != null) {
          if (decode['success']) {
            SuccessDialouge.showErrorDialogue(context, decode['data'][0]['msg'].toString());
          } else {
            ErrorDialouge.showErrorDialogue(context, decode['message']);
          }
        }
      } else {
        // Handle non-200 status code
        print('Error: ${response.statusCode}');
        print('Response: ${responsed.body}');
        Navigator.pop(context);
      }
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(context, e.toString());
    }
  }


  bool designationLoading = false;
  bool qualificationLoading = false;
  bool departmentLoading = false;
  var schoolCode;
  var token;
  List designationData =<Data>  [];

  Future<void> getDesigantions() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      schoolCode = pref.getString('schoolCode');
      token = pref.getString('token');
      designationLoading = true;
      print("--->$token");
    });

    final params = {
      'schoolCode': '$schoolCode',
    };

    final uri = Uri.parse(ApiConstant.GET_DESIGNATIONS)
        .replace(queryParameters: params);

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'apikey': ApiConstant.API_KEY,
        'token': token
      },
    );
    try {
      if(response.statusCode == 200){
        final Designations_model data =
        Designations_model.fromJson(json.decode(response.body));

        setState(() {
          designationData = data.data ?? [];
          getDepartments();
        });
      }else{
        ErrorDialouge.showErrorDialogue(context, "Something Wrong");
      }
    } finally {
      setState(() {
        designationLoading = false;
      });
    }
  }

  List <DepartMentData> departmentData = [];

  Future<void> getDepartments() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      schoolCode = pref.getString('schoolCode');
      token = pref.getString('token');
      departmentLoading = true;
      print("--->$token");
    });

    final params = {
      'schoolCode': '$schoolCode',
    };

    final uri = Uri.parse(ApiConstant.GET_DEPARTMENTS)
        .replace(queryParameters: params);

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'apikey': ApiConstant.API_KEY,
        'token': token
      },
    );
    try {
      if(response.statusCode == 200){
        final Departments_model data =
        Departments_model.fromJson(json.decode(response.body));

        setState(() {
          departmentData = data.data ?? [];
        });
      }else{
        ErrorDialouge.showErrorDialogue(context, "Something Wrong");
      }
    } finally {
      setState(() {
        departmentLoading = false;
      });
    }
  }

  // List qualificationData =<Data>  [];
  //
  // Future<void> getqualification() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   setState(() {
  //     schoolCode = pref.getString('schoolCode');
  //     token = pref.getString('token');
  //     qualificationLoading = true;
  //     print("--->$token");
  //   });
  //
  //   final params = {
  //     'schoolCode': '$schoolCode',
  //   };
  //
  //   final uri = Uri.parse(ApiConstant.GET_DESIGNATIONS)
  //       .replace(queryParameters: params);
  //
  //   final response = await http.get(
  //     uri,
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'apikey': ApiConstant.API_KEY,
  //       'token': token
  //     },
  //   );
  //   try {
  //     final Designations_model questionHistory =
  //     Designations_model.fromJson(json.decode(response.body));
  //
  //     setState(() {
  //       qualificationData = questionHistory.data ?? [];
  //     });
  //   } finally {
  //     setState(() {
  //       qualificationLoading = false;
  //     });
  //   }
  // }

  Widget _genderSelect() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text("Gender",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500)),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      eMPGNDR.text = "Male";
                    });
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, left: 10, right: 10),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Male",
                          )),
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1),
                                shape: BoxShape.circle),
                            child: Center(
                              child: Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                    color:
                                        eMPGNDR.text.toString().toLowerCase() ==
                                                "male"
                                            ? kThemeColor
                                            : Colors.transparent,
                                    shape: BoxShape.circle),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      eMPGNDR.text = "Female";
                    });
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, left: 10, right: 10),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Female",
                          )),
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1),
                                shape: BoxShape.circle),
                            child: Center(
                              child: Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                    color:
                                        eMPGNDR.text.toString().toLowerCase() ==
                                                "female"
                                            ? kThemeColor
                                            : Colors.transparent,
                                    shape: BoxShape.circle),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }


  Widget _dobTextfield() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: kThemeColor,
                            onPrimary: kWhite,
                            onSurface: kThemeColor,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              primary: Colors.red,
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  print(pickedDate);
                  String formattedDate =
                      DateFormat('yyyy/MM/dd').format(pickedDate);
                  setState(() {
                    eMPDOB.text = formattedDate;
                  });
                } else {
                  print("Date is not selected");
                }
              },
              controller: eMPDOB,
              keyboardType: TextInputType.name,
              style: const TextStyle(
                fontFamily: kThemeFont,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              decoration: _textFieldDecoration(label: "Date Of Birth"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textField(TextEditingController controller, label) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.name,
              style: const TextStyle(
                fontFamily: kThemeFont,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              decoration: _textFieldDecoration(label: label),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _textFieldDecoration({String? label}) {
    return InputDecoration(
      fillColor: white,
      filled: true,
      counter: const Offstage(),
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
      contentPadding: const EdgeInsets.all(15.0),
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey),
    );
  }
}
