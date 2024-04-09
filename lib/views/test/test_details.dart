import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:pns_skolar/views/test/fill_students_marks.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/course/class_select_model.dart';
import '../../model/course/semester_select_model.dart';
import '../../model/course/subject_details_model.dart';
import '../../model/test/get_exam_type.dart';
import '../../repo/Course/select_class_repo.dart';
import '../../repo/Course/subject_info_repo.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/api_constant.dart';
import '../../widget/error_dialouge.dart';
import '../../widget/loading_dialogue.dart';

class TestDetails extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return TestDetails_State();
  }
}

class TestDetails_State extends State<TestDetails>{

  var width = Get.width;
  var height = Get.height;

  String _selectedDate = '';

  TextEditingController _testDateController = TextEditingController();

  String? selectedTypeValue;
  List<Data> data = [];

  List<SubjectData> _selectSubModelList = [];
  String? selectedSubValue;

  List<SemesterSelectDataModel> _selectSemesterModelList = [];
  int? selectedSemValue;

  List<ClassSelectDataModel> _selectClassModelList = [];
  int? selectedValue;

  bool loading = false;
  var schoolCode;
  var token;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getExamType();
    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(currentDate);
    String formattedDate2 = DateFormat('MM/dd/yyyy').format(currentDate);
    _testDateController.text = formattedDate;
    _selectedDate = formattedDate2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Test Details',
          style: Palette.appbarTitle,
        ),
        flexibleSpace: Container(
          decoration: Palette.appbarGradient,
        ),
      ),
      body: SizedBox(
        height: height*1,
        child: Column(
           children: [

             Expanded(
               child: SingleChildScrollView(
                 child: Column(
                   children: [
                     selectDatePicker(),
                     _selectExamType(),
                     _selectSubWidget(),
                     _selectSemesterWidget(),
                     _selectBranchWidget()
                   ],
                 ),
               ),
             ),

             _subMit()
           ],
        ),
      ),
    );
  }

  Widget _selectSubWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 5),
          child: Text('Subject :', style: Palette.title),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          width: MediaQuery.of(context).size.width,
          child: Wrap(
            children: List.generate(_selectSubModelList.length, (i) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedSubValue =
                        _selectSubModelList[i].subjectId.toString();
                  });
                },
                child: Card(
                  elevation: 0,
                  shape: Palette.cardShape,
                  color:selectedSubValue ==
                      _selectSubModelList[i].subjectId.toString()
                      ? Colors.indigo
                      : Colors.indigo.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${_selectSubModelList[i].subjectName}',
                          style: selectedSubValue ==
                              _selectSubModelList[i].subjectId.toString()
                              ?TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0,
                            color: Colors.white,
                          )
                              :  TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0,
                          ),
                        ),

                        SizedBox(width: 10,),


                        Container(
                          height: 20,width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 1.5,color: Colors.white)
                          ),
                          child: Center(child: Icon(
                            Icons.circle,size: 13,color:
                          selectedSubValue ==
                              _selectSubModelList[i].subjectId.toString()
                              ?
                          Colors.white
                              :
                          Colors.transparent,
                          )
                          ),
                        )
                      ],
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
                    padding: const EdgeInsets.fromLTRB(13, 12, 12, 13),
                    child: SizedBox(
                      height: 18,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Wrap(
                            children: [
                              Text(
                                  '${semName[0]}',
                                style: selectedSemValue ==
                                    _selectSemesterModelList[i].sEMECODE
                                    ? Palette.titlez
                                    : Palette.title
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

                          SizedBox(width: 40,),

                          Container(
                            height: 20,width: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(width: 1.5,color: Colors.white)
                            ),
                            child: Center(child: Icon(
                              Icons.circle,size: 13,color:
                            selectedSemValue ==
                                _selectSemesterModelList[i].sEMECODE ?
                            Colors.white
                                :
                            Colors.transparent,
                            )
                            ),
                          )
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


  Widget _selectExamType(){
    return
       Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 10, 25, 5),
            child: Text('Exam :', style: Palette.title),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            width: MediaQuery.of(context).size.width,
            child: Wrap(
              children: List.generate(data.length, (index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedTypeValue =
                          data[index].examTypeId.toString();
                    });
                  },
                  child: Card(
                    elevation: 0,
                    clipBehavior: Clip.hardEdge,
                    shape: Palette.cardShape,
                    color: selectedTypeValue ==
                        data[index].examTypeId.toString()
                        ? Colors.pink
                        : Colors.pink.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${data[index].examTypeName}',
                            style: selectedTypeValue ==
                                data[index].examTypeId.toString()
                                ? Palette.titleWhiteS
                                : Palette.titleS,
                          ),

                          SizedBox(width: 60,),

                          Container(
                            height: 23,width: 23,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(width: 1.5,color: Colors.white)
                            ),
                            child: Center(child: Icon(
                              Icons.circle,size: 18,color:
                           selectedTypeValue ==
                                data[index].examTypeId.toString() ?
                            Colors.white
                                :
                            Colors.transparent,
                            )
                            ),
                          )

                        ],
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

  Widget selectDatePicker() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Center(
        child: TextField(
          controller: _testDateController,
          decoration: etBoxDecoration('Test Date'),
          readOnly: true,
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
              DateFormat('dd/MM/yyyy').format(pickedDate);
              String formattedDate2 =
              DateFormat('MM/dd/yyyy').format(pickedDate);
              //print(formattedDate);
              _selectedDate = formattedDate2;
              setState(() {
                _testDateController.text = formattedDate;
              });
            } else {
              print("Date is not selected");
            }
          },
        ),
      ),
    );
  }
  Widget _subMit() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 15, 20, 30),
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FillMarks(
                cLS_CODE: selectedValue.toString(),
                sEME_CODE: selectedSemValue.toString(),
                sUBID: selectedSubValue ?? '',
                examTypeId: selectedTypeValue.toString(),
                markEntityDate: _testDateController.text.toString(),
              ),
            ),
          );
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
          'SEARCH TEST',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }



  InputDecoration etBoxDecoration(String label) {
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
      contentPadding: const EdgeInsets.all(15.0),
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey),
    );
  }

  Widget _selectBranchWidget() {
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
                  color:
                  selectedValue == _selectClassModelList[i].cLSCODE
                      ? Colors.green
                      : Colors.green.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(13, 12, 12, 13),
                    child: SizedBox(
                      height: 18,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              '${_selectClassModelList[i].cLSNAME}',
                              style: selectedValue ==
                                  _selectClassModelList[i].cLSCODE
                                  ? TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13.0,
                                color: Colors.white,
                              )
                                  : TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13.0,
                              )
                          ),

                          SizedBox(width: 20,),

                          Container(
                            height: 20,width: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(width: 1.5,color: Colors.white)
                            ),
                            child: Center(child: Icon(
                              Icons.circle,size: 13,color:
                            selectedValue ==
                                _selectClassModelList[i].cLSCODE ?
                            Colors.white
                                :
                            Colors.transparent,
                            )
                            ),
                          )
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

  Widget _selectClass2Widget() {
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
          child: Row(
            children: [
              Wrap(
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
                          ? Colors.green
                          : Colors.green.withOpacity(0.1),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${_selectClassModelList[i].cLSNAME}',
                              style: selectedValue == _selectClassModelList[i].cLSCODE
                                  ? Palette.titleWhiteS
                                  : Palette.titleS,
                            ),

                            SizedBox(width: 20,),

                            Container(
                              height: 20,width: 20,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(width: 1.5,color: Colors.white)
                              ),
                              child: Center(child: Icon(
                                Icons.circle,size: 13,color:
                              selectedValue == _selectClassModelList[i].cLSCODE ?
                              Colors.white
                                  :
                              Colors.transparent,
                              )
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),

            ],
          ),
        ),
      ],
    );
  }






  Future<void> getExamType() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      schoolCode = pref.getString('schoolCode');
      token = pref.getString('token');
      loading = true;
      print("--->$token");
    });

    final params = {
      'schoolCode': '$schoolCode',
    };

    final uri = Uri.parse(ApiConstant.GET_EXAMTYPE)
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
      try {
        final getExamTypeModel _examtype =
        getExamTypeModel.fromJson(json.decode(response.body));

        setState(() {
          data = _examtype.data ?? [];
          selectedTypeValue = data[0].examTypeId.toString();
          selectSubjectApi();
        });
      } catch (e) {
        ErrorDialouge.showErrorDialogue(
            context, "Something is Wrong please try again later");
        print('Error decoding JSON: $e');
      } finally {
        setState(() {
          loading = false;
        });
      }
    } else {
      print(
          'Error: ${response.reasonPhrase}, Status Code: ${response.statusCode}');
    }
  }

  Future<void> selectSubjectApi() async {
    LoadingDialog.showLoadingDialog(context);
    SubjectRepo selectClassRepo = SubjectRepo();
    try {
      SubjectDetailsModel data = await selectClassRepo.fetchData();

      if (data.success!) {
        // Navigator.pop(context);
        setState(() {
          _selectSubModelList = data.data!;
          if (_selectSubModelList.isNotEmpty) {
            selectedSubValue = _selectSubModelList[0].subjectId.toString();
          }
        });
        selectSemesterApi();
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      Navigator.pop(context);
      print('Exeption $e');
    }
  }

  Future<void> selectSemesterApi() async {
    //LoadingDialog.showLoadingDialog(context);
    SelectClassRepo selectClassRepo = SelectClassRepo();
    try {
      SemesterSelectModel data = await selectClassRepo.fetchSemData();

      if (data.success!) {
        // Navigator.pop(context);
        setState(() {
          _selectSemesterModelList = data.data!;
          if (_selectSemesterModelList.isNotEmpty) {
            selectedSemValue = _selectSemesterModelList[0].sEMECODE;
          }
        });
        selectClassApi();
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      print('Exeption $e');
      print('$selectedSemValue');
    }
  }

  Future<void> selectClassApi() async {
    //LoadingDialog.showLoadingDialog(context);
    SelectClassRepo selectClassRepo = SelectClassRepo();
    try {
      ClassSelectModel data = await selectClassRepo.fetchData();

      if (data.success!) {
        Navigator.pop(context);
        setState(() {
          _selectClassModelList = data.data!;
          if (_selectClassModelList.isNotEmpty) {
            selectedValue = _selectClassModelList[0].cLSCODE;
          }
        });
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      Navigator.pop(context);
      print('Exeption $e');
      print('$selectedValue');
    }
  }


  // void _searchApi() async {
  //   LoadingDialog.showLoadingDialog(context);
  //
  //   try {
  //     StudentAttendanceModel data = await studentAttendanceRepo.fetchData(
  //       cLS_CODE: selectedValue.toString(),
  //       sEME_CODE: selectedSemValue.toString(),
  //     );
  //     if (data.success!) {
  //       Navigator.pop(context);
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => StudentList(
  //             cLS_CODE: selectedValue.toString(),
  //             sEME_CODE: selectedSemValue.toString(),
  //             attendanceDate: _selectedDate,
  //             attendanceTime: _selectedClassStartTime.classStartTime.toString(),
  //             sUBID: selectedSubValue ?? '',
  //           ),
  //         ),
  //       );
  //     } else {
  //       Navigator.pop(context);
  //       ErrorDialouge.showErrorDialogue(context, data.message!);
  //     }
  //   } catch (e) {
  //     Navigator.pop(context);
  //     ErrorDialouge.showErrorDialogue(context, e.toString());
  //   }
  // }








}