import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

class NoEvent extends StatelessWidget {
  NoEvent({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
            key: _scaffoldKey,
            drawer: DrawerScreen(),
            backgroundColor: Colors.white,
            body: Container(
              //margin: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 1.5.w, right: 4.w,top: 6.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () =>
                              _scaffoldKey.currentState!.openDrawer(),
                          icon: SvgPicture.asset(
                              ImageUtils.menuIcon),
                        ),
                        SvgPicture.asset(ImageUtils.notificationBell),
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        SvgPicture.asset(ImageUtils.noEventCalender),
                        SizedBox(height: 3.h,),
                        Text("No Events",
                        style: TextStyle(
                          fontFamily: FontUtils.avertaBold,
                          fontSize: 3.0.t,
                          color: ColorUtils.blueColor
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
