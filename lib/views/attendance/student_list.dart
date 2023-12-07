import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pns_skolar/repo/attendance/attendance_repo.dart';
import 'package:pns_skolar/views/attendance/att_hdr_insert.dart';
import 'package:pns_skolar/widget/success_dialouge.dart';
import 'package:pns_skolar/widget/success_home_dialog.dart';

import '../../bloc/attendance/student_attendance_details_bloc.dart';
import '../../model/attendance/student_attnc_detail_model.dart';
import '../../model/common_model.dart';
import '../../repo/attendance/student_attendance_dtl_repo.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../widget/error_dialouge.dart';
import '../../widget/loading_dialogue.dart';

class StudentList extends StatefulWidget {
  final String cLS_CODE;
  final String sEME_CODE;
  final String sUBID;
  final String attendanceDate;
  final String attendanceTime;
  const StudentList({
    super.key,
    required this.cLS_CODE,
    required this.sEME_CODE,
    required this.sUBID,
    required this.attendanceDate,
    required this.attendanceTime,
  });

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  StdAttendanceDetailsBloc? stdAttendanceDetailsBloc;
  List<TypeData> _typeModelList = [];
  TypeData _selectedReportType = TypeData();
  List<bool> selectedCheckbox = [];

  @override
  void initState() {
    getTypeApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student Details List',
          style: Palette.appbarTitle,
        ),
        flexibleSpace: Container(
          decoration: Palette.appbarGradient,
        ),
        // actions: [
        //   Row(
        //     children: [
        //       IconButton(
        //         onPressed: () {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => AttendanceHdr(),
        //             ),
        //           );
        //         },
        //         icon: Icon(CupertinoIcons.calendar_today),
        //       )
        //     ],
        //   )
        // ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  itemCount: _typeModelList.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      title: Row(
                        children: [
                          Text('${index + 1}.  '),
                          Expanded(
                            child: Text(
                              _typeModelList[index].sTDNAME ?? '',
                            ),
                          ),
                        ],
                      ),
                      activeColor: kThemeColor,
                      value: selectedCheckbox[index],
                      onChanged: (value) {
                        setState(() {
                          selectedCheckbox[index] = !selectedCheckbox[index];
                        });
                      },
                    );
                  },
                ),
              ),
            ),
            _subMit(),
          ],
        ),
      ),
    );
  }

  Widget _subMit() {
    return Container(
      margin: const EdgeInsets.fromLTRB(40, 0, 40, 15),
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          addAttendanceClassWise();
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

  Future<void> getTypeApi() async {
    // LoadingDialog.showLoadingDialog(context);
    StudentAttendanceRepo attendanceRepo = StudentAttendanceRepo();
    try {
      StudentAttendanceModel data = await attendanceRepo.fetchData(
          cLS_CODE: widget.cLS_CODE, sEME_CODE: widget.sEME_CODE);

      if (data.success!) {
        setState(() {
          for (var i = 0; i < data.data!.length; i++) {
            selectedCheckbox.add(true);
          }
          _typeModelList = data.data!;
          if (_typeModelList.isNotEmpty) {
            _selectedReportType = _typeModelList.first;
          }
        });
      }
    } catch (e) {
      print('Exeption $e');
    }
  }

  Future<void> addAttendanceClassWise() async {
    LoadingDialog.showLoadingDialog(context);

    String studentCodePresent = '';
    String studentCodeAbsent = '';

    for (var i = 0; i < selectedCheckbox.length; i++) {
      TypeData data = _typeModelList.elementAt(i);
      if (selectedCheckbox[i]) {
        if (studentCodePresent.isEmpty) {
          studentCodePresent = "${data.sTDCODE}";
        } else {
          studentCodePresent = "$studentCodePresent:${data.sTDCODE}";
        }
      } else {
        if (studentCodePresent.isEmpty) {
          studentCodeAbsent = "${data.sTDCODE}";
        } else {
          studentCodeAbsent = "$studentCodeAbsent:${data.sTDCODE}";
        }
      }
    }

    StudentAttendanceRepo attendanceRepo = StudentAttendanceRepo();

    try {
      CommonModel? data = await attendanceRepo.addAttendaceClassWise(
        attendanceDate: widget.attendanceDate,
        attendanceTime: widget.attendanceTime,
        branchCode: widget.cLS_CODE,
        semesterCode: widget.sEME_CODE,
        studentCodeAbsent: studentCodeAbsent,
        studentCodePresent: studentCodePresent,
        subjectCode: widget.sUBID,
      );
      Navigator.pop(context);
      if (data.success != null) {
        if (data.success!) {
          SuccessHomeDialog.show(context, 'Attendance Submit Successfully.');
        } else {
          ErrorDialouge.showErrorDialogue(context, data.message ?? '');
        }
      }
    } catch (e) {
      Navigator.pop(context);
      ErrorDialouge.showErrorDialogue(context, e.toString());
    }
  }
}
