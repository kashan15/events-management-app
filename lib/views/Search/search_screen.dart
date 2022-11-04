import 'package:cached_network_image/cached_network_image.dart';
import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/dimensions.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/utils/size_config.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/EventDetails/event_details.dart';
import 'package:democratic_unity/views/search/change_location.dart';
import 'package:democratic_unity/views/search/search_events.dart';
import 'package:democratic_unity/widgets/loader_2.dart';
import 'package:democratic_unity/widgets/loader_5.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stacked/stacked.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List upComingEvents = [
    {
      'image': ImageUtils.americanFlag,
      'eventName': 'Lorem Ipsum',
      'date': '10',
      'month': ' June',
      'location': 'Lot 13 • Oakland, CA',
      'going': '+20',
      'goingGroup': ImageUtils.groupGoing
    },
    {
      'image': ImageUtils.event,
      'eventName': 'Lorem Ipsum',
      'date': '10',
      'month': ' June',
      'location': 'Lot 13 • Oakland, CA',
      'going': '+20',
      'goingGroup': ImageUtils.groupGoing
    },
  ];

  final searchController = TextEditingController();

  // void dispose() {
  //   searchController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      onModelReady: (model){

      },
      disposeViewModel: false,
      builder: (context, model, child) {
        return
        model.isLoading == true ?
        // Loader5():
        Loader2() :
          GestureDetector(
          onTap: () {
            context.unFocus();
          },
          child: SafeArea(
            top: false,
            bottom: false,
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: context.getPadding().top,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          // padding: EdgeInsets.only(
                          //     left: 4.w,
                          //     right: 4.w,
                          //     top: 6.h
                          // ),
                          child: Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 4.w, right: 4.w, top: 6.h),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        //color: ColorUtils.textFieldBg,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(6.0),
                                        ),
                                        border: Border.all(
                                            color: ColorUtils.silverColor)),
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: SizeConfig.widthMultiplier * 3,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            child: SvgPicture.asset(
                                              ImageUtils.textFieldSearchIcon,
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: SizeConfig.widthMultiplier *
                                                      3,
                                                  right:
                                                  SizeConfig.widthMultiplier *
                                                      3),
                                              child: TextField(
                                                style: TextStyle(
                                                  fontFamily: FontUtils.avertaDemoRegular,
                                                  color: ColorUtils.blueColor,
                                                  fontSize: SizeConfig.textMultiplier * 1.9,
                                                ),
                                                onTap: () {
                                                  // model.showButton = true;
                                                  // model.notifyListeners();
                                                  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:SearchEvents()));
                                                },
                                                enabled: true,
                                                //readOnly: true,
                                                //focusNode: model.searchFocus,
                                                controller: model.searchController,
                                                decoration: InputDecoration(
                                                  hintText:
                                                  "Search events, people etc",
                                                  hintStyle: TextStyle(
                                                    fontFamily:
                                                    FontUtils.avertaDemoRegular,
                                                    color: ColorUtils.silverColor,
                                                    fontSize:
                                                    SizeConfig.textMultiplier *
                                                        1.9,
                                                  ),
                                                  border: InputBorder.none,
                                                  isDense: true,
                                                  contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: SizeConfig
                                                          .heightMultiplier *
                                                          2),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 4.w, right: 4.w,top: 1.h),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Find events near",
                                                style: TextStyle(
                                                    fontFamily:
                                                    FontUtils.avertaDemoRegular,
                                                    fontSize: 1.75.t,
                                                    color: ColorUtils.silverColor),
                                              ),
                                              SizedBox(height: 1.h),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      model.changeLocationDist == null ?
                                                      model.getUserDistrict!
                                                          : model.changeLocationDist!,
                                                      style: TextStyle(
                                                          fontFamily:
                                                          FontUtils.avertaBold,
                                                          fontSize: 3.t,
                                                          color: ColorUtils.darkText),
                                                    ),
                                                  ),
                                                  ExpandTapWidget(
                                                    onTap: (){
                                                      model.navigationService.navigateTo(to: ChangeLocation());
                                                    },
                                                    tapPadding: EdgeInsets.all(25.0),
                                                    child: Row(
                                                      children: [
                                                        // SvgPicture.asset(
                                                        //     ImageUtils.targetIcon),
                                                        // SizedBox(
                                                        //   width: 2.w,
                                                        // ),
                                                        Text(
                                                          "Change",
                                                          style: TextStyle(
                                                              fontFamily:
                                                              FontUtils.avertaBold,
                                                              fontSize: 2.t,
                                                              color:
                                                              ColorUtils.blueColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // GestureDetector(
                                                  //   onTap: (){
                                                  //     model.navigationService.navigateTo(to: ChangeLocation());
                                                  //   },
                                                  //   child: Row(
                                                  //     children: [
                                                  //       SvgPicture.asset(
                                                  //           ImageUtils.targetIcon),
                                                  //       SizedBox(
                                                  //         width: 2.w,
                                                  //       ),
                                                  //       Text(
                                                  //         "Change",
                                                  //         style: TextStyle(
                                                  //             fontFamily:
                                                  //                 FontUtils.avertaBold,
                                                  //             fontSize: 2.t,
                                                  //             color:
                                                  //                 ColorUtils.blueColor),
                                                  //       ),
                                                  //     ],
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                              SizedBox(height: 6.h),
                                              Container(
                                                // decoration: BoxDecoration(
                                                //   shape: BoxShape.rectangle,
                                                //   borderRadius:
                                                //       BorderRadius.all(Radius.circular(16.0)),
                                                // ),
                                                child: AnimatedContainer(
                                                  duration: Duration(milliseconds: 400),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                      1,
                                                  height: 6.5.h,
                                                  //margin: EdgeInsets.symmetric(horizontal: 5.w),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(6),
                                                    ),
                                                    color: ColorUtils.blueColor,
                                                    // boxShadow: [
                                                    //   BoxShadow(
                                                    //     color: ColorUtils.blueColor.withOpacity(0.25),
                                                    //     spreadRadius: 0,
                                                    //     blurRadius: 10,
                                                    //     offset: Offset(
                                                    //         0, 5), // changes position of shadow
                                                    //   ),
                                                    // ],
                                                  ),
                                                  child: MaterialButton(
                                                    padding: EdgeInsets.zero,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(6)),
                                                    onPressed: () {},
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        SvgPicture.asset(
                                                            ImageUtils.startingSoon),
                                                        SizedBox(
                                                          width: 2.w,
                                                        ),
                                                        Text(
                                                          "Starting Soon",
                                                          style: TextStyle(
                                                              fontFamily:
                                                              FontUtils.avertaBold,
                                                              fontSize: 1.85.t,
                                                              color: Colors.white),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3.h,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        model.filteringTheEventsByLocation("today");
                                                      },
                                                      child: Container(
                                                        //width: MediaQuery.of(context).size.width / 2,
                                                        padding: EdgeInsets.only(
                                                            top: 1.h, bottom: 2.h),
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.rectangle,
                                                          borderRadius: BorderRadius.circular(6),
                                                          border: Border.all(
                                                            color: ColorUtils.blueColor,
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "Today",
                                                            style: TextStyle(
                                                                fontFamily: FontUtils
                                                                    .avertaDemoRegular,
                                                                fontSize: 2.t,
                                                                color:
                                                                ColorUtils.blueColor),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 6.w,),
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        model.filteringTheEventsByLocation("tomorrow");
                                                      },
                                                      child: Container(
                                                        //width: MediaQuery.of(context).size.width / 2,
                                                        padding: EdgeInsets.only(
                                                            top: 1.h, bottom: 2.h),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(6),
                                                          shape: BoxShape.rectangle,
                                                          border: Border.all(
                                                            color: ColorUtils.blueColor,
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "Tomorrow",
                                                            style: TextStyle(
                                                                fontFamily: FontUtils
                                                                    .avertaDemoRegular,
                                                                fontSize: 2.t,
                                                                color: ColorUtils.blueColor
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 2.5.h,),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        model.filteringTheEventsByLocation("thisweek");
                                                      },
                                                      child: Container(
                                                        //width: MediaQuery.of(context).size.width / 2,
                                                        padding: EdgeInsets.only(
                                                            top: 1.h, bottom: 2.h),
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.rectangle,
                                                          borderRadius: BorderRadius.circular(6),
                                                          border: Border.all(
                                                            color: ColorUtils.blueColor,
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "This Week",
                                                            style: TextStyle(
                                                                fontFamily: FontUtils
                                                                    .avertaDemoRegular,
                                                                fontSize: 2.t,
                                                                color:
                                                                ColorUtils.blueColor
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 6.w,),
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        model.filteringTheEventsByLocation("weekends");
                                                      },
                                                      child: Container(
                                                        //width: MediaQuery.of(context).size.width / 2,
                                                        padding: EdgeInsets.only(
                                                            top: 1.h, bottom: 2.h),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(6),
                                                          shape: BoxShape.rectangle,
                                                          border: Border.all(
                                                            color: ColorUtils.blueColor,
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "This Weekend",
                                                            style: TextStyle(
                                                                fontFamily: FontUtils
                                                                    .avertaDemoRegular,
                                                                fontSize: 2.t,
                                                                color:
                                                                ColorUtils.blueColor
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 2.5.h,),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        model.filteringTheEventsByLocation("nextweek");
                                                      },
                                                      child: Container(
                                                        //width: MediaQuery.of(context).size.width / 2,
                                                        padding: EdgeInsets.only(
                                                            top: 1.h, bottom: 2.h),
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.rectangle,
                                                          borderRadius: BorderRadius.circular(6),
                                                          border: Border.all(
                                                            color: ColorUtils.blueColor,
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "Next Week",
                                                            style: TextStyle(
                                                                fontFamily: FontUtils
                                                                    .avertaDemoRegular,
                                                                fontSize: 2.t,
                                                                color:
                                                                ColorUtils.blueColor
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 6.w,),
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        model.filteringTheEventsByLocation("upcoming");
                                                      },
                                                      child: Container(
                                                        //width: MediaQuery.of(context).size.width / 2,
                                                        padding: EdgeInsets.only(
                                                            top: 1.h, bottom: 2.h),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(6),
                                                          shape: BoxShape.rectangle,
                                                          border: Border.all(
                                                            color: ColorUtils.blueColor,
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "All Upcoming",
                                                            style: TextStyle(
                                                                fontFamily: FontUtils
                                                                    .avertaDemoRegular,
                                                                fontSize: 2.t,
                                                                color:
                                                                ColorUtils.blueColor
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Explore Events",
                                                style: TextStyle(
                                                  fontFamily: FontUtils.avertaSemiBold,
                                                  fontSize: 3.t,
                                                  color: ColorUtils.darkText,
                                                ),
                                              ),
                                              //SvgPicture.asset(ImageUtils.notificationBell),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(left: 0.w,right: 1.w),
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
                                                    onTap: (){
                                                      model.gettingAttendeeDetails(
                                                        // model.upComingeventsList[index].id!,index,
                                                        model.upComingeventsList[index].eventId!,index,
                                                      );
                                                      //model.navigationService.navigateTo(to: EventDetails(index: index,));
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
                                                                      child: CachedNetworkImage(imageUrl: model.upComingeventsList[index].eventBanner!,
                                                                        fit: BoxFit.cover,
                                                                        height: 40.i,
                                                                        width: MediaQuery.of(context).size.width / 1,
                                                                      )
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
                                                                              //model.eventsList[index].timings!.substring(0, 10),
                                                                              style: TextStyle(
                                                                                  fontFamily: FontUtils.avertaBold,
                                                                                  color: ColorUtils.redColor
                                                                              ),
                                                                            ),
                                                                            SizedBox(width: 1.w,),
                                                                            Text( DateFormat('MMMM').format(DateTime(0, int.parse(model.upComingeventsList[index].eventDate!.substring(5,7)))).toString(),
                                                                              //model.eventsList[index].eventDate!.substring(8,10),
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
                                                                    // Row(
                                                                    //   mainAxisSize: MainAxisSize.min,
                                                                    //   children: [
                                                                    //     Container(
                                                                    //       //color: Colors.red,
                                                                    //       child: Image.asset(upComingEvents[index]["goingGroup"],
                                                                    //         width: 16.i,
                                                                    //         height: 7.i,
                                                                    //         fit: BoxFit.cover,
                                                                    //       ),
                                                                    //     ),
                                                                    //     SizedBox(width: 3.w,),
                                                                    //     Text(upComingEvents[index]["going"] + " Going",
                                                                    //       style: TextStyle(
                                                                    //         fontFamily: FontUtils.avertaDemoRegular,
                                                                    //         fontSize: 1.7.t,
                                                                    //         color: ColorUtils.redColor,
                                                                    //       ),
                                                                    //     ),
                                                                    //   ],
                                                                    // ),

                                                                    Row(
                                                                      mainAxisSize: MainAxisSize.min,
                                                                      children: [
                                                                        model.attendeeLength != 0 ?
                                                                        Container(
                                                                            height: 5.h,
                                                                            child: Stack(
                                                                              children: [
                                                                                Container(
                                                                                    decoration:
                                                                                    BoxDecoration(
                                                                                      borderRadius:
                                                                                      BorderRadius
                                                                                          .only(
                                                                                        bottomLeft: Radius
                                                                                            .circular(
                                                                                            20.0),
                                                                                        topLeft: Radius
                                                                                            .circular(
                                                                                            20.0),
                                                                                        bottomRight: Radius
                                                                                            .circular(
                                                                                            20.0),
                                                                                        topRight: Radius
                                                                                            .circular(
                                                                                            20.0),
                                                                                      ),
                                                                                      border: Border.all(
                                                                                          color: Colors
                                                                                              .white,
                                                                                          width: 4.0),
                                                                                    ),
                                                                                    margin: EdgeInsets.only(
                                                                                        left: 4 *
                                                                                            SizeConfig
                                                                                                .widthMultiplier,
                                                                                        right: 4 *
                                                                                            SizeConfig
                                                                                                .widthMultiplier),
                                                                                    child: ClipOval(
                                                                                      child: model.attendeesProfilePics!
                                                                                          .length >
                                                                                          1
                                                                                          ? CachedNetworkImage(
                                                                                        imageUrl:
                                                                                        model.attendeesProfilePics?[
                                                                                        1]??'',
                                                                                        width:
                                                                                        SizeConfig.imageSizeMultiplier *
                                                                                            8,
                                                                                        height:
                                                                                        SizeConfig.imageSizeMultiplier *
                                                                                            8,
                                                                                        fit: BoxFit
                                                                                            .cover,
                                                                                      )
                                                                                          : Container(),
                                                                                      /*Image.asset(
                                          ImageUtils.avatar,
                                          width: SizeConfig.imageSizeMultiplier * 8,
                                          height: SizeConfig.imageSizeMultiplier * 8,
                                        ),*/
                                                                                    )),
                                                                                Container(
                                                                                  margin: EdgeInsets.only(
                                                                                      left: 8 *
                                                                                          SizeConfig
                                                                                              .widthMultiplier,
                                                                                      right: 8 *
                                                                                          SizeConfig
                                                                                              .widthMultiplier),
                                                                                  child: ClipOval(
                                                                                    child: model.attendeesProfilePics!
                                                                                        .length >
                                                                                        2
                                                                                        ? CachedNetworkImage(
                                                                                      imageUrl:
                                                                                      model.attendeesProfilePics![
                                                                                      2],
                                                                                      width: SizeConfig
                                                                                          .imageSizeMultiplier *
                                                                                          8,
                                                                                      height:
                                                                                      SizeConfig.imageSizeMultiplier *
                                                                                          8,
                                                                                      fit: BoxFit
                                                                                          .cover,
                                                                                    )
                                                                                        : Container(),
                                                                                    /*Image.asset(
                                        ImageUtils.avatar,
                                        width: SizeConfig.imageSizeMultiplier * 8,
                                        height: SizeConfig.imageSizeMultiplier * 8,
                                    ),*/
                                                                                  ),
                                                                                  decoration:
                                                                                  BoxDecoration(
                                                                                    borderRadius:
                                                                                    BorderRadius
                                                                                        .only(
                                                                                      bottomLeft: Radius
                                                                                          .circular(
                                                                                          20.0),
                                                                                      topLeft: Radius
                                                                                          .circular(
                                                                                          20.0),
                                                                                      bottomRight:
                                                                                      Radius
                                                                                          .circular(
                                                                                          20.0),
                                                                                      topRight: Radius
                                                                                          .circular(
                                                                                          20.0),
                                                                                    ),
                                                                                    border: Border.all(
                                                                                        color: Colors
                                                                                            .white,
                                                                                        width: 4.0),
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  margin: EdgeInsets.only(
                                                                                      left: 8 *
                                                                                          SizeConfig
                                                                                              .widthMultiplier,
                                                                                      right: 8 *
                                                                                          SizeConfig
                                                                                              .widthMultiplier),
                                                                                  child: ClipOval(
                                                                                    child: model.attendeesProfilePics!
                                                                                        .length >
                                                                                        2
                                                                                        ? CachedNetworkImage(
                                                                                      imageUrl:
                                                                                      model.attendeesProfilePics![
                                                                                      2],
                                                                                      width: SizeConfig
                                                                                          .imageSizeMultiplier *
                                                                                          8,
                                                                                      height:
                                                                                      SizeConfig.imageSizeMultiplier *
                                                                                          8,
                                                                                      fit: BoxFit
                                                                                          .cover,
                                                                                    )
                                                                                        : Container(),
                                                                                    /*Image.asset(
                                        ImageUtils.avatar,
                                        width: SizeConfig.imageSizeMultiplier * 8,
                                        height: SizeConfig.imageSizeMultiplier * 8,
                                    ),*/
                                                                                  ),
                                                                                  decoration:
                                                                                  BoxDecoration(
                                                                                    borderRadius:
                                                                                    BorderRadius
                                                                                        .only(
                                                                                      bottomLeft: Radius
                                                                                          .circular(
                                                                                          20.0),
                                                                                      topLeft: Radius
                                                                                          .circular(
                                                                                          20.0),
                                                                                      bottomRight:
                                                                                      Radius
                                                                                          .circular(
                                                                                          20.0),
                                                                                      topRight: Radius
                                                                                          .circular(
                                                                                          20.0),
                                                                                    ),
                                                                                    border: Border.all(
                                                                                        color: Colors
                                                                                            .white,
                                                                                        width: 4.0),
                                                                                  ),
                                                                                ),


                                                                              ],
                                                                            )
                                                                        )
                                                                            : Image.asset(
                                                                          ImageUtils.avatar,
                                                                          width: SizeConfig
                                                                              .imageSizeMultiplier *
                                                                              8,
                                                                          height: SizeConfig
                                                                              .imageSizeMultiplier *
                                                                              8,
                                                                        ),
                                                                        SizedBox(
                                                                          width: 3.w,
                                                                        ),
                                                                        Text(
                                                                          model.attendeeLength.toString() +
                                                                              " Going",
                                                                          //"+ 20 Going",
                                                                          style: TextStyle(
                                                                              fontFamily:
                                                                              FontUtils.avertaBold,
                                                                              fontSize: 1.8.t,
                                                                              color: ColorUtils.redColor),
                                                                        ),
                                                                      ],
                                                                    ),

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
                                            )
                                        ),
                                        SizedBox(
                                          height: 6.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
        );
      },
    );
  }
}
