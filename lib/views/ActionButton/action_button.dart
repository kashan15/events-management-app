import 'package:cached_network_image/cached_network_image.dart';
import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/dontate.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/ActionButton/create_event.dart';
import 'package:democratic_unity/views/AllEvents/all_events_detail.dart';
import 'package:democratic_unity/views/NearBy/near_by_events.dart';
import 'package:democratic_unity/views/Notifications/notifications.dart';
import 'package:democratic_unity/views/SeeAllUpcomings/seeAll_upcomings.dart';
import 'package:democratic_unity/views/Volunteer/volunteer.dart';
import 'package:democratic_unity/views/drawer.dart';
import 'package:democratic_unity/views/main_view.dart';
import 'package:democratic_unity/widgets/loader_2.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stacked/stacked.dart';

class ActionButton extends StatefulWidget {
  const ActionButton({Key? key}) : super(key: key);

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int currentIndex = 0;


  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model){
        model.myEvents();
      },
      builder: (context, model, child) {
        return
          model.isLoading == false ?
          SafeArea(
          top: false,
          bottom: false,
          child: Container(
            color: Colors.white,
            //margin: EdgeInsets.symmetric(horizontal: 4.w),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 6.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 1.5.w, right: 4.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () =>
                                Scaffold.of(context).openDrawer(),
                            icon: SvgPicture.asset(
                                ImageUtils.menuIcon),
                          ),
                          // ExpandTapWidget(
                          //   onTap: (){
                          //     Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:AllNotifications()));
                          //   },
                          //   tapPadding: EdgeInsets.all(4.i),
                          //   child: SvgPicture.asset(ImageUtils.notificationBell),
                          // ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 4.h,),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 4.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Upcoming Events",
                                    style: TextStyle(
                                      fontFamily: FontUtils.avertaSemiBold,
                                      fontSize: 2.6.t,
                                      color: ColorUtils.darkText,
                                    ),
                                  ),
                                  ExpandTapWidget(
                                    onTap: (){
                                      model.navigationService.navigateTo(to: SeeAllUpComings());
                                    },
                                    tapPadding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 2.h),
                                    child: Text(
                                      "See all",
                                      style: TextStyle(
                                        shadows: [
                                          Shadow(
                                              color: ColorUtils.blueColor,
                                              offset: Offset(0, -1))
                                        ],
                                        color: Colors.transparent,
                                        decoration:
                                        TextDecoration.underline,
                                        decorationColor: ColorUtils.blueColor,
                                        //decorationThickness: 4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 3.h,),
                            Container(
                              margin: EdgeInsets.only(right: 1.w),
                              height: 38.5.h,
                              //width: 70.w,
                              child:
                              model.upComingeventsList.length != 0 ?
                              ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  //padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () async{
                                        // await model.numberOfAttendee(model.upComingeventsList[index].id!, index);
                                        await model.numberOfAttendee(model.upComingeventsList[index].eventId!, index);
                                        //Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:DeleteEvent()));
                                        //model.myEvents(model.eventsList[index].id!,index);
                                        model.navigationService.navigateTo(to: AllEventsDetail(
                                          index: index,
                                          attendeeLength: model.totalAttendee,
                                          eventBanner: model.upComingeventsList[index].eventBanner,
                                          eventName: model.upComingeventsList[index].eventName,
                                          eventDate: model.upComingeventsList[index].eventDate,
                                          timeFrom: model.upComingeventsList[index].timeFrom,
                                          timeTo: model.upComingeventsList[index].timeTo,
                                          location: model.upComingeventsList[index].location,
                                          profileImage: model.upComingeventsList[index].ProfileImage,
                                          fName: model.upComingeventsList[index].fname,
                                          eventDescription: model.upComingeventsList[index].eventDescription,
                                        )
                                        );
                                        model.isLoading = false;
                                        model.notifyListeners();
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 4.w, bottom: 2.h),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width / 1.35,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            boxShadow: [
                                              BoxShadow(
                                                  offset: Offset(0.0, 5),
                                                  color: Colors.black.withOpacity(0.1),
                                                  blurRadius: 10.0,
                                                  spreadRadius: 0
                                              ),
                                            ],
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(Radius.circular(18)),
                                            border: Border.all(color: ColorUtils.blueColor),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(10),
                                                      child: CachedNetworkImage(
                                                        imageUrl:model.upComingeventsList[index].eventBanner!,
                                                        fit: BoxFit.cover,
                                                        height: 40.i,
                                                        width: MediaQuery.of(context).size.width / 1,
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 3.w,
                                                      top: 1.5.h,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.white.withOpacity(0.70),
                                                          borderRadius: BorderRadius.all(Radius.circular(18)),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.7.h),
                                                          child: Row(
                                                            children: [
                                                              Text(model.upComingeventsList[index].eventDate!.substring(8,10),
                                                                style: TextStyle(
                                                                    fontFamily: FontUtils.avertaBold,
                                                                    color: ColorUtils.redColor
                                                                ),
                                                              ),
                                                              Text(DateFormat('MMMM').format(DateTime(0, int.parse(model.upComingeventsList[index].eventDate!.substring(5,7)))).toString(),
                                                                style: TextStyle(
                                                                    fontFamily: FontUtils.interRegular,
                                                                    color: ColorUtils.redColor
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 2.h,),
                                                Container(
                                                  margin: EdgeInsets.only(left: 2.2.w),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(model.upComingeventsList[index].eventName!,
                                                        style: TextStyle(
                                                            fontFamily: FontUtils.avertaSemiBold,
                                                            fontSize: 2.4.t,
                                                            color: ColorUtils.titleText
                                                        ),
                                                      ),
                                                      SizedBox(height: 1.h,),
                                                      /*Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                          //color: Colors.red,
                                                          child: Image.asset(upComingEvents[index]["goingGroup"],
                                                            width: 16.i,
                                                            height: 7.i,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        SizedBox(width: 3.w,),
                                                        Text(upComingEvents[index]["going"] + " Going",
                                                          style: TextStyle(
                                                            fontFamily: FontUtils.avertaDemoRegular,
                                                            fontSize: 1.7.t,
                                                            color: ColorUtils.redColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),*/
                                                      SizedBox(height: 1.h,),
                                                      Row(
                                                        children: [
                                                          SvgPicture.asset(ImageUtils.location),
                                                          SizedBox(width: 1.w,),
                                                          Flexible(
                                                            child: Text(model.upComingeventsList[index].location!,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                fontFamily: FontUtils.avertaDemoRegular,
                                                                fontSize: 1.7.t,
                                                                color: ColorUtils.darkText,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(width: 1.w,);
                                  },
                                  itemCount: model.upComingeventsList.length
                              ) :
                              Center(
                                child: Text("No Event Found",
                                  style: TextStyle(
                                    fontFamily: FontUtils.avertaSemiBold,
                                    fontSize: 2.5.t,
                                    color: ColorUtils.darkText,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 3.h,),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 4.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Nearby You",
                                    style: TextStyle(
                                      fontFamily: FontUtils.avertaSemiBold,
                                      fontSize: 2.5.t,
                                      color: ColorUtils.darkText,
                                    ),
                                  ),
                                  // GestureDetector(
                                  //   onTap: (){
                                  //     model.navigationService.navigateTo(to: NearByEvents());
                                  //   },
                                  //   child: Text(
                                  //     "See all",
                                  //     style: TextStyle(
                                  //       shadows: [
                                  //         Shadow(
                                  //             color: ColorUtils.blueColor,
                                  //             offset: Offset(0, -1))
                                  //       ],
                                  //       color: Colors.transparent,
                                  //       decoration:
                                  //       TextDecoration.underline,
                                  //       decorationColor: ColorUtils.blueColor,
                                  //       //decorationThickness: 4,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            SizedBox(height: 3.h,),
                            Container(
                                margin: EdgeInsets.only(right: 1.w),
                                height: 38.5.h,
                                //width: 70.w,
                                child: model.nearByList.length != 0 ?
                                ListView.separated(
                                  itemCount: model.nearByList.length,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  //padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () async{
                                        // await model.numberOfAttendee(model.upComingeventsList[index].id!, index);
                                        await model.numberOfAttendee(model.upComingeventsList[index].eventId!, index);
                                        //Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:DeleteEvent()));
                                        //model.myEvents(model.eventsList[index].id!,index);
                                        model.navigationService.navigateTo(to: AllEventsDetail(
                                          index: index,
                                          attendeeLength: model.totalAttendee,
                                          eventBanner: model.nearByList[index].eventBanner,
                                          eventName: model.nearByList[index].eventName,
                                          eventDate: model.nearByList[index].eventDate,
                                          timeFrom: model.nearByList[index].timeFrom,
                                          timeTo: model.nearByList[index].timeTo,
                                          location: model.nearByList[index].location,
                                          profileImage: model.nearByList[index].ProfileImage,
                                          fName: model.nearByList[index].fname,
                                          eventDescription: model.nearByList[index].eventDescription,
                                        )
                                        );
                                        model.isLoading = false;
                                        model.notifyListeners();
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 4.w, bottom: 2.h),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width / 1.35,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            boxShadow: [
                                              BoxShadow(
                                                  offset: Offset(0.0, 5),
                                                  color: Colors.black.withOpacity(0.1),
                                                  blurRadius: 10.0,
                                                  spreadRadius: 0
                                              ),
                                            ],
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(Radius.circular(18)),
                                            border: Border.all(color: ColorUtils.blueColor),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(10),
                                                      child: CachedNetworkImage(
                                                        imageUrl:model.nearByList[index].eventBanner!,
                                                        fit: BoxFit.cover,
                                                        height: 40.i,
                                                        width: MediaQuery.of(context).size.width / 1,
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 3.w,
                                                      top: 1.5.h,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.white.withOpacity(0.70),
                                                          borderRadius: BorderRadius.all(Radius.circular(18)),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.7.h),
                                                          child: Row(
                                                            children: [
                                                              Text(model.nearByList[index].eventDate!.substring(8,10),
                                                                style: TextStyle(
                                                                    fontFamily: FontUtils.avertaBold,
                                                                    color: ColorUtils.redColor
                                                                ),
                                                              ),
                                                              Text(DateFormat('MMMM').format(DateTime(0, int.parse(model.nearByList[index].eventDate!.substring(5,7)))).toString(),
                                                                style: TextStyle(
                                                                    fontFamily: FontUtils.interRegular,
                                                                    color: ColorUtils.redColor
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 2.h,),
                                                Container(
                                                  margin: EdgeInsets.only(left: 2.2.w),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(model.nearByList[index].eventName!,
                                                        style: TextStyle(
                                                            fontFamily: FontUtils.avertaSemiBold,
                                                            fontSize: 2.4.t,
                                                            color: ColorUtils.titleText
                                                        ),
                                                      ),
                                                      SizedBox(height: 1.h,),
                                                      /*Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                          //color: Colors.red,
                                                          child: Image.asset(upComingEvents[index]["goingGroup"],
                                                            width: 16.i,
                                                            height: 7.i,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        SizedBox(width: 3.w,),
                                                        Text(upComingEvents[index]["going"] + " Going",
                                                          style: TextStyle(
                                                            fontFamily: FontUtils.avertaDemoRegular,
                                                            fontSize: 1.7.t,
                                                            color: ColorUtils.redColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),*/
                                                      SizedBox(height: 1.h,),
                                                      Row(
                                                        children: [
                                                          SvgPicture.asset(ImageUtils.location),
                                                          SizedBox(width: 1.w,),
                                                          Flexible(
                                                            child: Text(model.nearByList[index].location!,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                fontFamily: FontUtils.avertaDemoRegular,
                                                                fontSize: 1.7.t,
                                                                color: ColorUtils.darkText,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(width: 1.w,);
                                  },
                                ) :
                                Center(
                                  child: Text("No Nearby Event",
                                    style: TextStyle(
                                      fontFamily: FontUtils.avertaSemiBold,
                                      fontSize: 2.5.t,
                                      color: ColorUtils.darkText,
                                    ),
                                  ),
                                )
                            ),
                            SizedBox(height: 6.h,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          )
        ) : Loader2();
      },
    );
  }
}
