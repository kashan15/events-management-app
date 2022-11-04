import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/widgets/cupertino_back_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

class EmptyNotifications extends StatelessWidget {
  const EmptyNotifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return GestureDetector(
          onTap: (){
            context.unFocus();
          },
          child: SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    //color: Colors.amber,
                    padding: EdgeInsets.only(
                        left: 4.w,
                        right: 4.w,
                        top: 6.h
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: context.getPadding().top,),
                        Container(
                          child: Row(
                            children: [
                              CupertinoBackArrow(),
                              SizedBox(width: 4.w,),
                              Text("Notifications",
                                style: TextStyle(
                                    fontFamily: FontUtils.avertaSemiBold,
                                    fontSize: 3.t,
                                    color: ColorUtils.darkText
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            SvgPicture.asset(ImageUtils.emptyNotificationGrouped),
                            Positioned(
                              bottom: 4.h,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorUtils.redColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("0",
                                    style: TextStyle(
                                        fontFamily: FontUtils.avertaDemoRegular,
                                        fontSize: 1.8.t,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.5.h,),
                        Text("No Notifications!",
                        style: TextStyle(
                          fontFamily: FontUtils.avertaBold,
                          fontSize: 2.t,
                          color: ColorUtils.redColor,
                        ),
                        ),
                        SizedBox(height: 1.5.h,),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 4.w,
                              right: 4.w,
                          ),
                          child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit sed do eiusmod tempor",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              height: 0.2.h,
                              fontFamily: FontUtils.avertaDemoRegular,
                              fontSize: 2.t,
                              color: ColorUtils.darkText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(),
                  Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
