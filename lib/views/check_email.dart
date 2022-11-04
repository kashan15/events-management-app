import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/reset_password.dart';
import 'package:democratic_unity/views/forgot_password_otp.dart';
import 'package:democratic_unity/widgets/back_arrow.dart';
import 'package:democratic_unity/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:democratic_unity/utils/extensions.dart';

class CheckEmail extends StatelessWidget {
  const CheckEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model){
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
              body: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  children: [
                    SizedBox(height: 6.h,),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          //margin: EdgeInsets.symmetric(horizontal: 4.w),
                            child: BackArrow()
                        )
                    ),
                    SizedBox(height: 3.0.h,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(16.0)),
                              color: ColorUtils.checkEmailContainerBg
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.i),
                              child: SvgPicture.asset(ImageUtils.email),
                            ),
                          ),
                          SizedBox(height: 3.h,),
                          Text("Check Your Email",
                          style: TextStyle(
                            fontFamily: FontUtils.avertaBold,
                            fontSize: 3.t,
                            color: ColorUtils.blueColor,
                          ),
                          ),
                          SizedBox(height: 2.0.h,),
                          Text("We have sent a password recover instruction to your email.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: FontUtils.avertaDemoRegular,
                              fontSize: 1.8.t,
                              color: ColorUtils.darkText,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          CustomButton(
                            onButtonPressed:
                                () {
                              model.navigationService.navigateTo(to: ForgotPasswordOTP());
                            },
                            textValue: "Continue",
                            height: 6.5,
                          ),
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
          ),
        );
      },
    );
  }
}
