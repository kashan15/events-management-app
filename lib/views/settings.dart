import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/widgets/app_localization.dart';
import 'package:democratic_unity/widgets/custom_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  int groupValue = -1;

  @override
  Widget build(BuildContext context) {
    final List<String> languages = [
      AppLocalizations.of(context)?.translate("spanish")??"",
      AppLocalizations.of(context)?.translate("english")??"",
    ];
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
              //margin: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: context.getPadding().top,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 2.5.w, right: 4.w),
                    child: Row(
                      children: [
                        IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            icon: SvgPicture.asset(
                              ImageUtils.backCupertino,
                              color: ColorUtils.darkText,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          "Settings",
                          style: TextStyle(
                            fontFamily: FontUtils.avertaBold,
                            fontSize: 3.t,
                            color: ColorUtils.darkText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Push Notifications",
                          style: TextStyle(
                            fontFamily: FontUtils.avertaBold,
                            fontSize: 2.t,
                            color: ColorUtils.darkText,
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: ColorUtils.blueColor),
                          ),
                          child: Padding(
                            padding:EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.7.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(model.notificationSwitchValue == true ? "On" : "Off",
                                  style: TextStyle(
                                    fontFamily: FontUtils.avertaBold,
                                    fontSize: 2.t,
                                    color: ColorUtils.blueColor,
                                  ),
                                ),
                                CustomSwitch(
                                  activeTrackColor: ColorUtils.blueColor,
                                  activeColor: ColorUtils.thumbColor,
                                  value: model.notificationSwitchValue,
                                  onChanged: (value) {
                                    setState(() {
                                      model.notificationSwitchValue = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 3.h,),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: ColorUtils.blueColor),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding:EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.7.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Receiving Messages",
                                      style: TextStyle(
                                        fontFamily: FontUtils.avertaBold,
                                        fontSize: 2.t,
                                        color: ColorUtils.blueColor,
                                      ),
                                    ),
                                    CustomSwitch(
                                      activeTrackColor: ColorUtils.blueColor,
                                      activeColor: ColorUtils.thumbColor,
                                      value: model.receivingMessagesSwitchValue,
                                      onChanged: (value) {
                                        setState(() {
                                          model.receivingMessagesSwitchValue = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: ColorUtils.dividerColor,
                              ),
                              Padding(
                                padding:EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.7.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("New Events",
                                      style: TextStyle(
                                        fontFamily: FontUtils.avertaBold,
                                        fontSize: 2.t,
                                        color: ColorUtils.blueColor,
                                      ),
                                    ),
                                    CustomSwitch(
                                      activeTrackColor: ColorUtils.blueColor,
                                      activeColor: ColorUtils.thumbColor,
                                      value: model.newEventsSwitchValue,
                                      onChanged: (value) {
                                        setState(() {
                                          model.newEventsSwitchValue = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.h,),
                        // Text("Change Language",
                        //   style: TextStyle(
                        //     fontFamily: FontUtils.avertaBold,
                        //     fontSize: 2.t,
                        //     color: ColorUtils.darkText,
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 2.h,
                        // ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     shape: BoxShape.rectangle,
                        //     borderRadius: BorderRadius.circular(6),
                        //     border: Border.all(color: ColorUtils.blueColor),
                        //   ),
                        //   child: Padding(
                        //     padding:EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
                        //     child: Container(
                        //       //height: 200.0,
                        //       child: ListView.builder(
                        //         padding: EdgeInsets.zero,
                        //         shrinkWrap: true,
                        //         itemCount: languages.length,
                        //         itemBuilder: (context, index) {
                        //           return RadioListTile(
                        //             contentPadding: EdgeInsets.zero,
                        //             value: index,
                        //             groupValue: model.languageSelected,
                        //             title: Text(languages[index],
                        //               style: TextStyle(
                        //                 fontFamily: FontUtils.avertaBold,
                        //                 fontSize: 2.t,
                        //                 color: ColorUtils.blueColor,
                        //               ),
                        //             ),
                        //             onChanged: (dynamic value) async{
                        //               SharedPreferences prefs = await SharedPreferences.getInstance();
                        //               model.languageSelected = value;
                        //               if (model.languageSelected == 0) {
                        //                 model.appLanguage.changeLanguage(Locale('es'));
                        //                 prefs.setInt('languageSelected', model.languageSelected!);
                        //               } else if (model.languageSelected == 1) {
                        //                 model.appLanguage.changeLanguage(Locale('en'));
                        //                 prefs.setInt('languageSelected', model.languageSelected!);
                        //               }
                        //               //model.notifyListeners();
                        //             },
                        //           );
                        //         },
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
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
