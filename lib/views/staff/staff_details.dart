import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pns_skolar/model/staff_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/api_constant.dart';
import '../../widget/error_dialouge.dart';

class StaffDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StaffDetails_State();
  }
}

class StaffDetails_State extends State<StaffDetails> {
  var height = Get.height;
  var width = Get.width;

  var name;
  var id;

  var EmpCode  ;
  var EMP_DOB  ;
  var EMP_MOB  ;
  var EMP_Mail ;
  var EMP_GNDR ;
  var EMP_DOJ  ;
  var EMP_DESG_NAME  ;
  var EMP_QUALIFICATION ;
  var EMP_ADH_NO ;
  var EMP_PAN_NO ;
  var photo ;
  var EMP_DEPT_NAME ;
  var EMP_ADRS_PRSN ;
  var EMP_ADRS_PRMN ;
  var EMP_TYP_CODE ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final argument = Get.arguments;
    setState(() {
      name = argument['EmpName'];
      id = argument['EmpId'];
      EmpCode = argument['EmpCode'];
      EMP_DOB = argument['EMP_DOB'];
      EMP_MOB = argument['EMP_MOB'];
      EMP_Mail = argument['EMP_Mail'];
      EMP_GNDR = argument['EMP_GNDR'];
      EMP_DOJ = argument['EMP_DOJ'];
      EMP_DESG_NAME = argument['EMP_DESG_NAME'];
      EMP_QUALIFICATION = argument['EMP_QUALIFICATION'];
      EMP_ADH_NO = argument['EMP_ADH_NO'];
      EMP_PAN_NO = argument['EMP_PAN_NO'];
      EMP_TYP_CODE = argument['EMP_TYP_CODE'];
      photo = argument['photo'];
      EMP_DEPT_NAME = argument['EMP_DEPT_NAME'];
      EMP_ADRS_PRSN = argument['EMP_ADRS_PRSN'];
      EMP_ADRS_PRMN = argument['EMP_ADRS_PRMN'];
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            '${name}',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15.0,
            ),
          ),
          flexibleSpace: Container(decoration: Palette.appbarGradient),
        ),
      body: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: [

            SizedBox(height: 20,),

            Expanded(
              child: Card(
                elevation: 4,
                child: Container(
                  height: height*0.9,
                  width: width*0.9,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,bottom: 20,right: 15,left: 15
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Container(
                          height: width*0.35,width: width*0.35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                              border: Border.all(color: kThemeDarkColor,width: 1.5),
                            image: DecorationImage(image: NetworkImage(photo))
                          ),
                        ),

                        SizedBox(height: 10,),

                        Text("$name",
                          style: TextStyle(
                              color: kThemeDarkColor,
                              fontSize: 14,fontWeight: FontWeight.w600
                          ),
                        ),

                        SizedBox(height: 10,),


                        Text("$EMP_Mail",
                          style: TextStyle(
                              color: kThemeDarkColor.withOpacity(0.6),
                              fontSize: 13,fontWeight: FontWeight.w600
                          ),
                        ),


                        SizedBox(height: 10,),

                        Text("$id",
                          style: TextStyle(
                              color: kThemeDarkColor.withOpacity(0.6),
                              fontSize: 12.5,fontWeight: FontWeight.w600
                          ),
                        ),

                        SizedBox(height: 8,),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Personal Info : ",
                            style: TextStyle(
                                color: kThemeDarkColor,
                                fontSize: 16,fontWeight: FontWeight.w700
                            ),
                          ),
                        ),

                        SizedBox(height: 8,),

                        Expanded(
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            children: [

                              _textRow("Birth :", "${EMP_DOB}"),

                              _textRow("Joining :", "${EMP_DOJ}"),

                              _textRow("Department Name :", "${EMP_DEPT_NAME}"),

                              _textRow("DESG Name :", "${EMP_DESG_NAME}"),

                              _textRow("ADH No :", "${EMP_ADH_NO}"),

                              _textRow("PAN No :", "${EMP_PAN_NO}"),

                              _textRow("type :", "${EMP_TYP_CODE}"),

                              _textRow("Address :", "${EMP_ADRS_PRSN}"),

                              _iconRow(Icons.book, "${EMP_QUALIFICATION}"),

                              EMP_GNDR.toString().toLowerCase() == "male"?
                              _iconRow(Icons.male, "${EMP_GNDR}")
                              :
                              _iconRow(Icons.female, "${EMP_GNDR}"),

                              _iconRow(Icons.location_on, "${EMP_ADRS_PRMN}"),

                              _iconRow(Icons.phone, "${EMP_MOB}"),

                              _iconRow(Icons.mail, "${EMP_Mail}")
                              
                            ],
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20,),

            InkWell(
              onTap: () {
                Get.back();
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Container(
                  width: width*0.9,
                  height: 50,
                  decoration: Palette.appbarGradient,
                  child: Center(child: Text("Done",style: Palette.whiteBtnTxt,)),
                ),
              ),
            ),

            SizedBox(height: 20,),

          ],
        ),
      ),
    );
        // body: Expanded(
        //   child: ListView.builder(
        //     padding: EdgeInsets.only(
        //       right: width*0.02,
        //       left: width*0.02,
        //     ),
        //     itemCount: data.length,
        //     itemBuilder: (context, index) {
        //
        //       var dataIndex = data[index];
        //
        //       return Card(
        //         elevation: 4,
        //         margin: EdgeInsets.only(bottom: 20),
        //         child: Padding(
        //           padding: const EdgeInsets.only(
        //               right: 10,left: 10,
        //               top: 8,bottom: 8
        //           ),
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Container(
        //                     height: 65,width: 65,
        //                     decoration: BoxDecoration(
        //                         border: Border.all(color: kThemeDarkColor,width: 1.5),
        //                         shape: BoxShape.circle,
        //                         image: dataIndex.eMPPHTURL.toString() == "null"  || dataIndex.eMPPHTURL.toString().isEmpty ? DecorationImage(image: AssetImage("assets/img/as.png")) :  DecorationImage(image: NetworkImage(dataIndex.eMPPHTURL.toString() ?? "-"))
        //                     ),
        //                   ),
        //
        //                   SizedBox(width: 20,),
        //
        //                   Expanded(
        //                     child: Padding(
        //                       padding: const EdgeInsets.only(top: 5,bottom: 5),
        //                       child: Column(
        //                         mainAxisAlignment: MainAxisAlignment.start,
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //
        //                           Row(
        //                             mainAxisAlignment: MainAxisAlignment.start,
        //                             crossAxisAlignment: CrossAxisAlignment.start,
        //                             children: [
        //                               Expanded(
        //                                 child: Text("${dataIndex.eMPNAME.toString() ?? "-"}",
        //                                   style: TextStyle(
        //                                       color: kThemeDarkColor,
        //                                       fontSize: 14,fontWeight: FontWeight.w600
        //                                   ),
        //                                 ),
        //                               ),
        //
        //
        //                               Container(
        //                                 color: kThemeColor,
        //                                 child: Padding(
        //                                   padding:  EdgeInsets.only(
        //                                       left: 5,right: 5,bottom: 3,top: 3
        //                                   ),
        //                                   child: Text("${dataIndex.eMPGNDR.toString() ?? "-"}",
        //                                       style:  TextStyle(
        //                                         fontFamily: kThemeFont,
        //                                         fontWeight: FontWeight.w500,
        //                                         fontSize: 12.0,
        //                                         color: Colors.white,
        //                                       )
        //                                   ),
        //                                 ),
        //                               )
        //
        //                             ],
        //                           ),
        //
        //                           SizedBox(height: 2,),
        //
        //                           Text("${dataIndex.empIdNo.toString() ?? "-"}",
        //                             style: TextStyle(
        //                                 color: kThemeDarkColor.withOpacity(0.6),
        //                                 fontSize: 12.5,fontWeight: FontWeight.w600
        //                             ),
        //                           ),
        //
        //                           SizedBox(height: 2,),
        //
        //                           Text("${dataIndex.eMPMAILID.toString() ?? "-"}",
        //                             style: TextStyle(
        //                                 color: kThemeDarkColor.withOpacity(0.6),
        //                                 fontSize: 12,fontWeight: FontWeight.w600
        //                             ),
        //                           )
        //
        //                         ],
        //                       ),
        //                     ),
        //                   )
        //
        //                 ],
        //               ),
        //
        //             ],
        //           ),
        //         ),
        //       );
        //     },
        //   ),
        // ));
  }

  Widget _textRow(title , Subtext){
    return Padding(
      padding: const EdgeInsets.only(
          top: 5,bottom: 5
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text("${title}",style: TextStyle(
              fontWeight: FontWeight.w500,fontSize: 14,
              color: Colors.black54
          ),),

          SizedBox(width: 10,),

          Expanded(
            child: Text("${Subtext}",style: TextStyle(
                fontWeight: FontWeight.w600,fontSize: 14.5,
                color: kThemeColor
            ),),
          )

        ],
      ),
    );
  }


  Widget _iconRow(IconData icon , text){
    return Padding(
      padding: const EdgeInsets.only(
        top: 5,bottom: 5
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Icon(icon,size: 17,color: kThemeColor),

          SizedBox(width: 10,),

          Expanded(
            child: Text("${text}",style: TextStyle(
                fontWeight: FontWeight.w500,fontSize: 14,
                color: kThemeColor
            ),),
          )

        ],
      ),
    );
  }



}
