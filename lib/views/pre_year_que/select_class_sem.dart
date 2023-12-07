import 'package:flutter/material.dart';
import 'package:pns_skolar/views/pre_year_que/pre_year_que.dart';

import '../../model/course/class_select_model.dart';
import '../../model/course/semester_select_model.dart';
import '../../model/course/subject_select_model.dart';
import '../../repo/Course/select_class_repo.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../widget/loading_dialogue.dart';
import '../courses/subject_details.dart';

class SelectClassSem extends StatefulWidget {
  const SelectClassSem({super.key});

  @override
  State<SelectClassSem> createState() => _SelectClassSemState();
}

class _SelectClassSemState extends State<SelectClassSem> {
  List<ClassSelectDataModel> _selectClassModelList = [];
  int? selectedValue;

  List<SemesterSelectDataModel> _selectSemesterModelList = [];
  int? selectedSemValue;

  List<SubjectSelectDataModel> _selectsubModelList = [];
  int? selectedSubValue;

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
        title: Text('Select Subject', style: Palette.appbarTitle),
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
                    _selectSubjectWidget(),
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

  Widget _submitBtn() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 15, 20, 30),
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PreYearQue(
                subCode: selectedSubValue.toString(),
                classCode: selectedValue.toString(),
                semCode: selectedSemValue.toString(),
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
          'Search',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _selectSubjectWidget() {
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
            children: List.generate(_selectsubModelList.length, (i) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedSubValue = _selectsubModelList[i].sBJCODE;
                  });
                },
                child: Card(
                  elevation: 0,
                  shape: Palette.cardShape,
                  color: selectedSubValue == _selectsubModelList[i].sBJCODE
                      ? Colors.cyan
                      : Colors.cyan.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
                    child: Text(
                      '${_selectsubModelList[i].sBJNAME}',
                      style: selectedSubValue == _selectsubModelList[i].sBJCODE
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
                  selectSubjectApi();
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
                  selectSubjectApi();
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
            selectSubjectApi();
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

  Future<void> selectSubjectApi() async {
    LoadingDialog.showLoadingDialog(context);
    SelectClassRepo selectClassRepo = SelectClassRepo();

    try {
      SubjectSelectModel data = await selectClassRepo.fetchSubjectData(
        cLSCODE: selectedValue.toString(),
        sEMECODE: selectedSemValue.toString(),
      );

      if (data.success!) {
        Navigator.pop(context);
        setState(() {
          _selectsubModelList = data.data!;
          if (_selectsubModelList.isNotEmpty) {
            selectedSubValue = _selectsubModelList[0].sBJCODE;
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
