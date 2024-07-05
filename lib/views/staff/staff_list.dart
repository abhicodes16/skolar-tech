import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pns_skolar/model/staff_details_model.dart';
import 'package:pns_skolar/views/staff/staff_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/api_constant.dart';
import '../../widget/error_dialouge.dart';

class StaffList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StaffList_State();
  }
}

class StaffList_State extends State<StaffList> {
  var height = Get.height;
  var width = Get.width;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStaffDetails();
  }

  String? _selectedDept;

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Staff',
            style: Palette.appbarTitle,
          ),
          flexibleSpace: Container(decoration: Palette.appbarGradient),
        ),
        body: loading
            ? Center(
                child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              ))
            : data.isEmpty
                ? Center(
                    child: Text("No Data Available..!"),
                  )
                : Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: width * 0.02, left: width * 0.02, top: height * 0.01),
                        child: TextFormField(
                          controller: _searchController,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          onChanged: (value) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              hintText: "Search By Username",
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w500),
                              suffixIcon: Icon(Icons.search, color: Colors.grey),
                              enabledBorder:
                                  OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey, width: 1.5)),
                              focusedBorder:
                                  OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey, width: 1.5)),
                              disabledBorder:
                                  OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey, width: 1.5)),
                              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
                        ),
                      ),
                      _dropDown(),
                      _staffList(),
                    ],
                  ));
  }

  Widget _staffList() {
    List<Data> filteredData;
    if (_selectedDept != null) {
      filteredData = data.where((item) => item.eMPDEPTNAME == _selectedDept.toString()).toList();
    } else {
      filteredData = data.toList();
    }

    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          right: width * 0.02,
          left: width * 0.02,
        ),
        itemCount: filteredData.length,
        itemBuilder: (context, index) {
          var dataIndex = filteredData[index];

          if (_searchController.text.isEmpty) {
            return InkWell(
              onTap: () {
                Get.to(() => StaffDetails(), arguments: {
                  'EmpName': '${dataIndex.eMPNAME ?? "-"}',
                  'EmpId': '${dataIndex.empIdNo ?? "-"}',
                  'EmpCode': '${dataIndex.eMPCODE ?? "-"}',
                  'EMP_DOB': '${dataIndex.eMPDOB ?? "-"}',
                  'EMP_MOB': '${dataIndex.eMPMOB ?? "-"}',
                  'EMP_Mail': '${dataIndex.eMPMAILID ?? "-"}',
                  'EMP_GNDR': '${dataIndex.eMPGNDR ?? "-"}',
                  'EMP_DOJ': '${dataIndex.eMPDOJ ?? "-"}',
                  'EMP_DESG_NAME': '${dataIndex.eMPDESGNAME ?? "-"}',
                  'EMP_QUALIFICATION': '${dataIndex.eMPQUALIFICATION ?? "-"}',
                  'EMP_ADH_NO': '${dataIndex.eMPADHNO ?? "-"}',
                  'EMP_PAN_NO': '${dataIndex.eMPPANNO ?? "-"}',
                  'EMP_TYP_CODE': '${dataIndex.eMPTYPCODE ?? "-"}',
                  'photo': '${dataIndex.eMPPHTURL ?? "-"}',
                  'EMP_DEPT_NAME': '${dataIndex.eMPDEPTNAME ?? "-"}',
                  'EMP_ADRS_PRSN': '${dataIndex.eMPADRSPRSN ?? "-"}',
                  'EMP_ADRS_PRMN': '${dataIndex.eMPADRSPRMN ?? "-"}',
                });
              },
              child: Card(
                elevation: 4,
                margin: EdgeInsets.only(bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 8, bottom: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                                border: Border.all(color: kThemeDarkColor, width: 1.5),
                                shape: BoxShape.circle,
                                image: dataIndex.eMPPHTURL.toString() == "null" || dataIndex.eMPPHTURL.toString().isEmpty
                                    ? DecorationImage(image: AssetImage("assets/img/as.png"))
                                    : DecorationImage(image: NetworkImage(dataIndex.eMPPHTURL.toString() ?? "-"))),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${dataIndex.eMPNAME.toString() ?? "-"}",
                                          style: TextStyle(color: kThemeDarkColor, fontSize: 14, fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Container(
                                        color: kThemeColor,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 5, right: 5, bottom: 3, top: 3),
                                          child: Text("${dataIndex.eMPGNDR.toString() ?? "-"}",
                                              style: TextStyle(
                                                fontFamily: kThemeFont,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.0,
                                                color: Colors.white,
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "${dataIndex.empIdNo.toString() ?? "-"}",
                                    style: TextStyle(color: kThemeDarkColor.withOpacity(0.6), fontSize: 12.5, fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "${dataIndex.eMPMAILID.toString() ?? "-"}",
                                    style: TextStyle(color: kThemeDarkColor.withOpacity(0.6), fontSize: 12, fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (dataIndex.eMPNAME.toString().toLowerCase().contains(_searchController.text.toLowerCase())) {
            return InkWell(
              onTap: () {
                Get.to(() => StaffDetails(), arguments: {
                  'EmpName': '${dataIndex.eMPNAME ?? "-"}',
                  'EmpId': '${dataIndex.empIdNo ?? "-"}',
                  'EmpCode': '${dataIndex.eMPCODE ?? "-"}',
                  'EMP_DOB': '${dataIndex.eMPDOB ?? "-"}',
                  'EMP_MOB': '${dataIndex.eMPMOB ?? "-"}',
                  'EMP_Mail': '${dataIndex.eMPMAILID ?? "-"}',
                  'EMP_GNDR': '${dataIndex.eMPGNDR ?? "-"}',
                  'EMP_DOJ': '${dataIndex.eMPDOJ ?? "-"}',
                  'EMP_DESG_NAME': '${dataIndex.eMPDESGNAME ?? "-"}',
                  'EMP_QUALIFICATION': '${dataIndex.eMPQUALIFICATION ?? "-"}',
                  'EMP_ADH_NO': '${dataIndex.eMPADHNO ?? "-"}',
                  'EMP_PAN_NO': '${dataIndex.eMPPANNO ?? "-"}',
                  'EMP_TYP_CODE': '${dataIndex.eMPTYPCODE ?? "-"}',
                  'photo': '${dataIndex.eMPPHTURL ?? "-"}',
                  'EMP_DEPT_NAME': '${dataIndex.eMPDEPTNAME ?? "-"}',
                  'EMP_ADRS_PRSN': '${dataIndex.eMPADRSPRSN ?? "-"}',
                  'EMP_ADRS_PRMN': '${dataIndex.eMPADRSPRMN ?? "-"}',
                });
              },
              child: Card(
                elevation: 4,
                margin: EdgeInsets.only(bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 8, bottom: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                                border: Border.all(color: kThemeDarkColor, width: 1.5),
                                shape: BoxShape.circle,
                                image: dataIndex.eMPPHTURL.toString() == "null" || dataIndex.eMPPHTURL.toString().isEmpty
                                    ? DecorationImage(image: AssetImage("assets/img/as.png"))
                                    : DecorationImage(image: NetworkImage(dataIndex.eMPPHTURL.toString() ?? "-"))),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${dataIndex.eMPNAME.toString() ?? "-"}",
                                          style: TextStyle(color: kThemeDarkColor, fontSize: 14, fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Container(
                                        color: kThemeColor,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 5, right: 5, bottom: 3, top: 3),
                                          child: Text("${dataIndex.eMPGNDR.toString() ?? "-"}",
                                              style: TextStyle(
                                                fontFamily: kThemeFont,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.0,
                                                color: Colors.white,
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "${dataIndex.empIdNo.toString() ?? "-"}",
                                    style: TextStyle(color: kThemeDarkColor.withOpacity(0.6), fontSize: 12.5, fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "${dataIndex.eMPMAILID.toString() ?? "-"}",
                                    style: TextStyle(color: kThemeDarkColor.withOpacity(0.6), fontSize: 12, fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }

  Widget _dropDown() {
    Set<String> departments = Set<String>.from(data.map((item) => item.eMPDEPTNAME));
    
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(
        right: width * 0.02,
        left: width * 0.02,
        top: height * 0.01,
        bottom: height * 0.01,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          right: width * 0.04,
          left: width * 0.04,
        ),
        child: DropdownButton(
          isExpanded: true,
          underline: const SizedBox(),
          hint: const Text('Select Department Name'), // Not necessary for Option 1
          value: _selectedDept,
          onChanged: (newValue) {
            setState(() {
              _selectedDept = newValue.toString();
            });
          },
          items: departments.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  var schoolCode;
  var token;

  bool loading = false;

  var data = <Data>[];

  Future<void> getStaffDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      schoolCode = pref.getString('schoolCode');
      token = pref.getString('token');
      loading = true;
      print("--->$token");
    });

    try {
      final params = {
        'schoolCode': '$schoolCode',
      };

      final uri = Uri.parse(ApiConstant.GET_STAFF_DATA).replace(queryParameters: params);

      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json', 'apikey': ApiConstant.API_KEY, 'token': token},
      );

      if (response.statusCode == 200) {
        final StaffDetailsModel questionHistory = StaffDetailsModel.fromJson(json.decode(response.body));

        setState(() {
          data = questionHistory.data ?? [];
        });
      } else {
        ErrorDialouge.showErrorDialogue(context, "Something is Wrong please try again later");
        print('Error: ${response.reasonPhrase}, Status Code: ${response.statusCode}');
      }
    } catch (e) {
      ErrorDialouge.showErrorDialogue(context, "Something is Wrong please try again later");
      print('Error decoding JSON: $e');
    } finally {
      setState(() {
        loading = false;
      });
    }
  }
}
