import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/Survey/survey_preview.dart';
import 'package:democratic_unity/widgets/custom_button.dart';
import 'package:democratic_unity/widgets/loader_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stacked/stacked.dart';

class Survey extends StatelessWidget {
  const Survey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model){
        model.getTheSurvey();
        model.questions = [];
      },
      builder: (context, model, child) {
        return model.isLoading == true ? Loader2() :
          SafeArea(
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
                          "Survey",
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
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.allSurveys.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(18)),
                              border: Border.all(color: ColorUtils.blueColor),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 1.h, bottom: 3.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Stack(
                                      //   //alignment: Alignment.center,
                                      //   children: [
                                      //     Container(
                                      //       margin: EdgeInsets.only(top: 1.h,left: 0.8.w),
                                      //       //height: 6.h,
                                      //       decoration: BoxDecoration(
                                      //         color: Colors.red,
                                      //         shape: BoxShape.rectangle,
                                      //         borderRadius: BorderRadius.all(Radius.circular(6)),
                                      //         border: Border.all(color: ColorUtils.redColor),
                                      //       ),
                                      //       child: Padding(
                                      //         padding: EdgeInsets.symmetric(horizontal:6.w, vertical: 1.h),
                                      //         child: Text("Unread",
                                      //           style: TextStyle(
                                      //               fontFamily: FontUtils.avertaBold,
                                      //               fontSize: 1.7.t,
                                      //               color: Colors.white
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //     Align(
                                      //       alignment: Alignment.topLeft,
                                      //       child: Container(
                                      //         decoration:
                                      //         BoxDecoration(
                                      //           shape: BoxShape.circle,
                                      //           color: Colors.white,
                                      //         ),
                                      //         child: Padding(
                                      //           padding: const EdgeInsets.all(4.0),
                                      //           child: Container(
                                      //             decoration:
                                      //             BoxDecoration(
                                      //               shape:
                                      //               BoxShape.circle,
                                      //               color: ColorUtils.redColor,
                                      //             ),
                                      //             width: 2.5.i,
                                      //             height: 2.5.i,
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(ImageUtils.timeClock,
                                            color: ColorUtils.icon_color,
                                          ),
                                          SizedBox(width: 2.w,),
                                          Text(
                                            model.allSurveys[index].createdDtm!.substring(0,10),
                                            //"2 days ago",
                                            style: TextStyle(
                                              fontFamily: FontUtils.avertaBold,
                                              fontSize: 1.7.t,
                                              color: ColorUtils.icon_color,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 1.5.h,),
                                  Text(model.allSurveys[index].Title!,
                                    style: TextStyle(
                                        fontFamily: FontUtils.avertaSemiBold,
                                        fontSize: 2.t,
                                        color: ColorUtils.titleText
                                    ),
                                  ),
                                  SizedBox(height: 1.h,),
                                  Text(model.allSurveys[index].Description!,
                                    style: TextStyle(
                                      fontFamily: FontUtils.modernistRegular,
                                      fontSize: 1.8.t,
                                      color: ColorUtils.darkText,
                                      height: 0.15.h,
                                    ),
                                  ),
                                  SizedBox(height: 2.h,),
                                  CustomButton(
                                    onButtonPressed: (){
                                      model.selectedSurvey = model.allSurveys[index];
                                      model.currentSurveyQuestions = model.selectedSurvey!.Questions!;
                                      model.checkSurveyUser(context, model.selectedSurvey!.surveyId!, model.selectedSurvey!.Title!);
                                      model.notifyListeners();
                                      // if(model.surveyResponse == true){
                                      //   Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:SurveyPreview(
                                      //     title: model.selectedSurvey!.Title!,
                                      //   )));
                                      // }
                                      //model.showCreateEventDialog = false;
                                      //model.createEvent(context);
                                      // if(model.showCreateEventDialog == true){
                                      //   showAlertDialog(context);
                                      // }
                                    },
                                    textValue: "View Survey",
                                    height: 6.5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                        ],
                      );
                  },),
                  if(model.surveyResponse == false)
                    SizedBox(
                      height: 2.h,
                    ),
                  if(model.surveyResponse == false)
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
