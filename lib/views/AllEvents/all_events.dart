import 'package:cached_network_image/cached_network_image.dart';
import 'package:democratic_unity/Services/delete_event.dart';
import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/utils/size_config.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/AllEvents/all_events_detail.dart';
import 'package:democratic_unity/views/AllEvents/delete_event.dart';
import 'package:democratic_unity/views/EventDetails/event_details.dart';
import 'package:democratic_unity/widgets/loader_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stacked/stacked.dart';

import '../drawer.dart';

class AllEvents extends StatefulWidget {
  const AllEvents({Key? key}) : super(key: key);

  @override
  _AllEventsState createState() => _AllEventsState();
}

class _AllEventsState extends State<AllEvents> {

  int currentIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model){
        //model.myAllEvents();
        model.myEvents();
        model.eventsByTheUser();
      },
      builder: (context, model, child) {
        return
        model.isLoading ==false ?
        //model.gettingMyEvents == false || model.gettingEventsByUser == false ?
          SafeArea(
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
                          "Events",
                          style: TextStyle(
                            fontFamily: FontUtils.avertaBold,
                            fontSize: 3.t,
                            color: ColorUtils.darkText,
                          ),
                        ),
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
                                Text("My Events",
                                  style: TextStyle(
                                    fontFamily: FontUtils.avertaSemiBold,
                                    fontSize: 2.6.t,
                                    color: ColorUtils.darkText,
                                  ),
                                ),
                                // Text(
                                //   "See all",
                                //   style: TextStyle(
                                //     shadows: [
                                //       Shadow(
                                //           color: ColorUtils.blueColor,
                                //           offset: Offset(0, -1))
                                //     ],
                                //     color: Colors.transparent,
                                //     decoration:
                                //     TextDecoration.underline,
                                //     decorationColor: ColorUtils.blueColor,
                                //     //decorationThickness: 4,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(height: 3.h,),
                          Container(
                            margin: EdgeInsets.only(left: 0.w,right: 1.w),
                            height: 38.5.h,
                            //width: 70.w,
                            child: model.myTotalEvents != 0 ?
                            ListView.separated(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                //padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () async{
                                       // await model.numberOfAttendee(model.upComingeventsList[index].id!, index);

                                      // await model.numberOfAttendee(model.upComingeventsList[index].eventId!, index);
                                      //
                                      //  model.myEventsSelected = true;
                                      // model.notifyListeners();

                                      // model.getMyEventsDetail(index);
                                      //  model.myEventsSelected = true;
                                      //  model.notifyListeners();

                                      // model.gettingAttendeeDetails(
                                      //   // model.upComingeventsList[index].id!,index,
                                      //   // model.upComingeventsList[index].Id!,index,
                                      //
                                      //   // model.upComingeventsList[index].eventId??'',index,
                                      //
                                      //   model.upComingeventsList[index].id??'',index,
                                      //
                                      // );

                                       model.navigationService.navigateTo(to: AllEventsDetail(
                                        index: index,
                                        // eventId:model.myEventsList[index].id,
                                         eventId:model.myEventsList[index].eventId,
                                        eventBanner: model.myEventsList[index].eventBanner,
                                        attendeeLength: model.totalAttendee,
                                        eventName: model.myEventsList[index].eventName,
                                        eventDate: model.myEventsList[index].eventDate,
                                        timeFrom: model.myEventsList[index].timeFrom,
                                        timeTo: model.myEventsList[index].timeTo,
                                        location: model.myEventsList[index].location,
                                        profileImage: model.myEventsList[index].ProfileImage,
                                        fName: model.myEventsList[index].fname,
                                        eventDescription: model.myEventsList[index].eventDescription,
                                      ));
                                       // model.isLoading = false;
                                       //
                                       DeleteEventService().isLoading1 = false;
                                       //
                                       model.myEventsSelected = true;
                                       model.notifyListeners();
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
                                                    child: CachedNetworkImage(
                                                      imageUrl:model.myEventsList[index].eventBanner!,
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
                                                            Text(model.myEventsList[index].eventDate!.substring(8,10),
                                                              style: TextStyle(
                                                                  fontFamily: FontUtils.avertaBold,
                                                                  color: ColorUtils.redColor
                                                              ),
                                                            ),
                                                            Text(DateFormat('MMMM').format(DateTime(0, int.parse(model.myEventsList[index].eventDate!.substring(5,7)))).toString(),
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
                                                    Text(model.myEventsList[index].eventName!,
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
                                                    SizedBox(height: 1.h,),
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(ImageUtils.location),
                                                        SizedBox(width: 1.w,),
                                                        Flexible(
                                                          child: Text(model.myEventsList[index].location!,
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
                                itemCount: model.myEventsList.length
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
                                Text("Attending Events",
                                  style: TextStyle(
                                    fontFamily: FontUtils.avertaSemiBold,
                                    fontSize: 2.5.t,
                                    color: ColorUtils.darkText,
                                  ),
                                ),
                                // Text(
                                //   "See all",
                                //   style: TextStyle(
                                //     shadows: [
                                //       Shadow(
                                //           color: ColorUtils.blueColor,
                                //           offset: Offset(0, -1))
                                //     ],
                                //     color: Colors.transparent,
                                //     decoration:
                                //     TextDecoration.underline,
                                //     decorationColor: ColorUtils.blueColor,
                                //     //decorationThickness: 4,
                                //   ),
                                // )
                              ],
                            ),
                          ),
                          SizedBox(height: 3.h,),
                          Container(
                            margin: EdgeInsets.only(right: 1.w),
                            height: 38.5.h,
                            //width: 70.w,
                            child: model.myAttendingEventsList.length != 0 ?
                            ListView.separated(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                //padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () async{
                                      // await model.numberOfAttendee(model.upComingeventsList[index].id!, index);
                                      await model.numberOfAttendee(model.upComingeventsList[index].eventId!, index);

                                      model.myEventsSelected = true;
                                      model.notifyListeners();

                                      //model.getMyEventsDetail(index);
                                      model.navigationService.navigateTo(to: AllEventsDetail(
                                        index: index,
                                        eventBanner: model.myAttendingEventsList[index].eventBanner,
                                        attendeeLength: model.totalAttendee,
                                        eventName: model.myAttendingEventsList[index].eventName,
                                        eventDate: model.myAttendingEventsList[index].eventDate,
                                        timeFrom: model.myAttendingEventsList[index].timeFrom,
                                        timeTo: model.myAttendingEventsList[index].timeTo,
                                        location: model.myAttendingEventsList[index].location,
                                        profileImage: model.myAttendingEventsList[index].organizerImage,
                                        fName: model.myAttendingEventsList[index].organizerName,
                                        eventDescription: model.myAttendingEventsList[index].eventDescription,
                                      ));
                                      model.isLoading = false;
                                      model.myEventsSelected = false;
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
                                                      imageUrl:model.myAttendingEventsList[index].eventBanner!,
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
                                                            Text(model.myAttendingEventsList[index].eventDate!.substring(8,10),
                                                              style: TextStyle(
                                                                  fontFamily: FontUtils.avertaBold,
                                                                  color: ColorUtils.redColor
                                                              ),
                                                            ),
                                                            Text(DateFormat('MMMM').format(DateTime(0, int.parse(model.myAttendingEventsList[index].eventDate!.substring(5,7)))).toString(),
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
                                                    Text(model.myAttendingEventsList[index].eventName!,
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
                                                          child: Text(model.myAttendingEventsList[index].location!,
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
                                itemCount: model.myAttendingEventsList.length
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
                                Text("Upcoming Events",
                                  style: TextStyle(
                                    fontFamily: FontUtils.avertaSemiBold,
                                    fontSize: 2.5.t,
                                    color: ColorUtils.darkText,
                                  ),
                                ),
                                // Text(
                                //   "See all",
                                //   style: TextStyle(
                                //     shadows: [
                                //       Shadow(
                                //           color: ColorUtils.blueColor,
                                //           offset: Offset(0, -1))
                                //     ],
                                //     color: Colors.transparent,
                                //     decoration:
                                //     TextDecoration.underline,
                                //     decorationColor: ColorUtils.blueColor,
                                //     //decorationThickness: 4,
                                //   ),
                                // )
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
                                      // model.gettingAttendeeDetails(model.upComingeventsList[index].id!,index);
                                      // await model.numberOfAttendee(model.upComingeventsList[index].id!, index);
                                      await model.numberOfAttendee(model.upComingeventsList[index].eventId!, index);


                                      //Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:DeleteEvent()));
                                      //model.myEvents(model.eventsList[index].id!,index);
                                      // model.myEventsSelected = false;
                                      // model.notifyListeners();
                                      /*model.navigationService.navigateTo(to: AllEventsDetail(
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
                                      )*/
                                      // model.gettingMyEvents = false;
                                      // model.notifyListeners();
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
                                ),
                          ),
                          SizedBox(height: 6.h,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ) : Loader2();
      },
    );
  }
}
