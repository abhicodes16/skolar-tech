import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../style/palette.dart';
import '../../style/theme_constants.dart';

class FillMarks extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return FillMarks_State();
  }
}

class FillMarks_State extends State<FillMarks>{


  var selectedCheckbox = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Enter Marks',
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

            SizedBox(height: 20,),

            Container(
              margin: EdgeInsets.only(left: 10,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                Container(
                  decoration: BoxDecoration(
                     color: kThemeColor,
                    border: Border.all(color: kThemeColor,width: 1.5),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0,left: 15,bottom: 3,top: 3),
                    child: Text(
                      "Index",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,fontWeight: FontWeight.w600
                      ) ,
                    ),
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                      color: kThemeColor,
                      border: Border.all(color: kThemeColor,width: 1.5),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0,left: 15,bottom: 3,top: 3),
                    child: Text(
                      "Enter Marks",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,fontWeight: FontWeight.w600
                      ) ,
                    ),
                  ),
                )

              ],
              ),
            ),

            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title:  Row(
                        children: [
                          Text('${index + 1}.  '),
                          Expanded(
                            child: Text(
                              "Student ${index+1}",
                            ),
                          ),

                          Container(
                            width: 100,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              readOnly: false,
                              decoration: etBoxDecoration("Marks"),
                            ),
                          )
                          
                        ],
                      ),
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
      hintText: label,
      hintStyle: const TextStyle(color: Colors.grey,fontSize: 13),
    );
  }


  Widget _subMit() {
    return Container(
      margin: const EdgeInsets.fromLTRB(40, 0, 40, 15),
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
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

}