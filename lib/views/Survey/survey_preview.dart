import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/dialog_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/widgets/custom_button.dart';
import 'package:democratic_unity/widgets/error_widget.dart';
import 'package:democratic_unity/widgets/loader_2.dart';
import 'package:democratic_unity/widgets/survey_questions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

class SurveyPreview extends StatefulWidget {

  String? title;

  SurveyPreview({this.title, Key? key}) : super(key: key);

  @override
  _SurveyPreviewState createState() => _SurveyPreviewState();
}

class _SurveyPreviewState extends State<SurveyPreview> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model){
        model.populateData();
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
                          widget.title!,
                          style: TextStyle(
                            fontFamily: FontUtils.avertaBold,
                            fontSize: 3.t,
                            color: ColorUtils.darkText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 2.h,
                  // ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 0.w, right: 0.w, top: 1.h, bottom: 3.h),
                            child: ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 2.h,);
                              },
                              itemCount: model.currentSurveyQuestions.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return SurveyQuestions(index: index,);
                                    //_getListItemTile(context, index, model);
                                },
                            ),
                          ),
                          SizedBox(height: 2.h,),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            child: CustomButton(
                              onButtonPressed: () async{
                                //model.checkAllQuestions(context);
                                if(model.oneOptionChosen == true){
                                  model.questionData(context);
                                }
                                else if(model.oneOptionChosen == false){
                                  DialogUtils().showDialog(MyErrorWidget(
                                    error: "Please give one answer",
                                  ));
                                }
                              },
                              textValue: "Submit Survey",
                              height: 6.5,
                            ),
                          ),
                          SizedBox(height: 2.h,),
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
  // Widget _getListItemTile(BuildContext context, int index, MainViewModel mainModel) {
  //   return GestureDetector(
  //     onTap: () {
  //       mainModel.questionsList[index].isSelected = true;
  //       mainModel.notifyListeners();
  //       if (mainModel.questionsList.any((item) => item.isSelected)) {
  //         mainModel.questionsList[index].isSelected = !mainModel.questionsList[index].isSelected;
  //         setState(() {
  //         });
  //       }
  //       mainModel.notifyListeners();
  //     },
  //     child: Container(
  //       margin: EdgeInsets.symmetric(vertical: 4),
  //       color: mainModel.questionsList[index].isSelected ? Colors.red: Colors.white,
  //       child: ListTile(
  //         title: Text(mainModel.questionsList[index].data),
  //       ),
  //     ),
  //   );
  // }
}
