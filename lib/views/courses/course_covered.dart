import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pns_skolar/model/common_model.dart';
import 'package:pns_skolar/repo/Course/select_topic_repo.dart';

import '../../model/class_time_model.dart';
import '../../model/course/select_topic_model.dart';
import '../../repo/Course/subject_info_repo.dart';
import '../../repo/class_time_repo.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../widget/error_dialouge.dart';
import '../../widget/loading_dialogue.dart';
import '../../widget/success_dialouge.dart';

class CourseCovered extends StatefulWidget {
  final String? sUBID;
  const CourseCovered({super.key, required this.sUBID});

  @override
  State<CourseCovered> createState() => _CourseCoveredState();
}

class _CourseCoveredState extends State<CourseCovered> {
  TextEditingController positionController = TextEditingController();
  TextEditingController coverDateController = TextEditingController();
  String _selectedDate = '';
  TextEditingController remarksController = TextEditingController();

  List<SelectTopicDataModel> _selectTopicModelList = [];
  int? selectedValue;

  List<StartTimeData> _classStartTimeList = [];
  StartTimeData _selectedClassStartTime = StartTimeData();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      selectSportsApi();
    });

    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(currentDate);
    String formattedDate2 = DateFormat('MM/dd/yyyy').format(currentDate);
    coverDateController.text = formattedDate;
    _selectedDate = formattedDate2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Course Covered',
          style: Palette.appbarTitle,
        ),
        flexibleSpace: Container(
          decoration: Palette.appbarGradient,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            selectDatePicker(),
            _classStartTimeListWidget(),
            _selectTopicWidget(),
            _positionRow(),
            _remarksRow(),
            _subMit(),
          ],
        ),
      ),
    );
  }

  Widget _selectTopicWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 5),
          child: Text('Topic :', style: Palette.title),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          width: MediaQuery.of(context).size.width,
          child: Wrap(
            children: List.generate(_selectTopicModelList.length, (i) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedValue = _selectTopicModelList[i].tOPICID;
                  });
                },
                child: Card(
                  elevation: 0,
                  shape: Palette.cardShape,
                  color: selectedValue == _selectTopicModelList[i].tOPICID
                      ? Colors.indigo
                      : Colors.indigo.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
                    child: Text(
                      '${_selectTopicModelList[i].tOPICNAME}',
                      style: selectedValue == _selectTopicModelList[i].tOPICID
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

  Widget _topicSelectWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.fromLTRB(20.0, 8, 20.0, 8),
      padding: const EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(color: kThemeColor.withOpacity(0.1), width: 2.0),
      ),
      child: DropdownButton(
        isExpanded: true,
        underline: const SizedBox(),
        hint: const Text(
          'Select Topic',
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
        ),
        value: selectedValue,
        onChanged: (int? newValue) {
          setState(() {
            selectedValue = newValue!;
          });
        },
        items: _selectTopicModelList.map((val) {
          return DropdownMenuItem(
            value: val.tOPICID,
            child: Text(val.tOPICNAME!, style: Palette.title),
          );
        }).toList(),
      ),
    );
  }

  Widget _positionRow() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: positionController,
              keyboardType: TextInputType.name,
              style: const TextStyle(
                fontFamily: kThemeFont,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              decoration: _textFieldDecoration(label: 'Cover Portion'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _classStartTimeListWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 5),
          child: Text('Cover Time :', style: Palette.title),
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

  Widget _remarksRow() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: remarksController,
              maxLines: 4,
              keyboardType: TextInputType.name,
              style: const TextStyle(
                fontFamily: kThemeFont,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              decoration: _textFieldDecoration(label: 'Remarks'),
            ),
          ),
        ],
      ),
    );
  }

  Widget selectDatePicker() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Center(
        child: TextField(
          controller: coverDateController,
          decoration: etBoxDecoration('Cover Date'),
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
              String formattedDate =
                  DateFormat('dd/MM/yyyy').format(pickedDate);
              String formattedDate2 =
                  DateFormat('MM/dd/yyyy').format(pickedDate);
              //print(formattedDate);
              _selectedDate = formattedDate2;
              setState(() {
                coverDateController.text = formattedDate;
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
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          _applicationApi();
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

  Future<void> selectSportsApi() async {
    LoadingDialog.showLoadingDialog(context);
    SelectTopicRepo selectTopicRepo = SelectTopicRepo();
    try {
      SelectTopicModel data =
          await selectTopicRepo.fetchData(sUBID: widget.sUBID);

      if (data.success!) {
        Navigator.pop(context);
        setState(() {
          _selectTopicModelList = data.data!;
          if (_selectTopicModelList.isNotEmpty) {
            selectedValue = _selectTopicModelList[0].tOPICID;
          }
        });
      } else {
        Navigator.pop(context);
      }

      classStartTimeApi();
    } catch (e) {
      print('Exeption $e');
      print('$selectedValue');
    }
  }

  Future<void> classStartTimeApi() async {
    LoadingDialog.showLoadingDialog(context);
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
    SubjectRepo subjectRepo = SubjectRepo();

    try {
      CommonModel data = await subjectRepo.sendCourseData(
        covPosition: positionController.text,
        covDate: _selectedDate,
        covTime: _selectedClassStartTime.classStartTime.toString(),
        remarks: remarksController.text,
        topicID: selectedValue.toString(),
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
