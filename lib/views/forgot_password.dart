import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/check_email.dart';
import 'package:democratic_unity/widgets/back_arrow.dart';
import 'package:democratic_unity/widgets/custom_button.dart';
import 'package:democratic_unity/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:democratic_unity/utils/extensions.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model){
        model.forgotPasswordEmailController.clear();
        //model.initialize();
      },
      builder: (context, model, child) {
        return SafeArea(
          top: false,
          bottom: false,
          child: GestureDetector(
            onTap: (){
              context.unFocus();
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
                                    "Forgot Password",
                                    style: TextStyle(
                                      fontFamily: FontUtils.avertaBold,
                                      fontSize: 3.05.t,
                                      color: ColorUtils.blueColor,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 1.5.h,),
                                Text("Enter the email associated with your account and we’ll send an email with instruction to reset your password.",
                                  style: TextStyle(
                                    height: 1.2,
                                    fontFamily: FontUtils.avertaDemoRegular,
                                    fontSize: 1.8.t,
                                    color: ColorUtils.darkText,
                                  ),
                                ),
                                SizedBox(height: 6.h,),
                                Text(
                                  "Email Address",
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
                                  height: 6.25.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      6,
                                    ),
                                  ),
                                  child: TextField(
                                    style: TextStyle(
                                        fontFamily: FontUtils.avertaSemiBold,
                                        fontSize: 2.5.t,
                                        color: ColorUtils.darkBlue
                                    ),
                                    controller: model.forgotPasswordEmailController,
                                    obscureText: false,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
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
                                  height: 5.h,
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
                                        model.forgotPassword();
                                      },
                                      child: model.checkingUserEmail == false ?
                                      Text(
                                        "Log In",
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
                                //     model.forgotPassword();
                                //   },
                                //   textValue: "Send Instruction",
                                //   height: 6.5,
                                // ),
                                SizedBox(
                                  height: 4.h,
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
