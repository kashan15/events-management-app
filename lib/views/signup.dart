import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/login.dart';
import 'package:democratic_unity/widgets/back_arrow.dart';
import 'package:democratic_unity/widgets/custom_button.dart';
import 'package:democratic_unity/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stacked/stacked.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model){
        //model.initialize();
        // model.onSignupUserNameFocus();
        // model.onSignupEmailFocus();
        // model.onSignupPasswordFocus();
        // model.onSignupMobileFocus();
        model.signupPasswordController.clear();
      },
      builder: (context, model, child) {
        return SafeArea(
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
                                    "Sign Up",
                                    style: TextStyle(
                                      fontFamily: FontUtils.avertaBold,
                                      fontSize: 3.05.t,
                                      color: ColorUtils.blueColor,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 3.h,),
                                // Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin maximus ac arcu nec tristique.",
                                // style: TextStyle(
                                //   height: 1.2,
                                //   fontFamily: FontUtils.avertaDemoRegular,
                                //   fontSize: 1.8.t,
                                //   color: ColorUtils.darkText,
                                // ),
                                // ),
                                //SizedBox(height: 4.8.h,),
                                Text(
                                  "Phone Number",
                                  style: TextStyle(
                                    fontFamily: FontUtils.avertaSemiBold,
                                    fontSize: 1.6.t,
                                    color: ColorUtils.blueColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.2.h,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 3.w,top: 0.h,bottom: 0.h),
                                  height: 6.25.h,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(
                                        6,
                                      ),
                                      border: Border.all(color: ColorUtils.blueColor)
                                  ),
                                  child: IntlPhoneField(
                                    textAlignVertical: TextAlignVertical.center,
                                    //countryCodeTextColor: ColorUtils.darkBlue,
                                    //controller: model.signupPhoneController,

                                    // controller: TextEditingController(text: '${model.phoneNo}'),

                                    autovalidateMode: AutovalidateMode.disabled,
                                    dropdownIconPosition: IconPosition.trailing,
                                    //dropDownIcon: Icon(Icons.),
                                    //showDropdownIcon: false,
                                    style: TextStyle(
                                        fontFamily: FontUtils.avertaSemiBold,
                                        fontSize: 2.5.t,
                                        color: ColorUtils.darkBlue
                                    ),
                                    //autoValidate: false,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      suffixText: "",
                                      isDense: true,
                                      alignLabelWithHint: true,
                                      counterText: "",
                                      contentPadding: EdgeInsets.only(top: 0.h,left: 0.w,right: 0.w,bottom: 0.h),
                                      focusedBorder: InputBorder.none,
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 0.0.t,
                                      ),
                                      //alignLabelWithHint: true,
                                      //contentPadding: EdgeInsets.zero,
                                      //labelText: 'Phone Number',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    onTap: (){},
                                    initialCountryCode: 'PE',
                                    onChanged: (phone) {
                                      model.signupCountryCode = phone.countryCode ;
                                      model.signupPhoneController.text = phone.number;
                                      model.completeSignupPhoneNumber.text = phone.completeNumber;
                                      model.notifyListeners();
                                    },
                                  ),
                                ),
                                // Container(
                                //   height: 6.5.h,
                                //   decoration: BoxDecoration(
                                //     shape: BoxShape.rectangle,
                                //     color: Colors.white,
                                //     borderRadius: BorderRadius.circular(
                                //       6,
                                //     ),
                                //   ),
                                //   //margin: EdgeInsets.only(top: 2.7.h,right: 3.5.w,left: 3.5.w),
                                //   child: TextField(
                                //     //focusNode: model.signupUserNameFocus,
                                //     style: TextStyle(
                                //         fontFamily: FontUtils.avertaDemoRegular,
                                //         fontSize: 2.5.t,
                                //         color: ColorUtils.darkBlue
                                //     ),
                                //     controller: model.signupUserNameController,
                                //     obscureText: false,
                                //     decoration: InputDecoration(
                                //       //contentPadding: EdgeInsets.only(top: 3.h, bottom: 0.5.h,right: 2.w),
                                //       isDense: true,
                                //       enabledBorder: OutlineInputBorder(
                                //         borderSide: BorderSide(color:ColorUtils.blueColor),
                                //         borderRadius: BorderRadius.circular(6),
                                //       ),
                                //       focusedBorder: OutlineInputBorder(
                                //         borderSide: BorderSide(color: ColorUtils.blueColor),
                                //         borderRadius: BorderRadius.circular(
                                //           6,
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),

                                ///Last commented out
                                /*SizedBox(
                                  height: 2.2.h,
                                ),
                                Text(
                                  "Email",
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
                                    //focusNode: model.signupEmailFocus,
                                    style: TextStyle(
                                        fontFamily: FontUtils.avertaSemiBold,
                                        fontSize: 2.5.t,
                                        color: ColorUtils.darkBlue
                                    ),
                                    controller: model.signupEmailController,
                                    obscureText: false,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
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
                                  "Password",
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
                                    controller: model.signupPasswordController,
                                    obscureText: model.signupPasswordVisible,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(model.signupPasswordVisible ? Icons.visibility_off : Icons.visibility, color: ColorUtils.blueColor, size: 6.5.i,),
                                        onPressed: () {
                                          model.signupPasswordVisible = !model.signupPasswordVisible;
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
                                ),*/

                                SizedBox(
                                  height: 2.2.h,
                                ),
                                // Text(
                                //   "Confirm Password",
                                //   style: TextStyle(
                                //     fontFamily: FontUtils.avertaSemiBold,
                                //     fontSize: 1.6.t,
                                //     color: ColorUtils.blueColor,
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 1.h,
                                // ),
                                // Container(
                                //   height: 6.5.h,
                                //   decoration: BoxDecoration(
                                //     shape: BoxShape.rectangle,
                                //     color: Colors.white,
                                //     borderRadius: BorderRadius.circular(
                                //       6,
                                //     ),
                                //   ),
                                //   child: TextField(
                                //     //focusNode: model.signupPasswordFocus,
                                //     style: TextStyle(
                                //         fontFamily: FontUtils.avertaSemiBold,
                                //         fontSize: 2.5.t,
                                //         color: ColorUtils.darkBlue
                                //     ),
                                //     controller: model.signupConfirmPasswordController,
                                //     obscureText: model.signupConfirmPasswordVisible,
                                //     decoration: InputDecoration(
                                //       suffixIcon: IconButton(
                                //         icon: Icon(model.signupConfirmPasswordVisible ? Icons.visibility_off : Icons.visibility, color: ColorUtils.blueColor, size: 6.5.i,),
                                //         onPressed: () {
                                //           model.signupConfirmPasswordVisible = !model.signupConfirmPasswordVisible;
                                //           model.notifyListeners();
                                //         },
                                //       ),
                                //       // prefixIconConstraints: BoxConstraints(
                                //       //   minWidth: 1.5.w,
                                //       //   minHeight: 1.5.h,
                                //       // ),
                                //       //contentPadding: EdgeInsets.only(top: 3.h, bottom: 0.5.h,right: 2.w),
                                //       isDense: true,
                                //       enabledBorder: OutlineInputBorder(
                                //         borderSide: BorderSide(color:ColorUtils.blueColor),
                                //         borderRadius: BorderRadius.circular(6),
                                //       ),
                                //       focusedBorder: OutlineInputBorder(
                                //         borderSide: BorderSide(color: ColorUtils.blueColor),
                                //         borderRadius: BorderRadius.circular(
                                //           6,
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                SizedBox(
                                  height: 4.h,
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
                                        model.signUpScreen();
                                      },
                                      child: model.checkUser == false ?
                                      Text(
                                        "Sign Up",
                                        style: TextStyle(
                                            fontFamily: FontUtils.avertaSemiBold,
                                            fontSize: 2.2.t,
                                            color: Colors.white),
                                      ) : Loader(),
                                    ),
                                  ),
                                ),
                                // CustomButton(
                                //   onButtonPressed:
                                //       () {
                                //     model.signUpScreen();
                                //     // Navigator.push(
                                //     //     context,
                                //     //     PageTransition(
                                //     //         type: PageTransitionType.fade,
                                //     //         child: LogIn()));
                                //   },
                                //   textValue: "Sign Up",
                                //   height: 6.5,
                                // ),
                                SizedBox(
                                  height: 4.5.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Already have an account?",
                                      style: TextStyle(
                                        fontFamily: FontUtils.avertaSemiBold,
                                        fontSize: 2.0.t,
                                        color: ColorUtils.darkBlue,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        //Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:  LogIn()));
                                        model.navigationService.navigateTo(to: Login());
                                      },
                                      child: Text(" Log In",
                                        style: TextStyle(
                                          fontFamily: FontUtils.avertaSemiBold,
                                          fontSize: 2.0.t,
                                          color: ColorUtils.yellowColor,
                                        ),
                                      ),
                                    ),
                                  ],
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
