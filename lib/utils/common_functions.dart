
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/screen_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonFunctions{

  static bool hasOneUpperCase(String password){
    String  pattern = r'^(?=.*?[A-Z]).{1,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(password);
  }
  static bool hasOneLowerCase(String password){
    String  pattern = r'^(?=.*?[a-z]).{1,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(password);
  }
  static bool hasOneDigit(String password){
    String  pattern = r'^(?=.*?[0-9]).{1,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(password);
  }
  static bool hasOneSpeicalCharacter(String password){
    String  pattern = r'^(?=.*?[!@#\$&*~]).{1,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(password);
  }
  static bool isValidPassword(String password){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(password);
  }
  static bool isValidLength(String password){
    return password.length>=8;
  }
  static bool isValidEmail(String email){
    if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)){
      return true;
    }else{
      return false;
    }
  }
  static bool isValidUserName(String userName){
    if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(userName)){
      return true;
    }else{
      return false;
    }
  }
  static Future showDateOfBirthPicker(BuildContext context,DateTime initialDate) {
    DateTime selectedDateTime;
    initialDate = initialDate==null? DateTime.now() : initialDate;
    DateTime maxDateTime = DateTime.now();
    selectedDateTime = maxDateTime;
    return  showModalBottomSheet(context: context, builder: (context){
      return Container(
        height: ScreenUtil.getInstance().height*.35,decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(4.i),topLeft: Radius.circular(4.i))
      ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 2.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    color: ColorUtils.blueColor,
                    onPressed: (){
                      Navigator.pop(context,selectedDateTime);
                    },
                    child: Text(
                      "Cancel",
                      style:
                      TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 1.9.t),
                    ),
                  ),
                  MaterialButton(
                    color: ColorUtils.blueColor,
                    //padding: EdgeInsets.zero,
                    onPressed: (){
                      Navigator.pop(context,selectedDateTime);
                    },
                    child: Text(
                      "Done",style:
                    TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 1.9.t),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: CupertinoTheme(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    maximumDate:  maxDateTime,
                    minimumDate: DateTime.now().subtract(Duration(days: 365*100)),
                    initialDateTime: initialDate,
                    onDateTimeChanged: (DateTime dateTime) {
                      selectedDateTime = dateTime;
                    },
                  ),
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(color: ColorUtils.blueColor,fontWeight: FontWeight.w400,fontSize: 1.9.t),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    },isDismissible: false);
  }
}
extension contextExtensions on BuildContext {
  void unFocus(){
    FocusScope.of(this).requestFocus(FocusNode());
  }
}