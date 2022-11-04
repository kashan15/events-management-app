import 'package:cached_network_image/cached_network_image.dart';
import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/utils/size_config.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/AllEvents/all_events_detail.dart';
import 'package:democratic_unity/views/Volunteer/eventsVolunteering_details.dart';
import 'package:democratic_unity/views/Volunteer/upcoming_volunteer_details.dart';
import 'package:democratic_unity/views/drawer.dart';
import 'package:democratic_unity/widgets/loader_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stacked/stacked.dart';

class Volunteer extends StatefulWidget {
  const Volunteer({Key? key}) : super(key: key);

  @override
  _VolunteerState createState() => _VolunteerState();
}

class _VolunteerState extends State<Volunteer> {


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model){
        model.getAllVolunteerEvents();
        model.volunteeringEventsById();
      },
      builder: (context, model, child) {
        return
        model.isLoading == true ? Loader2() :
          SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            key: _scaffoldKey,
            drawer: DrawerScreen(),
            // bottomNavigationBar: MyCurvedNavBar(
            //   barIconColor: ColorUtils.silverColor,
            //   selectedIconColor: Colors.white,
            //   buttonBackgroundColor: ColorUtils.blueColor,
            //   index: currentIndex,
            //   animationCurve: Curves.ease,
            //   animationDuration: Duration(milliseconds: 300),
            //   backgroundColor: Colors.white,
            //   height: 8.h,
            //   parentDecoration: BoxDecoration(
            //       boxShadow: [BoxShadow(
            //           color: Color(0xFFefefef),
            //           blurRadius: 3.i,
            //           offset: Offset(0,-10)
            //       )]
            //   ),
            //   items: [
            //     ImageUtils.homeIcon,
            //     ImageUtils.chatIcon,
            //     ImageUtils.addIcon,
            //     ImageUtils.searchIcon,
            //     ImageUtils.calenderIcon,
            //   ],
            //   onTap: (index){
            //   },
            // ),
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
                    margin: EdgeInsets.only(left: 1.5.w, right: 4.w),
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
                          "Volunteer",
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
                                Text("Events Volunteering",
                                  style: TextStyle(
                                    fontFamily: FontUtils.avertaSemiBold,
                                    fontSize: 2.6.t,
                                    color: ColorUtils.darkText,
                                  ),
                                ),
                                //SvgPicture.asset(ImageUtils.notificationBell),
                              ],
                            ),
                          ),
                          SizedBox(height: 3.h,),
                          Container(
                            margin: EdgeInsets.only(right: 1.w),
                            height: 38.5.h,
                            //width: 70.w,
                            child:
                            model.volunteerEventsByUserId.length != 0 ?
                            ListView.separated(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                //padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: (){
                                       model.volunteerEventSelected = true;
                                       model.notifyListeners();
                                       String? myString = model.volunteerEventsByUserId[index].volunteertypes;
                                       List<String> stringList = myString!.split(",");
                                       model.navigationService.navigateTo(to: EventsVolunteeringDetails(
                                         index: index,
                                         // eventId: model.volunteerEventsList[index].id,
                                         eventId: model.volunteerEventsList[index].eventId,
                                         eventName: model.volunteerEventsByUserId[index].eventName,
                                         // userId: model.volunteerEventsByUserId[index].UserId,
                                         userId: model.volunteerEventsByUserId[index].userId,

                                         volunteerList: stringList,
                                       ));
                                      // model.gettingAttendeeDetails(
                                      //   model.volunteerEventsList[index].id!,index,
                                      // );
                                      // model.navigationService.navigateTo(to: VolunteerDetails(
                                      //   index: index,
                                      //   eventId: model.volunteerEventsList[index].id,
                                      //   eventName: model.volunteerEventsList[index].eventName,
                                      //   userId: model.volunteerEventsList[index].UserId,
                                      // ));
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
                                                        imageUrl: model.volunteerEventsByUserId[index].eventBanner!,
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
                                                            Text(model.volunteerEventsByUserId[index].eventDate!.substring(8,10),
                                                              //model.eventsList[index].timings!.substring(0, 10),
                                                              style: TextStyle(
                                                                  fontFamily: FontUtils.avertaBold,
                                                                  color: ColorUtils.redColor
                                                              ),
                                                            ),
                                                            SizedBox(width: 1.w,),
                                                            Text( DateFormat('MMMM').format(DateTime(0, int.parse(model.volunteerEventsByUserId[index].eventDate!.substring(5,7)))).toString(),
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
                                                    Text(model.volunteerEventsByUserId[index].eventName!,
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
                                                          child: Text(model.volunteerEventsByUserId[index].location!,
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
                                itemCount: model.volunteerEventsByUserId.length
                            )
                                :
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
                                Text("Upcoming Volunteer Events",
                                  style: TextStyle(
                                    fontFamily: FontUtils.avertaSemiBold,
                                    fontSize: 2.5.t,
                                    color: ColorUtils.darkText,
                                  ),
                                ),
                                //SvgPicture.asset(ImageUtils.notificationBell),
                              ],
                            ),
                          ),
                          SizedBox(height: 3.h,),
                          Container(
                            margin: EdgeInsets.only(right: 1.w),
                            // height: 38.5.h,
                              height: 40.h,
                            //width: 70.w,
                            child:
                            // model.volunteerEventsList.length != 0 ?
                            model.volunteerEventsList.length != 0 ?
                            ListView.separated(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                //padding: EdgeInsets.zero,

                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: (){


                                      // model.volunteerEventSelected = true;
                                      // model.notifyListeners();
                                      // model.gettingAttendeeDetails(
                                      //   model.volunteerEventsList[index].id!,index,
                                      // );
                                      // model.volunteerEventSelected = false;
                                      // model.notifyListeners();
                                      // model.navigationService.navigateTo(to: VolunteerDetails(
                                      //     index: index,
                                      //     eventId: model.volunteerEventsList[index].id,
                                      //     eventName: model.volunteerEventsList[index].eventName,
                                      //     userId: model.volunteerEventsList[index].UserId,
                                      //     volunteerList: [],
                                      // ));


                                      model.gettingVolunteerAttendeeDetails(
                                        model.volunteerEventsList[index].id??'',index,
                                        // model.volunteerEventsList[index].eventId??'',index,
                                        // model.volunteerEventsList[index].Id??'',index
                                      );
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
                                                      child: CachedNetworkImage(imageUrl: model.volunteerEventsList[index].eventBanner!,
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
                                                            Text(model.volunteerEventsList[index].eventDate!.substring(8,10),
                                                              //model.eventsList[index].timings!.substring(0, 10),
                                                              style: TextStyle(
                                                                  fontFamily: FontUtils.avertaBold,
                                                                  color: ColorUtils.redColor
                                                              ),
                                                            ),
                                                            SizedBox(width: 1.w,),
                                                            Text( DateFormat('MMMM').format(DateTime(0, int.parse(model.volunteerEventsList[index].eventDate!.substring(5,7)))).toString(),
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
                                                    Text(model.volunteerEventsList[index].eventName!,
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

                                    //                 Row(
                                    //                   mainAxisSize: MainAxisSize.min,
                                    //                   children: [
                                    //                     model.voluntreeLength != 0 ?
                                    //                     Container(
                                    //                         height: 5.h,
                                    //                         child: Stack(
                                    //                           children: [
                                    //                             Container(
                                    //                                 decoration:
                                    //                                 BoxDecoration(
                                    //                                   borderRadius:
                                    //                                   BorderRadius.only(
                                    //                                     bottomLeft: Radius.circular(20.0),
                                    //                                     topLeft: Radius.circular(20.0),
                                    //                                     bottomRight: Radius.circular(20.0),
                                    //                                     topRight: Radius.circular(20.0),
                                    //                                   ),
                                    //                                   border: Border.all(
                                    //                                       color: Colors.white,
                                    //                                       width: 4.0),
                                    //                                 ),
                                    //                                 margin: EdgeInsets.only(
                                    //                                     left: 4 * SizeConfig.widthMultiplier,
                                    //                                     right: 4 * SizeConfig.widthMultiplier),
                                    //     //                             child: ClipOval(
                                    //     //
                                    //     //                               // child:(model.voluntreesProfilePics!=null)&&
                                    //     //                               //     (model.voluntreesProfilePics?.length) !> 0
                                    //     //
                                    //     //                               child: model.voluntreesProfilePics!.length > 0
                                    //     //                                   ? CachedNetworkImage(
                                    //     //                                 imageUrl: model.voluntreesProfilePics?[0]??'',
                                    //     //                                 width: SizeConfig.imageSizeMultiplier * 8,
                                    //     //                                 height: SizeConfig.imageSizeMultiplier * 8,
                                    //     //                                 errorWidget: (context, url, error) => new Image.asset(ImageUtils.error),
                                    //     //
                                    //     //                                 fit: BoxFit.cover,
                                    //     //                               )
                                    //     //                                   : Container(),
                                    //     //                               /*Image.asset(
                                    //     //   ImageUtils.avatar,
                                    //     //   width: SizeConfig.imageSizeMultiplier * 8,
                                    //     //   height: SizeConfig.imageSizeMultiplier * 8,
                                    //     // ),*/
                                    //     //                             )),
                                    //
                                    //
                                    //                                 child: ClipOval(
                                    //
                                    //
                                    //
                                    //                                   // child:(model.voluntreesProfilePics!=null)&&
                                    //                                   //     (model.voluntreesProfilePics?.length) !> 0
                                    //
                                    //
                                    //
                                    //                                   child: (model.voluntreesProfilePics != null)
                                    //                                       ? CachedNetworkImage(
                                    //                                     imageUrl: model.voluntreesProfilePics?[0]??'',
                                    //                                     width: SizeConfig.imageSizeMultiplier * 8,
                                    //                                     height: SizeConfig.imageSizeMultiplier * 8,
                                    //                                     // errorWidget: (context, url, error) => new Image.asset(ImageUtils.error),
                                    //
                                    //                                     fit: BoxFit.cover,
                                    //                                   )
                                    //                                       : Container(),
                                    //                                   /*Image.asset(
                                    //       ImageUtils.avatar,
                                    //       width: SizeConfig.imageSizeMultiplier * 8,
                                    //       height: SizeConfig.imageSizeMultiplier * 8,
                                    //     ),*/
                                    //                                 )),
                                    //
                                    //                             Container(
                                    //                               margin: EdgeInsets.only(
                                    //                                   left: 8 * SizeConfig.widthMultiplier,
                                    //                                   right: 8 * SizeConfig.widthMultiplier),
                                    //                               child: ClipOval(
                                    //                                 // child: model.voluntreesProfilePics!.length > 1 ?
                                    //                                 child: (model.voluntreesProfilePics != null)?
                                    //                                 CachedNetworkImage(
                                    //                                   imageUrl: model.voluntreesProfilePics![1],
                                    //                                   width: SizeConfig.imageSizeMultiplier * 8,
                                    //                                   height: SizeConfig.imageSizeMultiplier * 8,
                                    //                                   fit: BoxFit.cover,
                                    //                                 )
                                    //                                     : Container(),
                                    //                                 /*Image.asset(
                                    //     ImageUtils.avatar,
                                    //     width: SizeConfig.imageSizeMultiplier * 8,
                                    //     height: SizeConfig.imageSizeMultiplier * 8,
                                    // ),*/
                                    //                               ),
                                    //                               decoration:
                                    //                               BoxDecoration(
                                    //                                 borderRadius:
                                    //                                 BorderRadius
                                    //                                     .only(
                                    //                                   bottomLeft: Radius.circular(20.0),
                                    //                                   topLeft: Radius.circular(20.0),
                                    //                                   bottomRight: Radius.circular(20.0),
                                    //                                   topRight: Radius.circular(20.0),
                                    //                                 ),
                                    //                                 border: Border.all(
                                    //                                     color: Colors.white,
                                    //                                     width: 4.0),
                                    //                               ),
                                    //                             ),
                                    //                             Container(
                                    //                               margin: EdgeInsets.only(
                                    //                                   left: 8 * SizeConfig.widthMultiplier,
                                    //                                   right: 8 * SizeConfig.widthMultiplier),
                                    //                               child: ClipOval(
                                    //                                 // child: model.voluntreesProfilePics!.length > 2 ?
                                    //                                 child: (model.voluntreesProfilePics != null)?
                                    //                                 CachedNetworkImage(
                                    //                                   imageUrl: model.voluntreesProfilePics![2],
                                    //                                   width: SizeConfig.imageSizeMultiplier * 8,
                                    //                                   height: SizeConfig.imageSizeMultiplier * 8,
                                    //                                   fit: BoxFit.cover,
                                    //                                 )
                                    //                                     : Container(),
                                    //                                 /*Image.asset(
                                    //     ImageUtils.avatar,
                                    //     width: SizeConfig.imageSizeMultiplier * 8,
                                    //     height: SizeConfig.imageSizeMultiplier * 8,
                                    // ),*/
                                    //                               ),
                                    //                               decoration:
                                    //                               BoxDecoration(
                                    //                                 borderRadius:
                                    //                                 BorderRadius.only(
                                    //                                   bottomLeft: Radius.circular(20.0),
                                    //                                   topLeft: Radius.circular(20.0),
                                    //                                   bottomRight: Radius.circular(20.0),
                                    //                                   topRight: Radius.circular(20.0),
                                    //                                 ),
                                    //                                 border: Border.all(
                                    //                                     color: Colors.white,
                                    //                                     width: 4.0),
                                    //                               ),
                                    //                             ),
                                    //
                                    //
                                    //                           ],
                                    //                         )
                                    //                     )
                                    //                         : Image.asset(ImageUtils.avatar,
                                    //                       width: SizeConfig.imageSizeMultiplier * 8,
                                    //                       height: SizeConfig.imageSizeMultiplier * 8,
                                    //                     ),
                                    //                     SizedBox(
                                    //                       width: 3.w,
                                    //                     ),
                                    //                     Text(
                                    //                       model.voluntreeLength.toString() +
                                    //                           " Going",
                                    //                       //"+ 20 Going",
                                    //                       style: TextStyle(
                                    //                           fontFamily:
                                    //                           FontUtils.avertaBold,
                                    //                           fontSize: 1.8.t,
                                    //                           color: ColorUtils.redColor),
                                    //                     ),
                                    //                   ],
                                    //                 ),

                                                    SizedBox(height: 1.h,),
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(ImageUtils.location),
                                                        SizedBox(width: 1.w,),
                                                        Flexible(
                                                          child: Text(model.volunteerEventsList[index].location!,
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
                                itemCount: model.volunteerEventsList.length
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
                          SizedBox(height: 6.h,),
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
}
