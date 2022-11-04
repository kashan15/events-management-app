import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/enter_details.dart';
import 'package:democratic_unity/views/login.dart';
import 'package:democratic_unity/views/main_view.dart';
import 'package:democratic_unity/widgets/back_arrow.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:stacked/stacked.dart';
import 'package:democratic_unity/utils/extensions.dart';

class SignUpOTPScreen extends StatelessWidget {
  const SignUpOTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model){
        model.getSignupVerificationCode();
        model.signupCodeController.clear();
        model.signupOtpStartTimer();
        model.SignupStart = 30;
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
              body: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 6.h,
                      ),
                      // Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: Container(
                      //         //margin: EdgeInsets.symmetric(horizontal: 4.w),
                      //         child: BackArrow()
                      //     )
                      // ),
                      SizedBox(height: 3.0.h,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("We’ve sent you a code",
                          style: TextStyle(
                              fontFamily: FontUtils.avertaSemiBold,
                              fontSize: 3.2.t,
                              color: ColorUtils.blueColor
                          ),
                        ),
                      ),
                      SizedBox(height: 3.0.h,),
                      Text("Enter the code that you have received on your nubmer.",
                        style: TextStyle(
                            fontFamily: FontUtils.avertaDemoRegular,
                            fontSize: 1.9.t,
                            color: ColorUtils.lightDarkText
                        ),
                      ),
                      SizedBox(
                        height: 7.5.h,
                      ),
                      PinCodeTextField(
                        onDone: (value){
                          // if(model.loggedIn == false){
                          //   model.navigationService.navigateTo(to: EnterDetails());
                          // }
                          // else{
                          //   model.navigationService.navigateTo(to: MainView(index: 0));
                          // }
                          model.doingSignupVerification();
                        },
                        pinBoxOuterPadding: EdgeInsets.symmetric(horizontal: 1.5.w),
                        controller: model.signupCodeController,
                        pinTextAnimatedSwitcherTransition:
                        ProvidedPinBoxTextAnimation.scalingTransition,
                        pinTextAnimatedSwitcherDuration:
                        Duration(milliseconds: 300),
                        maxLength: 6,
                        pinBoxWidth: 12.w,
                        pinBoxRadius: 4,
                        pinBoxHeight: 12.w,
                        pinBoxColor: Colors.transparent,
                        defaultBorderColor: ColorUtils.silverColor,
                        hasTextBorderColor: ColorUtils.blueColor,
                        pinBoxBorderWidth: 1.5,
                        keyboardType: TextInputType.number,
                        pinTextStyle: TextStyle(
                          fontFamily: FontUtils.avertaSemiBold,
                          //fontWeight: FontWeight.w400,
                          fontSize: 3.t,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text("Didnt receive OTP code?",
                        style: TextStyle(
                          fontFamily: FontUtils.avertaDemoRegular,
                          fontSize: 2.t,
                          color: ColorUtils.lightDarkText,
                        ),
                      ),
                      SizedBox(
                        height: 2.5.h,
                      ),
                      if(model.SignupStart != 0)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Resend Code: ",
                            style: TextStyle(
                              fontFamily: FontUtils.avertaSemiBold,
                              color: Colors.red,
                              fontSize: 2.t,
                            ),
                          ),
                          Text(model.SignupStart.toString(),
                            style: TextStyle(
                              fontFamily: FontUtils.avertaSemiBold,
                              color: Colors.red,
                              fontSize: 2.t,
                            ),
                          ),
                        ],
                      ),
                      if(model.SignupStart == 0)
                      GestureDetector(
                        onTap: (){
                          model.resendSignupCode();
                          model.notifyListeners();
                        },
                        child: Text(
                          "Resend Code",
                          style: TextStyle(
                            fontFamily: FontUtils.avertaDemoRegular,
                                fontSize: 2.t,

                            shadows: [
                              Shadow(
                                  color: ColorUtils.blueColor,
                                  offset: Offset(0, -3))
                            ],
                            color: Colors.transparent,
                            decoration:
                            TextDecoration.underline,
                            decorationColor: ColorUtils.blueColor,
                            decorationThickness: 1,
                            decorationStyle:
                            TextDecorationStyle.solid,
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h,),
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
                      // Text("Resend Code",
                      //   style: TextStyle(
                      //     decoration: TextDecoration.underline,
                      //     decorationColor: ColorUtils.blueColor,
                      //     fontFamily: FontUtils.avertaDemoRegular,
                      //     fontSize: 2.t,
                      //     color: ColorUtils.blueColor,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
