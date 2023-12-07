import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pns_skolar/model/class_time_model.dart';
import 'package:pns_skolar/model/course/semester_select_model.dart';
import 'package:pns_skolar/repo/Course/select_class_repo.dart';
import 'package:pns_skolar/views/attendance/student_list.dart';

import '../../model/attendance/student_attnc_detail_model.dart';
import '../../model/course/class_select_model.dart';
import '../../model/course/subject_details_model.dart';
import '../../repo/Course/subject_info_repo.dart';
import '../../repo/attendance/student_attendance_dtl_repo.dart';
import '../../repo/class_time_repo.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../widget/error_dialouge.dart';
import '../../widget/loading_dialogue.dart';

class AttendanceDetails extends StatefulWidget {
  const AttendanceDetails({super.key});

  @override
  State<AttendanceDetails> createState() => _AttendanceDetailsState();
}

class _AttendanceDetailsState extends State<AttendanceDetails> {
  List<SubjectData> _selectSubModelList = [];
  String? selectedSubValue;

  List<ClassSelectDataModel> _selectClassModelList = [];
  int? selectedValue;

  List<SemesterSelectDataModel> _selectSemesterModelList = [];
  int? selectedSemValue;

  List<StartTimeData> _classStartTimeList = [];
  StartTimeData _selectedClassStartTime = StartTimeData();

