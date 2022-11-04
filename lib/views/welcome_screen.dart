import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/login.dart';
import 'package:democratic_unity/views/signup.dart';
import 'package:democratic_unity/widgets/app_localization.dart';
import 'package:democratic_unity/widgets/button_without_background.dart';
import 'package:democratic_unity/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model){
      },
      builder: (context, model, child) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  SvgPicture.asset(ImageUtils.udemLogo),
                  SizedBox(height: 5.5.h,),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: AppLocalizations.of(context)!.translate("welcome_to") ?? "",
                          style: TextStyle(
                            fontFamily: FontUtils.avertaBold,
                            fontSize: 2.3.t,
                            color: ColorUtils.darkText,
                          ),
                        ),
                        TextSpan(
                          text: ' UDEM',
                          style: TextStyle(
                            fontFamily: FontUtils.avertaBold,
                            fontSize: 2.3.t,
                            color: ColorUtils.blueColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin maximus ac arcu nec tristique. Etiam lobortis, nisl a maximus congue, libero risus convallis quam, vitae feugiat tellus diam non augue.",
                  style: TextStyle(
                    fontFamily: FontUtils.avertaDemoRegular,
                    fontSize: 1.8.t,
                    color: ColorUtils.darkText,
                    height: 0.18.h,
                  ),
                  ),
                  SizedBox(height: 6.h,),
                  CustomButton(
                    textValue: "Log In",
                    height: 6.5,
                    onButtonPressed: (){
                      model.navigationService.navigateTo(to: Login());
                    },
                  ),
                  SizedBox(height: 5.h,),
                  ButtonWithoutBg(
                    textValue: "Sign Up",
                    height: 6.5,
                    onButtonPressed: (){
                      model.navigationService.navigateTo(to: Signup());
                    },
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
