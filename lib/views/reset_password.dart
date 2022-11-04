import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/widgets/back_arrow.dart';
import 'package:democratic_unity/widgets/custom_button.dart';
import 'package:democratic_unity/widgets/loader.dart';
import 'package:democratic_unity/widgets/loader_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:democratic_unity/utils/extensions.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model){
        model.resetNewPasswordController.clear();
        model.resetConfirmNewPasswordController.clear();
        //model.initialize();
        // model.onSignupUserNameFocus();
        // model.onSignupEmailFocus();
        // model.onSignupPasswordFocus();
        // model.onSignupMobileFocus();
      },
      builder: (context, model, child) {
        return model.verifyEmailCode == true ? Loader2() :
          SafeArea(
          top: false,
          bottom: false,
          child: GestureDetector(
            onTap: (){
              context.unFocus();
              // model.isSignupUserNameInFocus = false;
              // model.isSignupEmailInFocus = false;
              // model.isSignupPasswordInFocus = false;
              // model.isSignupMobileInFocus = false;
              // model.notifyListeners();
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 6.h,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          child: BackArrow()
                      )
                  ),
                  // SizedBox(
                  //   height: 1.4.h,
                  // ),
                  // Expanded(
                  //   child: SingleChildScrollView(
                  //     child: Column(
                  //       children: [
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 3.0.h,
                                ),
                                Container(
                                  child: Text(
                                    "Create New Password",
                                    style: TextStyle(
                                      fontFamily: FontUtils.avertaBold,
                                      fontSize: 3.05.t,
                                      color: ColorUtils.blueColor,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 3.h,),
                                Text("Your new password must be different with your previous used passwords.",
                                  style: TextStyle(
                                    height: 1.2,
                                    fontFamily: FontUtils.avertaDemoRegular,
                                    fontSize: 1.8.t,
                                    color: ColorUtils.darkText,
                                  ),
                                ),
                                SizedBox(height: 4.8.h,),
                                Text(
                                  "New Password",
                                  style: TextStyle(
                                    fontFamily: FontUtils.avertaSemiBold,
                                    fontSize: 1.6.t,
                                    color: ColorUtils.blueColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Container(
                                  height: 6.5.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      6,
                                    ),
                                  ),
                                  child: TextField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(16),
                                    ],
                                    //focusNode: model.signupPasswordFocus,
                                    style: TextStyle(
                                        fontFamily: FontUtils.avertaSemiBold,
                                        fontSize: 2.5.t,
                                        color: ColorUtils.darkBlue
                                    ),
                                    controller: model.resetNewPasswordController,
                                    obscureText: model.createNewPasswordVisible,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(model.createNewPasswordVisible ? Icons.visibility_off : Icons.visibility, color: ColorUtils.blueColor, size: 6.5.i,),
                                        onPressed: () {
                                          model.createNewPasswordVisible = !model.createNewPasswordVisible;
                                          model.notifyListeners();
                                        },
                                      ),
                                      // prefixIconConstraints: BoxConstraints(
                                      //   minWidth: 1.5.w,
                                      //   minHeight: 1.5.h,
                                      // ),
                                      //contentPadding: EdgeInsets.only(top: 3.h, bottom: 0.5.h,right: 2.w),
                                      isDense: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color:ColorUtils.blueColor),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: ColorUtils.blueColor),
                                        borderRadius: BorderRadius.circular(
                                          6,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: 2.2.h,
                                ),
                                Text(
                                  "Confirm New Password",
                                  style: TextStyle(
                                    fontFamily: FontUtils.avertaSemiBold,
                                    fontSize: 1.6.t,
                                    color: ColorUtils.blueColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Container(
                                  height: 6.5.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      6,
                                    ),
                                  ),
                                  child: TextField(
                                    //focusNode: model.signupPasswordFocus,
                                    style: TextStyle(
                                        fontFamily: FontUtils.avertaSemiBold,
                                        fontSize: 2.5.t,
                                        color: ColorUtils.darkBlue
                                    ),
                                    controller: model.resetConfirmNewPasswordController,
                                    obscureText: model.createConfirmPasswordVisible,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(model.createConfirmPasswordVisible ? Icons.visibility_off : Icons.visibility, color: ColorUtils.blueColor, size: 6.5.i,),
                                        onPressed: () {
                                          model.createConfirmPasswordVisible = !model.createConfirmPasswordVisible;
                                          model.notifyListeners();
                                        },
                                      ),
                                      // prefixIconConstraints: BoxConstraints(
                                      //   minWidth: 1.5.w,
                                      //   minHeight: 1.5.h,
                                      // ),
                                      //contentPadding: EdgeInsets.only(top: 3.h, bottom: 0.5.h,right: 2.w),
                                      isDense: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color:ColorUtils.blueColor),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: ColorUtils.blueColor),
                                        borderRadius: BorderRadius.circular(
                                          6,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 7.3.h,
                                ),
                                Container(
                                  height: 5.h,
                                  child: Center(
                                    child:  model.errorMessage != null
                                        ? Text(
                                      model.errorMessage!,
                                      style: TextStyle(
                                        fontFamily: FontUtils.avertaSemiBold,
                                        color: ColorUtils.red,
                                        fontSize: 1.8.t,
                                      ),
                                      maxLines: null,
                                      textAlign: TextAlign.center,
                                    )
                                        : Container(),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                  ),
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 400),
                                    width: MediaQuery.of(context).size.width / 1,
                                    height: 6.5.h,
                                    //margin: EdgeInsets.symmetric(horizontal: 5.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: ColorUtils.blueColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorUtils.blueColor.withOpacity(0.25),
                                          spreadRadius: 0,
                                          blurRadius: 10,
                                          offset: Offset(0, 5), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: MaterialButton(
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                      onPressed: (){
                                        model.resetNewPassword();
                                      },
                                      child: model.resettingPassword == false ?
                                      Text(
                                        "Reset Password",
                                        style: TextStyle(
                                            fontFamily: FontUtils.avertaSemiBold,
                                            fontSize: 2.2.t,
                                            color: Colors.white),
                                      ) : Loader(),
                                    ),
                                  ),

                                  // MaterialButton(
                                  //     onPressed: onButtonPressed,
                                  //   color: ColorUtils.greenColor,
                                  //   minWidth: MediaQuery.of(context).size.width /1,
                                  //   height: 7.h,
                                  //   textColor: Colors.white,
                                  //   shape: RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.circular(6.0),
                                  //   ),
                                  //   // style: ElevatedButton.styleFrom(
                                  //   //     primary: ColorUtils.greenColor,
                                  //   //     shadowColor: ColorUtils.greenColor.withOpacity(0.25),
                                  //   //     shape: RoundedRectangleBorder(
                                  //   //         borderRadius: BorderRadius.circular(10.0)),
                                  //   //     minimumSize: Size(MediaQuery.of(context).size.width /1, 7.h),
                                  //   //   ),
                                  //     child: Text(
                                  //       textValue!,
                                  //       textAlign: TextAlign.center,
                                  //       style: TextStyle(
                                  //         fontFamily: FontUtils.avertaSemiBold,
                                  //         fontSize: 2.2.t,
                                  //         color: Colors.white,
                                  //       ),
                                  //     ),
                                  // ),
                                ),
                                // CustomButton(
                                //   onButtonPressed:
                                //       () {
                                //     model.createNewPassword();
                                //     // Navigator.push(
                                //     //     context,
                                //     //     PageTransition(
                                //     //         type: PageTransitionType.fade,
                                //     //         child: LogIn()));
                                //   },
                                //   textValue: "Reset Password",
                                //   height: 6.5,
                                // ),
                                SizedBox(
                                  height: 4.5.h,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
