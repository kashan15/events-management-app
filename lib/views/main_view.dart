import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/utils/size_config.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/ActionButton/action_button.dart';
import 'package:democratic_unity/views/chat_list_screen.dart';
import 'package:democratic_unity/views/drawer.dart';
import 'package:democratic_unity/views/events/events.dart';
import 'package:democratic_unity/views/events/no_events.dart';
import 'package:democratic_unity/views/home_screen.dart';
import 'package:democratic_unity/views/search/search_screen.dart';
import 'package:democratic_unity/widgets/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stacked/stacked.dart';

import '../dontate.dart';
import '../utils/font_utils.dart';
import 'ActionButton/create_event.dart';
import 'Volunteer/volunteer.dart';

final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
class MainView extends StatefulWidget {

  int index;
  MainView({Key? key, required this.index}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  int currentIndex = 0;
  Widget body = HomeScreen();
  Widget bodyone = HomeScreen();

  @override
  void initState() {
    currentIndex = widget.index;
    onClick(currentIndex);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
        builder: (context, model, child) {
        return
            SafeArea(
            top: false,
            bottom: true,
            child: Scaffold(
              drawer: DrawerScreen(),
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: [
                  Column(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                            child: body
                        ),
                      ),
                      MyCurvedNavBar(
                        barIconColor: ColorUtils.icon_color,
                        selectedIconColor: Colors.white,
                        color: Colors.white,
                        buttonBackgroundColor: ColorUtils.blueColor,
                        index: currentIndex,
                        animationCurve: Curves.ease,
                        animationDuration: Duration(milliseconds: 300),
                        height: SizeConfig.heightMultiplier * 8,
                        backgroundColor: Color(0xFFefefef),
                        parentDecoration: BoxDecoration(
                            boxShadow: [BoxShadow(
                                color: Color(0xFFefefef),
                                blurRadius: 3*SizeConfig.imageSizeMultiplier,
                                offset: Offset(0,-10)
                            )]
                        ),
                        items: <String>[
                          ImageUtils.homeIcon,
                          ImageUtils.chatIcon,
                          ImageUtils.addIcon,
                          ImageUtils.searchIcon,
                          ImageUtils.calender
                        ],
                        onTap: (index) {
                          currentIndex = index;

                          //MainView(index: 3,);
                          onClick(
                               currentIndex);
                          setState(() {});
                        },
                      ),
                      //BottomBar(index: currentIndex, onClick: onClick)
                    ],
                  ),
                  if (currentIndex==2)Container(
                    margin: EdgeInsets.only(bottom: 9.h),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(16.0)),
                            ),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 400),
                              height: 5.5.h,
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
                                  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:CreateEvent()));
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 3.h),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(ImageUtils.whiteCalender),
                                      SizedBox(width: 3.w,),
                                      Text(
                                        "Create Event",
                                        style: TextStyle(
                                            fontFamily: FontUtils.avertaSemiBold,
                                            fontSize: 1.7.t,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 1.5.h,),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 12.w),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                  ),
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 400),
                                    //width: MediaQuery.of(context).size.width / 1,
                                    height: 5.5.h,
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
                                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:Volunteer()));
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(ImageUtils.volunteerHand),
                                          SizedBox(width: 3.w,),
                                          Text(
                                            "Volunteer",
                                            style: TextStyle(
                                                fontFamily: FontUtils.avertaSemiBold,
                                                fontSize: 1.7.t,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w,),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(right: 12.w),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                  ),
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 400),
                                    //width: MediaQuery.of(context).size.width / 1,
                                    height: 5.5.h,
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
                                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:Donate()));
                                        //model.donation();
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(ImageUtils.donateIcon),
                                          SizedBox(width: 3.w,),
                                          Text(
                                            "Donate",
                                            style: TextStyle(
                                                fontFamily: FontUtils.avertaSemiBold,
                                                fontSize: 1.7.t,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h,),
                        ],
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

  onClick(int selectedIndex){
    setState(() {
      currentIndex = selectedIndex;
      switch(currentIndex){
        case 0:
          body = HomeScreen();
          break;
        case 1:
          body = FriendsChatList();
          break;
        case 2:
          bodyone = ActionButton();
          break;
        case 3:
          body = SearchScreen();
          break;
        case 4:
          body = Events();
          break;
      }
    });
  }
}
