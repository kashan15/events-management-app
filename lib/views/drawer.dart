import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/dontate.dart';
import 'package:democratic_unity/profile/my_profile.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/AllEvents/all_events.dart';
import 'package:democratic_unity/views/FeedBack/feedback.dart';
import 'package:democratic_unity/views/Survey/survey.dart';
import 'package:democratic_unity/views/Volunteer/volunteer.dart';
import 'package:democratic_unity/views/admin_chat.dart';
import 'package:democratic_unity/views/events/events.dart';
import 'package:democratic_unity/views/login.dart';
import 'package:democratic_unity/views/settings.dart';
import 'package:democratic_unity/widgets/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stacked/stacked.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      onModelReady: (model){
        model.myProfileSelected = false;
        model.donateSelected = false;
        model.volunteerSelected = false;
        model.eventsSelected = false;
        model.surveySelected = false;
        model.settingsSelected = false;
        model.contactUsSelected = false;
        model.feedbackSelected = false;
        model.signOutSelected = false;
      },
      builder: (context, model , child ) {
        return Container(
          width: MediaQuery.of(context).size.width/1.15,
          child: Drawer(
            child: FadedSlideAnimation(
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
              child: SafeArea(
                top: false,
                bottom: false,
                child: Scaffold(
                  backgroundColor: ColorUtils.blueColor,
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.h,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.0.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                            child:
                            //model.prefs!.getString("profilePic") != "" ?
                            model.getUserprofilePic != "" ?
                                CachedNetworkImage(
                                    imageUrl: model.getUserprofilePic!,
                                  errorWidget: (context, url, error) => new Image.asset(ImageUtils.error),
                                  fit: BoxFit.cover,
                                  width: 20.i,
                                  height: 20.i,
                                  placeholder: (context, url) => Image.asset(ImageUtils.userProfile,fit: BoxFit.cover,height: 37.i),
                                )
                                :
                          Image.asset(ImageUtils.profilePicture,
                            width: 20.i,
                            height: 20.i,
                          ),
                        ),
                      ),
                      SizedBox(height: 2.25.h,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.0.w),
                        child: Text(
                          //"",
                        model.fName??'',
                        style: TextStyle(
                          fontFamily: FontUtils.avertaBold,
                          fontSize: 2.2.t,
                          color: Colors.white
                        ),
                        ),
                      ),
                      SizedBox(height: 3.h,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.0.w),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: (){
                                model.myProfileSelected = true;
                                model.donateSelected = false;
                                model.volunteerSelected = false;
                                model.eventsSelected = false;
                                model.surveySelected = false;
                                model.settingsSelected = false;
                                model.contactUsSelected = false;
                                model.feedbackSelected = false;
                                model.signOutSelected = false;
                                Navigator.of(context).pop();
                                Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:MyProfile()));
                                model.notifyListeners();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: model.myProfileSelected == true ? ColorUtils.darkBlue : ColorUtils.blueColor,
                                    borderRadius: BorderRadius.all(Radius.circular(6))
                                ),
                                child: Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.8.h),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(ImageUtils.profileIcon),
                                      SizedBox(width: 3.w,),
                                      Text(
                                        AppLocalizations.of(context)!.translate("my_profile") ?? "",
                                        style: TextStyle(
                                          fontFamily: FontUtils.avertaDemoRegular,
                                          fontSize: 2.1.t,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 0.7.h,),
                            InkWell(
                              onTap: (){
                                model.myProfileSelected = false;
                                model.donateSelected = true;
                                model.volunteerSelected = false;
                                model.eventsSelected = false;
                                model.surveySelected = false;
                                model.settingsSelected = false;
                                model.contactUsSelected = false;
                                model.feedbackSelected = false;
                                model.signOutSelected = false;
                                Navigator.of(context).pop();
                                Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:Donate()));
                                //model.donation();
                                model.notifyListeners();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: model.donateSelected == true ? ColorUtils.darkBlue : ColorUtils.blueColor,
                                    borderRadius: BorderRadius.all(Radius.circular(6))
                                ),
                                child: Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.8.h),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(ImageUtils.donate),
                                      SizedBox(width: 3.w,),
                                      Text(
                                        AppLocalizations.of(context)!.translate("donate") ?? "",
                                        style: TextStyle(
                                          fontFamily: FontUtils.avertaDemoRegular,
                                          fontSize: 2.1.t,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 0.7.h,),
                            InkWell(
                              onTap: (){
                                model.myProfileSelected = false;
                                model.donateSelected = false;
                                model.volunteerSelected = true;
                                model.eventsSelected = false;
                                model.surveySelected = false;
                                model.settingsSelected = false;
                                model.contactUsSelected = false;
                                model.feedbackSelected = false;
                                model.signOutSelected = false;
                                Navigator.of(context).pop();
                                Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:Volunteer()));
                                model.notifyListeners();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: model.volunteerSelected == true ? ColorUtils.darkBlue : ColorUtils.blueColor,
                                    borderRadius: BorderRadius.all(Radius.circular(6))
                                ),
                                child: Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.8.h),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(ImageUtils.volunteer),
                                      SizedBox(width: 3.w,),
                                      Text(
                                        AppLocalizations.of(context)!.translate("volunteer") ?? "",
                                        style: TextStyle(
                                          fontFamily: FontUtils.avertaDemoRegular,
                                          fontSize: 2.1.t,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 0.7.h,),
                            InkWell(
                              onTap: (){
                                model.myProfileSelected = false;
                                model.donateSelected = false;
                                model.volunteerSelected = false;
                                model.eventsSelected = true;
                                model.surveySelected = false;
                                model.settingsSelected = false;
                                model.contactUsSelected = false;
                                model.feedbackSelected = false;
                                model.signOutSelected = false;
                                Navigator.of(context).pop();
                                Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:AllEvents()));
                                model.notifyListeners();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: model.eventsSelected == true ? ColorUtils.darkBlue : ColorUtils.blueColor,
                                    borderRadius: BorderRadius.all(Radius.circular(6))
                                ),
                                child: Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.8.h),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(ImageUtils.events),
                                      SizedBox(width: 3.w,),
                                      Text(
                                        AppLocalizations.of(context)!.translate("events") ?? "",
                                        style: TextStyle(
                                          fontFamily: FontUtils.avertaDemoRegular,
                                          fontSize: 2.1.t,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 0.7.h,),
                            InkWell(
                              onTap: (){
                                model.myProfileSelected = false;
                                model.donateSelected = false;
                                model.volunteerSelected = false;
                                model.eventsSelected = false;
                                model.surveySelected = true;
                                model.settingsSelected = false;
                                model.contactUsSelected = false;
                                model.feedbackSelected = false;
                                model.signOutSelected = false;
                                Navigator.of(context).pop();
                                Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:Survey()));
                                model.notifyListeners();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: model.surveySelected == true ? ColorUtils.darkBlue : ColorUtils.blueColor,
                                    borderRadius: BorderRadius.all(Radius.circular(6))
                                ),
                                child: Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.8.h),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(ImageUtils.survey),
                                      SizedBox(width: 3.w,),
                                      Text(
                                        AppLocalizations.of(context)!.translate("survey") ?? "",
                                        style: TextStyle(
                                          fontFamily: FontUtils.avertaDemoRegular,
                                          fontSize: 2.1.t,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 0.7.h,),
                            InkWell(
                              onTap: (){
                                model.myProfileSelected = false;
                                model.donateSelected = false;
                                model.volunteerSelected = false;
                                model.eventsSelected = false;
                                model.surveySelected = false;
                                model.settingsSelected = true;
                                model.contactUsSelected = false;
                                model.feedbackSelected = false;
                                model.signOutSelected = false;
                                Navigator.of(context).pop();
                                Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:Settings()));
                                model.notifyListeners();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: model.settingsSelected == true ? ColorUtils.darkBlue : ColorUtils.blueColor,
                                    borderRadius: BorderRadius.all(Radius.circular(6))
                                ),
                                child: Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.8.h),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(ImageUtils.settings),
                                      SizedBox(width: 3.w,),
                                      Text(
                                        AppLocalizations.of(context)!.translate("settings") ?? "",
                                        style: TextStyle(
                                          fontFamily: FontUtils.avertaDemoRegular,
                                          fontSize: 2.1.t,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 0.7.h,),
                            InkWell(
                              onTap: (){
                                model.myProfileSelected = false;
                                model.donateSelected = false;
                                model.volunteerSelected = false;
                                model.eventsSelected = false;
                                model.surveySelected = false;
                                model.settingsSelected = false;
                                model.contactUsSelected = true;
                                model.feedbackSelected = false;
                                model.signOutSelected = false;
                                Navigator.of(context).pop();
                                Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:AdminChat()));
                                model.notifyListeners();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: model.contactUsSelected == true ? ColorUtils.darkBlue : ColorUtils.blueColor,
                                    borderRadius: BorderRadius.all(Radius.circular(6))
                                ),
                                child: Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.8.h),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(ImageUtils.emailDrawer),
                                      SizedBox(width: 3.w,),
                                      Text(
                                        AppLocalizations.of(context)!.translate("contact_us") ?? "",
                                        style: TextStyle(
                                          fontFamily: FontUtils.avertaDemoRegular,
                                          fontSize: 2.1.t,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 0.7.h,),
                            InkWell(
                              onTap: (){
                                model.myProfileSelected = false;
                                model.donateSelected = false;
                                model.volunteerSelected = false;
                                model.eventsSelected = false;
                                model.surveySelected = false;
                                model.settingsSelected = false;
                                model.contactUsSelected = false;
                                model.feedbackSelected = true;
                                model.signOutSelected = false;
                                Navigator.of(context).pop();
                                Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:FeedBack()));
                                model.notifyListeners();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: model.feedbackSelected == true ? ColorUtils.darkBlue : ColorUtils.blueColor,
                                    borderRadius: BorderRadius.all(Radius.circular(6))
                                ),
                                child: Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.8.h),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(ImageUtils.feedback),
                                      SizedBox(width: 3.w,),
                                      Text(
                                        AppLocalizations.of(context)!.translate("feedback") ?? "",
                                        style: TextStyle(
                                          fontFamily: FontUtils.avertaDemoRegular,
                                          fontSize: 2.1.t,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 0.7.h,),
                            InkWell(
                              onTap: ()async{
                                await model.uploadStatus(false);
                                model.myProfileSelected = false;
                                model.donateSelected = false;
                                model.volunteerSelected = false;
                                model.eventsSelected = false;
                                model.surveySelected = false;
                                model.settingsSelected = false;
                                model.contactUsSelected = false;
                                model.feedbackSelected = false;
                                model.signOutSelected = true;
                                // model.loginPhoneController.clear();
                                // model.loginPasswordController.clear();
                                model.removeData(context);
                                //model.navigationService.navigateTo(to: Login());
                                //model.notifyListeners();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: model.signOutSelected == true ? ColorUtils.darkBlue : ColorUtils.blueColor,
                                    borderRadius: BorderRadius.all(Radius.circular(6))
                                ),
                                child: Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.8.h),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(ImageUtils.signOut),
                                      SizedBox(width: 3.w,),
                                      Text(
                                        AppLocalizations.of(context)!.translate("sign_out") ?? "",
                                        style: TextStyle(
                                          fontFamily: FontUtils.avertaDemoRegular,
                                          fontSize: 2.1.t,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
    );
  }
}
