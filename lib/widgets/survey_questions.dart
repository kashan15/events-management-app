import 'package:democratic_unity/Model/survey_question_of_model.dart';
import 'package:democratic_unity/Model/survey_questions_model.dart';
import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/widgets/question.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SurveyQuestions extends StatefulWidget {
  int? index;
  SurveyQuestions({this.index,Key? key}) : super(key: key);

  @override
  _SurveyQuestionsState createState() => _SurveyQuestionsState();
}

class _SurveyQuestionsState extends State<SurveyQuestions> {

  bool choice1Selected = false;
  bool choice2Selected = false;
  bool choice3Selected = false;
  bool choice4Selected = false;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model){
        model.oneOptionChosen = false;
      },
      builder: (context, model, child) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(18)),
            border: Border.all(color: ColorUtils.blueColor),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 6.w, right: 3.w, top: 2.h, bottom: 3.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Text((widget.index! + 1).toString() + ".",
                      style: TextStyle(
                        fontFamily: FontUtils.avertaSemiBold,
                        fontSize: 1.9.t,
                        color: ColorUtils.titleText,
                      ),
                    ),
                    SizedBox(width: 1.5.w,),
                    Text(
                      model.currentSurveyQuestions[widget.index!].Question!,
                      style: TextStyle(
                        fontFamily: FontUtils.avertaSemiBold,
                        fontSize: 1.9.t,
                        color: ColorUtils.titleText,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                GestureDetector(
                  onTap: (){
                    // if(widget.index == 0){
                    //   model.question1Done = true;
                    //   model.notifyListeners();
                    // }
                    // if(widget.index == 1){
                    //   model.question2Done = true;
                    //   model.notifyListeners();
                    // }
                    // model.notifyListeners();
                    model.questions!.removeWhere((element) => element.QuestionId == int.parse(model.currentSurveyQuestions[widget.index!].QuestionId!));
                    choice1Selected = true;
                    choice2Selected = false;
                    choice3Selected = false;
                    choice4Selected = false;
                    SurveyQuestionsOfModel datas = SurveyQuestionsOfModel();
                    datas.QuestionId = int.parse(model.currentSurveyQuestions[widget.index!].QuestionId!);
                    datas.UserId = int.parse(model.userId!);
                    datas.SurveyId =  int.parse(model.currentSurveyQuestions[widget.index!].surveyId!);
                    datas.Answer = model.currentSurveyQuestions[widget.index!].Option1;
                    model.questions!.add(datas);
                    model.oneOptionChosen = true;
                    model.notifyListeners();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: choice1Selected == true ? ColorUtils.dropDownButtonBg : Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: ColorUtils.icon_color),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: choice1Selected == true ? ColorUtils.blueColor : ColorUtils.icon_color,
                                  width: 0.4.w
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(1),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: choice1Selected == true ? ColorUtils.blueColor : Colors.white,
                                ),
                                height: 2.i,
                                width: 2.i,
                              ),
                            ),
                          ),
                          SizedBox(width: 2.w,),
                          Text(
                            model.currentSurveyQuestions[widget.index!].Option1!,
                            //model.allQuestions[widget.index!]["choice1"],
                            style: TextStyle(
                              fontFamily: FontUtils.modernistRegular,
                              fontSize: 1.7.t,
                              color: ColorUtils.darkText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                GestureDetector(
                  onTap: (){
                    // if(widget.index == 0){
                    //   model.question1Done = true;
                    //   model.notifyListeners();
                    // }
                    // if(widget.index == 1){
                    //   model.question2Done = true;
                    //   model.notifyListeners();
                    // }
                    model.questions!.removeWhere((element) => element.QuestionId == int.parse(model.currentSurveyQuestions[widget.index!].QuestionId!));
                    choice1Selected = false;
                    choice2Selected = true;
                    choice3Selected = false;
                    choice4Selected = false;
                    SurveyQuestionsOfModel datas = SurveyQuestionsOfModel();
                    datas.QuestionId = int.parse(model.currentSurveyQuestions[widget.index!].QuestionId!);
                    datas.UserId = int.parse(model.userId!);
                    datas.SurveyId =  int.parse(model.currentSurveyQuestions[widget.index!].surveyId!);
                    datas.Answer = model.currentSurveyQuestions[widget.index!].Option2;
                    model.questions!.add(datas);
                    model.oneOptionChosen = true;
                    model.notifyListeners();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: choice2Selected == true ? ColorUtils.dropDownButtonBg : Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: ColorUtils.icon_color),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: choice2Selected == true ? ColorUtils.blueColor : ColorUtils.icon_color,
                                  width: 0.4.w
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(1),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: choice2Selected == true ? ColorUtils.blueColor : Colors.white,
                                ),
                                height: 2.i,
                                width: 2.i,
                              ),
                            ),
                          ),
                          SizedBox(width: 2.w,),
                          Text(model.currentSurveyQuestions[widget.index!].Option2!,
                            style: TextStyle(
                              fontFamily: FontUtils.modernistRegular,
                              fontSize: 1.7.t,
                              color: ColorUtils.darkText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                GestureDetector(
                  onTap: (){
                    // if(widget.index == 0){
                    //   model.question1Done = true;
                    //   model.notifyListeners();
                    // }
                    // if(widget.index == 1){
                    //   model.question2Done = true;
                    //   model.notifyListeners();
                    // }
                    model.questions!.removeWhere((element) => element.QuestionId == int.parse(model.currentSurveyQuestions[widget.index!].QuestionId!));
                    choice1Selected = false;
                    choice2Selected = false;
                    choice3Selected = true;
                    choice4Selected = false;
                    SurveyQuestionsOfModel datas = SurveyQuestionsOfModel();
                    datas.QuestionId = int.parse(model.currentSurveyQuestions[widget.index!].QuestionId!);
                    datas.UserId = int.parse(model.userId!);
                    datas.SurveyId =  int.parse(model.currentSurveyQuestions[widget.index!].surveyId!);
                    datas.Answer = model.currentSurveyQuestions[widget.index!].Option3;
                    model.questions!.add(datas);
                    model.oneOptionChosen = true;
                    model.notifyListeners();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: choice3Selected == true ? ColorUtils.dropDownButtonBg : Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: ColorUtils.icon_color),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: choice3Selected == true ? ColorUtils.blueColor : ColorUtils.icon_color,
                                  width: 0.4.w
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(1),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: choice3Selected == true ? ColorUtils.blueColor : Colors.white,
                                ),
                                height: 2.i,
                                width: 2.i,
                              ),
                            ),
                          ),
                          SizedBox(width: 2.w,),
                          Text(model.currentSurveyQuestions[widget.index!].Option3!,
                            style: TextStyle(
                              fontFamily: FontUtils.modernistRegular,
                              fontSize: 1.7.t,
                              color: ColorUtils.darkText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                GestureDetector(
                  onTap: (){
                    // if(widget.index == 0){
                    //   model.question1Done = true;
                    //   model.notifyListeners();
                    // }
                    // if(widget.index == 1){
                    //   model.question2Done = true;
                    //   model.notifyListeners();
                    // }
                    model.questions!.removeWhere((element) => element.QuestionId == int.parse(model.currentSurveyQuestions[widget.index!].QuestionId!));
                    choice1Selected = false;
                    choice2Selected = false;
                    choice3Selected = false;
                    choice4Selected = true;
                    SurveyQuestionsOfModel datas = SurveyQuestionsOfModel();
                    datas.QuestionId = int.parse(model.currentSurveyQuestions[widget.index!].QuestionId!);
                    datas.UserId = int.parse(model.userId!);
                    datas.SurveyId =  int.parse(model.currentSurveyQuestions[widget.index!].surveyId!);
                    datas.Answer = model.currentSurveyQuestions[widget.index!].Option4;
                    model.questions!.add(datas);
                    model.oneOptionChosen = true;
                    model.notifyListeners();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: choice4Selected == true ? ColorUtils.dropDownButtonBg : Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: ColorUtils.icon_color),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: choice4Selected == true ? ColorUtils.blueColor : ColorUtils.icon_color,
                                  width: 0.4.w
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(1),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: choice4Selected == true ? ColorUtils.blueColor : Colors.white,
                                ),
                                height: 2.i,
                                width: 2.i,
                              ),
                            ),
                          ),
                          SizedBox(width: 2.w,),
                          Text(model.currentSurveyQuestions[widget.index!].Option4!,
                            style: TextStyle(
                              fontFamily: FontUtils.modernistRegular,
                              fontSize: 1.7.t,
                              color: ColorUtils.darkText,
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
        );
      },
    );
  }
}
