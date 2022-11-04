import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({Key? key}) : super(key: key);

  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
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
          child: GestureDetector(
            onTap: () {
              context.unFocus();
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
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
                              "Feedback",
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Help us improve",
                              style: TextStyle(
                                fontFamily: FontUtils.avertaBold,
                                fontSize: 2.25.t,
                                color: ColorUtils.darkText,
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            // Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus varius dictum cursus. Donec nec facilisis urna.",
                            //   style: TextStyle(
                            //     fontFamily: FontUtils.modernistRegular,
                            //     fontSize: 1.8.t,
                            //     color: ColorUtils.darkText,
                            //   ),
                            //   textAlign: TextAlign.center,
                            // ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 2.5.h,),
                            Text(
                              "Title",
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
                              // height: 6.5.h,
                              // width: 10.w,
                              //margin: const EdgeInsets.all(10.0),
                              padding: EdgeInsets.only(left: 3.w),
                              decoration: BoxDecoration(
                                  border: Border.all(color: ColorUtils.blueColor),
                                  //color: ColorUtils.searchField,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5))),
                              child: TextField(
                                //maxLines: 1,
                                style: TextStyle(
                                    fontFamily: FontUtils.avertaSemiBold,
                                    fontSize: 2.5.t,
                                    color: ColorUtils.blueColor
                                ),
                                controller: model.feedbackTitle,
                                //scrollController: _countryCodeController,
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintStyle: TextStyle(
                                      fontSize: 2.5.t,
                                      //color: ColorUtils.searchHintColor
                                    )),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            SizedBox(height: 2.5.h,),
                            Text(
                              "Feedback",
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
                              // height: 6.5.h,
                              // width: 10.w,
                              //margin: const EdgeInsets.all(10.0),
                              padding: EdgeInsets.only(left: 3.w),
                              decoration: BoxDecoration(
                                  border: Border.all(color: ColorUtils.blueColor),
                                  //color: ColorUtils.searchField,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5))),
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                //maxLines: 1,
                                style: TextStyle(
                                    fontFamily: FontUtils.avertaSemiBold,
                                    fontSize: 2.5.t,
                                    color: ColorUtils.blueColor
                                ),
                                controller: model.feedbackDescription,
                                //scrollController: _countryCodeController,
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintStyle: TextStyle(
                                      fontSize: 2.5.t,
                                      //color: ColorUtils.searchHintColor
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.h,),
                      Container(
                        height: 5.h,
                        child: Center(
                          child: model.errorMessage != null
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
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
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
                            onPressed: () async{
                              model.feedBacks(context);
                            },
                            child: model.isLoading == false ?
                            Text(
                              "Submit",
                              style: TextStyle(
                                  fontFamily: FontUtils.avertaSemiBold,
                                  fontSize: 2.2.t,
                                  color: Colors.white),
                            ) : Loader(),
                          ),
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
    );
  }
}
