import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pns_skolar/model/course/branch_select_model.dart';

import '../../model/attendance/attendance_hdr_model.dart';
import '../../model/course/semester_select_model.dart';
import '../../model/course/subject_details_model.dart';
import '../../model/course/subject_select_model.dart';
import '../../repo/Course/select_class_repo.dart';
import '../../repo/attendance/student_attendance_dtl_repo.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../widget/error_dialouge.dart';
import '../../widget/loading_dialogue.dart';
import '../../widget/success_dialouge.dart';

class AttendanceHdr extends StatefulWidget {
  const AttendanceHdr({super.key});

  @override
  State<AttendanceHdr> createState() => _AttendanceHdrState();
}

class _AttendanceHdrState extends State<AttendanceHdr> {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  List<SemesterSelectDataModel> _selectSemesterModelList = [];
  int? selectedSemValue;
  List<BranchSelectDataModel> _selectBranchModelList = [];
  int? selectedBranchValue;
  List<SubjectSelectDataModel> _selectSubjectModelList = [];
  int? selectedSubjectValue;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      selectSemesterApi();
      selectBranchApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Attendance Header',
          style: Palette.appbarTitle,
        ),
        flexibleSpace: Container(
          decoration: Palette.appbarGradient,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _selectBranchWidget(),
            _selectSemesterWidget(),
            _selectSubjectWidget(),
            selectDatePicker(),
            _timeRow(),
            _subMit(),
          ],
        ),
      ),
    );
  }

  Widget _selectSemesterWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.fromLTRB(20.0, 20, 20.0, 8),
      padding: const EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(color: kThemeColor.withOpacity(0.1), width: 2.0),
      ),
      child: DropdownButton(
        isExpanded: true,
        underline: const SizedBox(),
        hint: const Text(
          'Select Semester',
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
        ),
        value: selectedSemValue,
        onChanged: (int? newValue) {
          setState(() {
            selectedSemValue = newValue!;

            selectSubjectApi();
          });
        },
        items: _selectSemesterModelList.map((val) {
          return DropdownMenuItem(
            value: val.sEMECODE,
            child: Text(val.semesterName!, style: Palette.title),
          );
        }).toList(),
      ),
    );
  }

  Widget _selectBranchWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.fromLTRB(20.0, 20, 20.0, 8),
      padding: const EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(color: kThemeColor.withOpacity(0.1), width: 2.0),
      ),
      child: DropdownButton(
        isExpanded: true,
        underline: const SizedBox(),
        hint: const Text(
          'Select Branch',
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
        ),
        value: selectedBranchValue,
        onChanged: (int? newValue) {
          setState(() {
            selectedBranchValue = newValue!;
            _selectSubjectModelList.clear();
          });
        },
        items: _selectBranchModelList.map((val) {
          return DropdownMenuItem(
            value: val.cLSCODE,
            child: Text(val.cLSNAME!, style: Palette.title),
          );
        }).toList(),
      ),
    );
  }

  Widget _selectSubjectWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.fromLTRB(20.0, 20, 20.0, 8),
      padding: const EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(color: kThemeColor.withOpacity(0.1), width: 2.0),
      ),
      child: DropdownButton(
        isExpanded: true,
        underline: const SizedBox(),
        hint: const Text(
          'Select Subject',
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
        ),
        value: selectedSubjectValue,
        onChanged: (int? newValue) {
          setState(() {
            selectedSubjectValue = newValue!;
          });
        },
        items: _selectSubjectModelList.map((val) {
          return DropdownMenuItem(
            value: val.sBJCODE,
            child: Text(val.sBJNAME ?? '', style: Palette.title),
          );
        }).toList(),
      ),
    );
  }

  Widget selectDatePicker() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Center(
        child: TextField(
          controller: dateController,
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
              print(formattedDate);
              setState(() {
                dateController.text = formattedDate;
              });
            } else {
              print("Date is not selected");
            }
          },
        ),
      ),
    );
  }

  Widget _timeRow() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Center(
        child: TextField(
          controller: timeController,
          decoration: etBoxDecoration('Attendance Time'),
          readOnly: true,
          onTap: () async {
            TimeOfDay? pickedTime = await showTimePicker(
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
              initialTime: TimeOfDay.now(),
              context: context,
            );

            if (pickedTime != null) {
              print(pickedTime.format(context));
              DateTime parsedTime =
                  DateFormat.jm().parse(pickedTime.format(context).toString());
              print(parsedTime);
              String formattedTime = DateFormat('HH:mm').format(parsedTime);
              print(formattedTime);

              setState(() {
                timeController.text = formattedTime;
              });
            } else {
              print("Time is not selected");
            }
          },
        ),
      ),
    );
  }

  Widget _subMit() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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

  Future<void> selectSemesterApi() async {
    LoadingDialog.showLoadingDialog(context);
    SelectClassRepo selectClassRepo = SelectClassRepo();
    try {
      SemesterSelectModel data = await selectClassRepo.fetchSemData();

      if (data.success!) {
        Navigator.pop(context);
        setState(() {
          _selectSemesterModelList = data.data!;
        });
      }
    } catch (e) {
      print('Exeption $e');
      print('$selectedSemValue');
    }
  }

  Future<void> selectBranchApi() async {
    LoadingDialog.showLoadingDialog(context);
    SelectClassRepo selectClassRepo = SelectClassRepo();
    try {
      BranchSelectModel data = await selectClassRepo.fetchBranchData();

      if (data.success!) {
        Navigator.pop(context);
        setState(() {
          _selectBranchModelList = data.data!;
        });
      }
    } catch (e) {
      print('Exeption $e');
      print('$selectedBranchValue');
    }
  }

  Future<void> selectSubjectApi() async {
    LoadingDialog.showLoadingDialog(context);
    SelectClassRepo selectClassRepo = SelectClassRepo();
    try {
      SubjectSelectModel data = await selectClassRepo.fetchSubjectData(
        cLSCODE: selectedBranchValue.toString(),
        sEMECODE: selectedSemValue.toString(),
      );

      if (data.success!) {
        Navigator.pop(context);
        setState(() {
          _selectSubjectModelList = data.data!;
        });
      }
    } catch (e) {
      print('Exeption $e');
      print('$selectedSemValue');
    }
  }

  void _applicationApi() async {
    LoadingDialog.showLoadingDialog(context);
    StudentAttendanceRepo studentAttendanceRepo = StudentAttendanceRepo();

    try {
      AttsHdrModel data = await studentAttendanceRepo.fetchHdrData(
        aTDSDATE: dateController.text,
        aTDSTIME: timeController.text,
        bRANCHID: selectedBranchValue.toString(),
        sEMESTERID: selectedSemValue.toString(),
        sUBID: selectedSubjectValue.toString(),
      );
      if (data.success!) {
        Navigator.pop(context);
        Navigator.pop(context);
        SuccessDialouge.showErrorDialogue(context, data.message!);
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
