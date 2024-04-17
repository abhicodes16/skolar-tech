import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pns_skolar/widget/success_dialouge.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../style/assets_constants.dart';
import '../../style/palette.dart';
import '../../style/theme_constants.dart';
import '../../utils/api_constant.dart';
import '../../widget/error_dialouge.dart';
import '../../widget/toast.dart';

class ReplyDialog extends StatefulWidget {

  final String queryId;

  const ReplyDialog({Key? key, required this.queryId}) : super(key: key);

  @override
  _ReplyDialogState createState() => _ReplyDialogState();
}

class _ReplyDialogState extends State<ReplyDialog> {
  final TextEditingController _replyController = TextEditingController();


  bool submitLoading = false;

  var height = Get.height;
  var width = Get.width;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // Assuming 'width' is defined somewhere in your class.

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Stack(
          alignment: Alignment.topCenter,
          children: [

            Padding(
              padding: const EdgeInsets.only(
                top: 20
              ),
              child: AlertDialog(
                //key: key,
                //backgroundColor: Colors.white,
                content: Container(
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      SizedBox(height: 30,),

                      Align(
                          alignment: Alignment.center,
                          child: Text("Enter Your Reply")
                      ),

                      SizedBox(height: 20,),

                      TextFormField(
                          controller: _replyController,
                          maxLines: 1,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          decoration: _MobiletextFieldDecoration(
                              label:
                              "Reply")
                      ),

                      SizedBox(height: 20,),

                      _sbmitBtn()
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(radius: 35,
                child: Icon(Icons.reply,color: Colors.white,size: 35),
              ),
            ),
          ],
        )
      ],
    );
  }

  InputDecoration _MobiletextFieldDecoration({String? label}) {
    return InputDecoration(
      hintText: "Enter Reply",
      suffixIcon: Icon(Icons.messenger,),
      counter: const Offstage(),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:
          BorderSide(width: 2.0, color: Colors.grey.withOpacity(0.1))),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:
          BorderSide(width: 2.0, color: Colors.grey.withOpacity(0.1))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:
          BorderSide(width: 2.0, color: Colors.grey.withOpacity(0.1))),
      contentPadding: const EdgeInsets.all(15.0),
      filled: true,
      fillColor: Colors.grey.withOpacity(0.1),
      labelText: "$label",
      alignLabelWithHint: true,
      labelStyle: const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w400,
      ),
    );
  }



  Widget _sbmitBtn(){
    return InkWell(
      onTap: () {
        if(_replyController.text.isEmpty){
          Utils().themetoast("Please Enter Your Reply");
        }else{
          _submitAPi(widget.queryId,_replyController.text.toString());
        }
      },
      child: Container(
        width: width*1,
        height: 45,
        decoration: BoxDecoration(
          color: kThemeColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child:
        submitLoading?
        Center(child:  SizedBox(width: 30,height: 30,child: CircularProgressIndicator(color: Colors.white,)),)
            :
        Center(child: Text("Submit",style: Palette.whiteBtnTxt,)),
      ),
    );
  }

  var schoolCode;
  var token;



  Future<void> _submitAPi(queiryId, reply) async {



    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      schoolCode = pref.getString('schoolCode');
      token = pref.getString('token');
      submitLoading = true;
      print("--->$token");
    });


    try{
      final params = {
        'schoolCode': '$schoolCode',
      };

      final uri = Uri.parse(ApiConstant.POST_REPLY_TEACHER).replace(queryParameters: params);


      final response = await http.post(
        uri,
        headers: {
          'apikey': ApiConstant.API_KEY,
          'Content-Type': 'application/json',
          'token' : token
        },
        body: json.encode({
          'id' : '${queiryId}',
          'replyDetails' : reply.toString()
        }),
      );

      print('Request Fields:');
      print('queryId: $queiryId');
      print('reply: $reply');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body)['data'];
        print("-->response $responseData");
        if(json.decode(response.body)['success'] == true){
          Get.back();
          SuccessDialouge.showErrorDialogue(context, "${responseData[0]['msg']}");
        }
      }
    } catch (e) {
      Utils().themetoast(e.toString());
    } finally {
      setState(() {
        submitLoading = false;
      });
    }
  }




  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }
}
