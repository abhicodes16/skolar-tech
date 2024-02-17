import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pns_skolar/views/test/fill_students_marks.dart';

import '../../style/palette.dart';
import '../../style/theme_constants.dart';

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
  var _selectTypeList = [
    {
      "Id": "1",
      "type" : "IA"
    },
    {
      "Id": "2",
      "type" : "CT"
    },
  ];


  String? selectedSemValue;
  var _selectSemList = [
    {
      "name": "1",
      "code" : "st"
    },
    {
      "name": "2",
      "code" : "nd"
    },
    {
      "name": "3",
      "code" : "rd"
    },
    {
      "name": "4",
      "code" : "th"
    },
    {
      "name": "5",
      "code" : "th"
    },
    {
      "name": "6",
      "code" : "th"
    },
  ];



  String? selectedSubValue;
  var _selectSubList = [
    {
      "name": "ENG. PHYSICS",
      "Id" : "1"
    },
    {
      "name": "ENG. MATHS",
      "Id" : "2"
    },
    {
      "name": "ENG. CHEMISTRY",
      "Id" : "3"
    },
    {
      "name": "ENG. LAB",
      "Id" : "4"
    },
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                     _selectSemesterWidget()
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
            children: List.generate(_selectSubList.length, (i) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedSubValue =
                        _selectSubList[i]["Id"].toString();
                  });
                },
                child: Card(
                  elevation: 0,
                  shape: Palette.cardShape,
                  color: selectedSubValue ==
                      _selectSubList[i]["Id"].toString()
                      ? Colors.indigo
                      : Colors.indigo.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${_selectSubList[i]["name"]}',
                          style: selectedSubValue ==
                              _selectSubList[i]["Id"].toString()
                              ? Palette.titleWhiteS
                              : Palette.titleS,
                        ),

                        SizedBox(width: 30,),


                        Container(
                          height: 20,width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 1.5,color: Colors.white)
                          ),
                          child: Center(child: Icon(
                            Icons.circle,size: 13,color:
                          selectedSubValue ==
                              _selectSubList[i]['Id'] ?
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
            children: List.generate(_selectSemList.length, (i) {

              return InkWell(
                onTap: () {
                  setState(() {
                    selectedSemValue = _selectSemList[i]['code'];
                  });
                },
                child: Card(
                  elevation: 0,
                  shape: Palette.cardShape,
                  color:
                  selectedSemValue == _selectSemList[i]['code']
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
                                '${_selectSemList[i]['name']}',
                                style: selectedSemValue ==
                                    _selectSemList[i]['code']
                                    ? Palette.titlez
                                    : Palette.title,
                              ),
                              const SizedBox(width: 1),
                              Text(
                                '${_selectSemList[i]['code']}',
                                style: selectedSemValue ==
                                    _selectSemList[i]["code"]
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
                                _selectSemList[i]['code'] ?
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
              children: List.generate(_selectTypeList.length, (index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedTypeValue =
                          _selectTypeList[index]['Id'].toString();
                    });
                  },
                  child: Card(
                    elevation: 0,
                    clipBehavior: Clip.hardEdge,
                    shape: Palette.cardShape,
                    color: selectedTypeValue ==
                        _selectTypeList[index]['Id'].toString()
                        ? Colors.pink
                        : Colors.pink.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${_selectTypeList[index]['type']}',
                            style: selectedTypeValue ==
                                _selectTypeList[index]['Id'].toString()
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
                                _selectTypeList[index]['Id'].toString()?
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
          Get.to(()=>FillMarks());
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



}