  TextEditingController attendanceDateController = TextEditingController();
  String _selectedDate = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      selectSubjectApi();
    });

    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(currentDate);
    String formattedDate2 = DateFormat('MM/dd/yyyy').format(currentDate);
    attendanceDateController.text = formattedDate;
    _selectedDate = formattedDate2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student Details',
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    selectDatePicker(),
                    _selectSubWidget(),
                    _selectClassWidget(),
                    _selectSemesterWidget(),
                    _classStartTimeListWidget(),
                  ],
                ),
              ),
            ),
            _subMit(),
          ],
        ),
      ),
    );
  }

  Widget selectDatePicker() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Center(
        child: TextField(
          controller: attendanceDateController,
          decoration: etBoxDecoration('Attendance Date'),
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
                attendanceDateController.text = formattedDate;
              });
            } else {
              print("Date is not selected");
            }
          },
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
                  color: selectedSubValue ==
                          _selectSubModelList[i].subjectId.toString()
                      ? Colors.pink
                      : Colors.pink.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
                    child: Text(
                      '${_selectSubModelList[i].subjectName}',
                      style: selectedSubValue ==
                              _selectSubModelList[i].subjectId.toString()
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
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
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

  Widget _classStartTimeListWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 5),
          child: Text('Class Start Time :', style: Palette.title),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          width: MediaQuery.of(context).size.width,
          child: Wrap(
            children: List.generate(_classStartTimeList.length, (i) {
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedClassStartTime = _classStartTimeList[i];
                  });
                },
                child: Card(
                  elevation: 0,
                  shape: Palette.cardShape,
                  color: _selectedClassStartTime.classStartTime ==
                          _classStartTimeList[i].classStartTime
                      ? Colors.green
                      : Colors.green.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                    child: Text(
                      '${_classStartTimeList[i].classStartTime}',
                      style: _selectedClassStartTime.classStartTime ==
                              _classStartTimeList[i].classStartTime
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

  Widget _subMit() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 15, 20, 30),
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // if (nameController.text.isEmpty) {
          //   ErrorDialouge.showErrorDialogue(context, 'Enter Your Name');
          // } else if (mailController.text.isEmpty) {
          //   ErrorDialouge.showErrorDialogue(context, 'Enter Your Email');
          // } else if (mobileController.text.isEmpty) {
          //   ErrorDialouge.showErrorDialogue(context, 'Enter Mobile Number');
          // } else {
          _applicationApi();
          // }
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
          'SEARCH STUDENT',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // Widget _selectClassWidget() {
  //   return Container(
  //     width: MediaQuery.of(context).size.width,
  //     margin: const EdgeInsets.fromLTRB(20.0, 20, 20.0, 8),
  //     padding: const EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 2.0),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(7.0),
  //       border: Border.all(color: kThemeColor.withOpacity(0.1), width: 2.0),
  //     ),
  //     child: DropdownButton(
  //       isExpanded: true,
  //       underline: const SizedBox(),
  //       hint: const Text(
  //         'Select Class',
  //         style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
  //       ),
  //       value: selectedValue,
  //       onChanged: (int? newValue) {
  //         setState(() {
  //           selectedValue = newValue!;
  //         });
  //       },
  //       items: _selectClassModelList.map((val) {
  //         return DropdownMenuItem(
  //           value: val.cLSCODE,
  //           child: Text(val.cLSNAME!, style: Palette.title),
  //         );
  //       }).toList(),
  //     ),
  //   );
  // }

  // Widget _selectSemesterWidget() {
  //   return Container(
  //     width: MediaQuery.of(context).size.width,
  //     margin: const EdgeInsets.fromLTRB(20.0, 20, 20.0, 8),
  //     padding: const EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 2.0),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(7.0),
  //       border: Border.all(color: kThemeColor.withOpacity(0.1), width: 2.0),
  //     ),
  //     child: DropdownButton(
  //       isExpanded: true,
  //       underline: const SizedBox(),
  //       hint: const Text(
  //         'Select Semester',
  //         style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
  //       ),
  //       value: selectedSemValue,
  //       onChanged: (int? newValue) {
  //         setState(() {
  //           selectedSemValue = newValue!;
  //         });
  //       },
  //       items: _selectSemesterModelList.map((val) {
  //         return DropdownMenuItem(
  //           value: val.sEMECODE,
  //           child: Text(val.semesterName!, style: Palette.title),
  //         );
  //       }).toList(),
  //     ),
  //   );
  // }

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
        selectClassApi();
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      Navigator.pop(context);
      print('Exeption $e');
      print('$selectedValue');
    }
  }

  Future<void> selectClassApi() async {
    //LoadingDialog.showLoadingDialog(context);
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
        //Navigator.pop(context);
        setState(() {
          _selectSemesterModelList = data.data!;
          if (_selectSemesterModelList.isNotEmpty) {
            selectedSemValue = _selectSemesterModelList[0].sEMECODE;
          }
        });
        classStartTimeApi();
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      print('Exeption $e');
      print('$selectedSemValue');
    }
  }

  Future<void> classStartTimeApi() async {
    //LoadingDialog.showLoadingDialog(context);
    ClassStartTimeRepo classStartTimeRepo = ClassStartTimeRepo();
    try {
      ClassStartTimeModel data = await classStartTimeRepo.fetchData();

      if (data.success!) {
        Navigator.pop(context);
        setState(() {
          _classStartTimeList = data.data ?? [];
          if (_classStartTimeList.isNotEmpty) {
            _selectedClassStartTime = _classStartTimeList[0];
          }
        });
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      print('Exeption $e');
    }
  }

  void _applicationApi() async {
    LoadingDialog.showLoadingDialog(context);
    StudentAttendanceRepo studentAttendanceRepo = StudentAttendanceRepo();

    try {
      StudentAttendanceModel data = await studentAttendanceRepo.fetchData(
        cLS_CODE: selectedValue.toString(),
        sEME_CODE: selectedSemValue.toString(),
      );
      if (data.success!) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StudentList(
              cLS_CODE: selectedValue.toString(),
              sEME_CODE: selectedSemValue.toString(),
              attendanceDate: _selectedDate,
              attendanceTime: _selectedClassStartTime.classStartTime.toString(),
              sUBID: selectedSubValue ?? '',
            ),
          ),
        );
      } else {
        Navigator.pop(context);
        ErrorDialouge.showErrorDialogue(context, data.message!);
      }
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(context, e.toString());
    }
  }
}
