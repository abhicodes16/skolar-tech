import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../model/queries/emp_model.dart';
import '../../model/queries/get_department_name.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/api_constant.dart';
import '../../widget/error_dialouge.dart';
import '../../widget/loading_dialogue.dart';
import '../../widget/success_home_dialog.dart';
import 'package:http_parser/http_parser.dart';


class StudentPostQuery extends StatefulWidget {
  const StudentPostQuery({super.key});

  @override
  State<StudentPostQuery> createState() => _StudentPostQueryState();
}

class _StudentPostQueryState extends State<StudentPostQuery> {

  var height = Get.height;
  var width = Get.width;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDepartments();
  }

  TextEditingController _detailsCnt = TextEditingController();
  TextEditingController _titleCnt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Post Queries',
          style: Palette.appbarTitle,
        ),
        flexibleSpace: Container(decoration: Palette.appbarGradient),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [

                SizedBox(height: height*0.02,),

                _selectDepartmentWidget(),

                _selectEmpWidget(),

                _titleWidget(),

                _detailsWidget(),

                _atteachedImgWidget(),

              ],
            ),
          ),

          _submitBtn()
        ],
      ),
    );
  }

  Widget _submitBtn() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 15, 20, 30),
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (selectedDepartmentValue == null) {
            ErrorDialouge.showErrorDialogue(
                context, 'Select Department');
          }else if (selectedEmpValue == null) {
            ErrorDialouge.showErrorDialogue(
                context, 'Select Teacher');
          }else if (_titleCnt.text.isEmpty) {
            ErrorDialouge.showErrorDialogue(
                context, 'Please Enter Title');
          }else if (_detailsCnt.text.isEmpty) {
            ErrorDialouge.showErrorDialogue(
                context, 'Please Enter Query Details');
          }else if (selectedFilePath == null) {
            ErrorDialouge.showErrorDialogue(
                context, 'Please Atteched Document or File');
          } else {
            _uploadFile();
          }
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
          'Upload',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Future<void> _uploadFile() async {
    LoadingDialog.showLoadingDialog(context);
    SharedPreferences pref = await SharedPreferences.getInstance();

    String schoolCode = pref.getString('schoolCode') ?? '';
    final params = {
      'schoolCode': '$schoolCode',
    };

    var request = http.MultipartRequest("POST",
        Uri.parse('${ApiConstant.STUDENT_POST_QUERY}').replace(queryParameters: params));

    request.headers['token'] = pref.getString('token')!;
    request.headers['apikey'] = ApiConstant.API_KEY;
    request.headers['Content-Type'] = 'multipart/form-data';

    request.fields['teacherId'] = selectedEmpValue.toString();
    request.fields['queryTitle'] = _titleCnt.text.toString();
    request.fields['queryDetails'] = _detailsCnt.text.toString();



    if (selectedFilePath == null) {
      selectedFilePath = null;
    } else {
      var uploadFile = await http.MultipartFile.fromPath(
        "queryAttachment",
        selectedFilePath!,
        contentType: MediaType('application', 'pdf'),
      );
      request.files.add(uploadFile);
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
            SuccessHomeDialog.show(context, decode['data'][0]['msg'].toString());
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



  String? selectedFilePath;
  String? selectedFileName;

  Future<void> openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      setState(() {
        selectedFilePath = file.path!;
        selectedFileName = file.name;
      });
      //sendFileToApi(filePath: file.path!);
    } else {
      // User canceled the picker
    }
  }

  Widget _atteachedImgWidget() {
    return Card(
      shape: Palette.cardShape,
      margin: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      elevation: 0,
      color: kThemeColor.withOpacity(0.1),
      child: InkWell(
        onTap: openFilePicker,
        child: SizedBox(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.attach_file, color: Colors.grey),
                    selectedFileName != null
                        ? Container(
                      width: Get.width*0.8,
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        '  $selectedFileName',
                        style: Palette.title,
                      ),
                    )
                        : Text(
                      '  Attech PDF / Documents',

                      style: Palette.subTitleGrey,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailsWidget(){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 5),
          child: Align(
              alignment: Alignment.topLeft,
              child: Text('Enter Details :', style: Palette.title)),
        ),

        Padding(
          padding: const EdgeInsets.only(
              top: 10,left: 15,right: 15,bottom: 10
          ),
          child: TextFormField(
              controller: _detailsCnt,
              maxLines: 3,
              keyboardType: TextInputType.text,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              decoration: _textFieldDecoration(
                  label:
                  "Details")
          ),
        ),
      ],
    );
  }


  Widget _titleWidget(){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 5),
          child: Align(
              alignment: Alignment.topLeft,
              child: Text('Enter Title :', style: Palette.title)),
        ),

        Padding(
          padding: const EdgeInsets.only(
              top: 10,left: 15,right: 15,bottom: 10
          ),
          child: TextFormField(
              controller: _titleCnt,
              maxLines: 3,
              keyboardType: TextInputType.text,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              decoration: _textFieldDecoration(
                  label:
                  "Title")
          ),
        ),
      ],
    );
  }

  InputDecoration _textFieldDecoration({String? label}) {
    return InputDecoration(
      hintText: "Enter Reply",
      suffixIcon: const Icon(Icons.messenger,),
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


  Widget _selectEmpWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 5),
          child: Text('Teacher :', style: Palette.title),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          width: MediaQuery.of(context).size.width,
          child: Wrap(
            children: List.generate(empData.length, (i) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedEmpValue = empData[i].empId;
                  });
                },
                child: Card(
                  elevation: 0,
                  shape: Palette.cardShape,
                  color: selectedEmpValue == empData[i].empId
                      ? Colors.amber[700]
                      : Colors.amber.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
                    child: Text(
                      '${empData[i].empName}',
                      style: selectedEmpValue == empData[i].empId
                          ? Palette.titleWhiteS
                          : Palette.titleS,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }


  Widget _selectDepartmentWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 5),
          child: Text('Department :', style: Palette.title),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          width: MediaQuery.of(context).size.width,
          child: Wrap(
            children: List.generate(departmentData.length, (i) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedDepartmentValue = departmentData[i].departmentId;
                  });
                  getEmp();
                },
                child: Card(
                  elevation: 0,
                  shape: Palette.cardShape,
                  color: selectedDepartmentValue == departmentData[i].departmentId
                      ? Colors.indigo
                      : Colors.indigo.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
                    child: Text(
                      '${departmentData[i].departmentName}',
                      style: selectedDepartmentValue == departmentData[i].departmentId
                          ? Palette.titleWhiteS
                          : Palette.titleS,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }


  int? selectedDepartmentValue;
  int? selectedEmpValue;

  var schoolCode;
  var token;
  bool departmentLoading = false;
  var departmentData = <DepartmentData>[];

  Future<void> getDepartments() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      schoolCode = pref.getString('schoolCode');
      token = pref.getString('token');
      departmentLoading = true;
      print("--->$token");
      print("--->$schoolCode");
    });

    try{
      final params = {
        'schoolCode': '$schoolCode',
      };

      final uri = Uri.parse(ApiConstant.GET_DEPARTMENT_NAMES)
          .replace(queryParameters: params);

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'apikey': ApiConstant.API_KEY,
          'token': token
        },
      );

      if (response.statusCode == 200) {
        final DepartmentModel questionHistory =
        DepartmentModel.fromJson(json.decode(response.body));

        setState(() {
          departmentData = questionHistory.data ?? [];
          selectedDepartmentValue = questionHistory.data![0].departmentId;
        });
        getEmp();

      } else {
        ErrorDialouge.showErrorDialogue(context, "Something is Wrong please try again later");
        print('Error: ${response.reasonPhrase}, Status Code: ${response.statusCode}');
      }
    }catch (e) {
      ErrorDialouge.showErrorDialogue(
          context, "Something is Wrong please try again later");
      print('Error decoding JSON: $e');
    } finally {
      setState(() {
        departmentLoading = false;
      });
    }
  }



  bool empLoading = false;
  var empData = <EmpData>[];

  Future<void> getEmp() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      schoolCode = pref.getString('schoolCode');
      token = pref.getString('token');
      empLoading = true;
      print("--->$token");
      print("--->$schoolCode");
    });

    try{
      final params = {
        'schoolCode': '$schoolCode',
      };

      final uri = Uri.parse(ApiConstant.GET_EMP_NAMES)
          .replace(queryParameters: params);

      final response = await http.post(
          uri,
          headers: {
            'Content-Type': 'application/json',
            'apikey': ApiConstant.API_KEY,
            'token': token
          },
          body: jsonEncode({
            'departmentId' : selectedDepartmentValue.toString()
          })
      );

      if (response.statusCode == 200) {
        final EmpModel data =
        EmpModel.fromJson(json.decode(response.body));

        setState(() {
          empData = data.data ?? [];
          selectedEmpValue = data.data![0].empId;
        });

      } else {
        ErrorDialouge.showErrorDialogue(context, "Something is Wrong please try again later");
        print('Error: ${response.reasonPhrase}, Status Code: ${response.statusCode}');
      }
    }catch (e) {
      ErrorDialouge.showErrorDialogue(
          context, "Something is Wrong please try again later");
      print('Error decoding JSON: $e');
    } finally {
      setState(() {
        empLoading = false;
      });
    }
  }

}
