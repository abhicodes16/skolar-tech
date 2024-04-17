import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../model/course/class_select_model.dart';
import '../../model/course/semester_select_model.dart';
import '../../repo/Course/select_class_repo.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/api_constant.dart';
import '../../widget/error_dialouge.dart';
import '../../widget/loading_dialogue.dart';
import '../../widget/success_home_dialog.dart';
import 'package:http_parser/http_parser.dart';


class UploadHomework extends StatefulWidget{

  final String subCode;
  const UploadHomework({super.key, required this.subCode});

  @override
  State<StatefulWidget> createState() {
    return UploadHomework_State();
  }
}

class UploadHomework_State extends State<UploadHomework>{

  List<ClassSelectDataModel> _selectClassModelList = [];
  int? selectedValue;


  List<SemesterSelectDataModel> _selectSemesterModelList = [];
  int? selectedSemValue;


  String? selectedFilePath;
  String? selectedFileName;


  TextEditingController questionTitleCnt = TextEditingController();

  TextEditingController assignDtlsCnt = TextEditingController();

  TextEditingController givenDateCnt = TextEditingController();
  TextEditingController dueDateCnt = TextEditingController();


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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      selectClassApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upload Homework',
          style: Palette.appbarTitle,
        ),
        flexibleSpace: Container(decoration: Palette.appbarGradient),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _selectClassWidget(),
                    _selectSemesterWidget(),
                    _questionTitle(),
                    _assgDetails(),
                    selectDatePicker(),
                    _atteachedImgWidget(),
                  ],
                ),
              ),
            ),
            _submitBtn(),
          ],
        ),
      ),
    );
  }

  Widget _atteachedImgWidget() {
    return Card(
      shape: Palette.cardShape,
      margin: const EdgeInsets.fromLTRB(25, 15, 25, 15),
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


  Widget _selectClassWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 5),
          child: Text('Branch :', style: Palette.title),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          width: MediaQuery.of(context).size.width,
          child: Wrap(
            children: List.generate(_selectClassModelList.length, (i) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedValue = _selectClassModelList[i].cLSCODE;
                  });
                },
                child: Card(
                  elevation: 0,
                  shape: Palette.cardShape,
                  color: selectedValue == _selectClassModelList[i].cLSCODE
                      ? Colors.indigo
                      : Colors.indigo.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
                    child: Text(
                      '${_selectClassModelList[i].cLSNAME}',
                      style: selectedValue == _selectClassModelList[i].cLSCODE
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

  Widget _selectSemesterWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 5),
          child: Text('Semester :', style: Palette.title),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          width: MediaQuery.of(context).size.width,
          child: Wrap(
            children: List.generate(_selectSemesterModelList.length, (i) {
              String semName =
                  _selectSemesterModelList[i].semesterName ?? '???';

              return InkWell(
                onTap: () {
                  setState(() {
                    selectedSemValue = _selectSemesterModelList[i].sEMECODE;
                  });
                },
                child: Card(
                  elevation: 0,
                  shape: Palette.cardShape,
                  color:
                  selectedSemValue == _selectSemesterModelList[i].sEMECODE
                      ? Colors.amber[700]
                      : Colors.amber.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                    child: SizedBox(
                      height: 18,
                      child: Wrap(
                        children: [
                          Text(
                            '${semName[0]}',
                            style: selectedSemValue ==
                                _selectSemesterModelList[i].sEMECODE
                                ? Palette.titlez
                                : Palette.title,
                          ),
                          const SizedBox(width: 1),
                          Text(
                            '${semName[1]}${semName[2]}',
                            style: selectedSemValue ==
                                _selectSemesterModelList[i].sEMECODE
                                ? const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10.0,
                              color: Colors.white,
                            )
                                : const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10.0,
                            ),
                          ),
                        ],
                      ),
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

  Widget _questionTitle() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: questionTitleCnt,
              keyboardType: TextInputType.name,
              style: const TextStyle(
                fontFamily: kThemeFont,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              decoration: _textFieldDecoration(label: 'Question Title'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _assgDetails() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: assignDtlsCnt,
              keyboardType: TextInputType.name,
              style: const TextStyle(
                fontFamily: kThemeFont,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              decoration: _textFieldDecoration(label: 'Assignment Details'),
            ),
          ),
        ],
      ),
    );
  }

  Widget selectDatePicker() {
    return Row(
      children: [

        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 20,0, 8),
            child: Center(
              child: TextField(
                controller: givenDateCnt,
                decoration: etBoxDecoration('Given Date'),
                readOnly: true,
                style: TextStyle(
                    color: Colors.black
                ),
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
                      givenDateCnt.text = formattedDate;
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
            ),
          ),
        ),

        SizedBox(
          width: 20,
        ),


        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 20,20, 8),
            child: Center(
              child: TextField(
                controller: dueDateCnt,
                decoration: etBoxDecoration('Due Date'),
                readOnly: true,
                style: TextStyle(
                    color: Colors.black
                ),
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
                      dueDateCnt.text = formattedDate;
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
            ),
          ),
        )

      ],
    );
  }


  InputDecoration etBoxDecoration(String label) {
    return InputDecoration(
      fillColor: white,
      filled: true,
      suffixIcon: Icon(Icons.calendar_month,color: Colors.grey,size: 17),
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




  Future<void> _uploadFile() async {
    LoadingDialog.showLoadingDialog(context);
    SharedPreferences pref = await SharedPreferences.getInstance();

    String schoolCode = pref.getString('schoolCode') ?? '';
    final params = {
      'schoolCode': '$schoolCode',
    };

    var request = http.MultipartRequest("POST",
        Uri.parse('${ApiConstant.UPLOAD_HOMEWORK}').replace(queryParameters: params));

    request.headers['token'] = pref.getString('token')!;
    request.headers['apikey'] = ApiConstant.API_KEY;
    request.headers['Content-Type'] = 'multipart/form-data';

    request.fields['branchId'] = selectedValue.toString();
    request.fields['semesterId'] = selectedSemValue.toString();
    request.fields['subjectId'] = widget.subCode.toString();
    request.fields['title'] = questionTitleCnt.text;
    request.fields['assignDtls'] = assignDtlsCnt.text;
    request.fields['givenDate'] = givenDateCnt.text;
    request.fields['dueDate'] = dueDateCnt.text;


    if (selectedFilePath == null) {
      selectedFilePath = null;
    } else {
      var uploadFile = await http.MultipartFile.fromPath(
        "ass_Doc",
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


  Widget _submitBtn() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 15, 20, 30),
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (questionTitleCnt.text.isEmpty) {
            ErrorDialouge.showErrorDialogue(
                context, 'Please enter questions title');
          }else if (assignDtlsCnt.text.isEmpty) {
            ErrorDialouge.showErrorDialogue(
                context, 'Please enter Assignment Details');
          }else if (givenDateCnt.text.isEmpty) {
            ErrorDialouge.showErrorDialogue(
                context, 'Please select given date');
          }else if (assignDtlsCnt.text.isEmpty) {
            ErrorDialouge.showErrorDialogue(
                context, 'Please select due date');
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




  Future<void> selectClassApi() async {
    LoadingDialog.showLoadingDialog(context);
    SelectClassRepo selectClassRepo = SelectClassRepo();
    try {
      ClassSelectModel data = await selectClassRepo.fetchData();

      if (data.success!) {
        // Navigator.pop(context);
        setState(() {
          _selectClassModelList = data.data!;
          if (_selectClassModelList.isNotEmpty) {
            selectedValue = _selectClassModelList[0].cLSCODE;
          }
        });
        selectSemesterApi();
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      Navigator.pop(context);
      print('Exeption $e');
      print('$selectedValue');
    }
  }

  Future<void> selectSemesterApi() async {
    //LoadingDialog.showLoadingDialog(context);
    SelectClassRepo selectClassRepo = SelectClassRepo();
    try {
      SemesterSelectModel data = await selectClassRepo.fetchSemData();

      if (data.success!) {
        Navigator.pop(context);
        setState(() {
          _selectSemesterModelList = data.data!;
          if (_selectSemesterModelList.isNotEmpty) {
            selectedSemValue = _selectSemesterModelList[0].sEMECODE;
          }
        });
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      print('Exeption $e');
      print('$selectedSemValue');
    }
  }


}