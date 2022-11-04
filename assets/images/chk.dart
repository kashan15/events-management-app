import 'package:cached_network_image/cached_network_image.dart';
import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/dimensions.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/utils/size_config.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/EventDetails/attendees_list.dart';
import 'package:democratic_unity/views/EventDetails/chat_screen.dart';
import 'package:democratic_unity/views/Notifications/notifications.dart';
import 'package:democratic_unity/views/drawer.dart';
import 'package:democratic_unity/widgets/back_arrow_with_container.dart';
import 'package:democratic_unity/widgets/custom_button.dart';
import 'package:democratic_unity/widgets/loader.dart';
import 'package:democratic_unity/widgets/loader_2.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stacked/stacked.dart';

class EventDetails extends StatefulWidget {
  int index;

  EventDetails({required this.index, Key? key}) : super(key: key);

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      onModelReady: (model) {
        //await model.gettingAttendeeDetails(model.eventsList[widget.index].id!);
      },
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return model.isLoading == false
            ?
        //model.gettingTheAttendee == false ?
        SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            drawer: DrawerScreen(),
            floatingActionButton: model
                .upComingeventsList[widget.index].UserId !=
                model.userId!
                ? Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius:
                    BorderRadius.all(Radius.circular(16.0)),
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
                          color:
                          ColorUtils.blueColor.withOpacity(0.25),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: Offset(
                              0, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      onPressed: () {
                        if (model.containsId == true) {
                          model.containsId = false;
                          model.notifyListeners();
                        }
                        // if(model.attendingEvent == false){
                        //   model.attendingTheEvent(model
                        //       .eventsList[widget.index].id!, widget.index,);
                        // }
                        // model.attendingEvent = !model.attendingEvent;
                        // model.notifyListeners();
                        model.attendingTheEvent(
                          model.upComingeventsList[widget.index].id!,
                          widget.index,
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (model.containsId == true)
                          // model.eventsList[widget.index].id == model.attendeeEventId
                          //     &&
                          //     model.attendeesUserId!.contains(model.userId))
                            SvgPicture.asset(
                                ImageUtils.attendingCheck),
                          SizedBox(
                            width: 2.w,
                          ),
                          model.attendingTheEvents == false
                              ? Text(
                            // model.eventsList[widget.index].id == model.attendeeEventId
                            // &&
                            model.containsId == true
                            //model.attendeeId == model.userId
                            //model.attendingEvent == true
                            // &&
                            // model.eventsList[widget.index].id! == model.userId
                                ? "Attending Event"
                                : "Attend Event",
                            style: TextStyle(
                                fontFamily:
                                FontUtils.avertaSemiBold,
                                fontSize: 2.2.t,
                                color: Colors.white),
                          )
                              : Loader(),
                        ],
                      ),
                    ),
                  ),
                ))
                : Container(),
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerFloat,
            backgroundColor: Colors.white,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: context.getPadding().top,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2.7,
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 3.5.h),
                        decoration: BoxDecoration(
                          color: ColorUtils.blueColor,
                          // image: DecorationImage(
                          //     image: CachedNetworkImage(
                          //         imageUrl:model.eventsList[widget.index].eventBanner!
                          //     ),
                          //     fit: BoxFit.cover)
                        ),
                        child: CachedNetworkImage(
                          width: MediaQuery.of(context).size.width / 1,
                          imageUrl: model.upComingeventsList[widget.index]
                              .eventBanner!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 4.w, right: 4.w, top: 3.h),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                BackArrowContainer(),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Text(
                                  "Event Details",
                                  style: TextStyle(
                                      fontFamily: FontUtils.avertaBold,
                                      fontSize: 2.7.t,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            /*ExpandTapWidget(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType.fade,
                                              child: AllNotifications()));
                                    },
                                    tapPadding: EdgeInsets.all(3.i),
                                    child: SvgPicture.asset(
                                        ImageUtils.bellNotification),
                                  ),*/
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 10,
                                  offset: Offset(
                                      0, 5), // changes position of shadow
                                ),
                              ],
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius:
                              BorderRadius.all(Radius.circular(30))),
                          margin: EdgeInsets.symmetric(horizontal: 7.w),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 1.6.h),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    model.navigationService.navigateTo(
                                        to: AttendeesList(
                                          attendeesLength:
                                          model.attendeesDetails,
                                        ));
                                  },
                                  child: Row(
                                    children: [
                                      // Image.asset(
                                      //   ImageUtils.groupGoing,
                                      //   width: 18.i,
                                      //   height: 8.i,
                                      //   fit: BoxFit.cover,
                                      // ),
                                      model.attendeeLength != 0
                                          ? Container(
                                        height: 5.h,
                                        child: Stack(
                                          children: [
                                            Container(
                                              margin:
                                              EdgeInsets.only(
                                                top: 1.5 *
                                                    SizeConfig
                                                        .widthMultiplier,
                                              ),
                                              child: ClipOval(
                                                child: model.attendeesProfilePics!
                                                    .length >
                                                    0
                                                    ? CachedNetworkImage(
                                                  imageUrl:
                                                  model.attendeesProfilePics![
                                                  0],
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
                                              ),
                                            ),
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
                                                    model.attendeesProfilePics![
                                                    1],
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
                                          ],
                                        ),
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
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Share.share(
                                        "Hi there! to see the latest events download and install UDEM using this link \n ${
                                            'https://drive.google.com/file/d/1z8B7Z7ACTaKca1z9K_5MYoWYwKzt6d2U/view?usp=sharing'}"
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: ColorUtils.redColor,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6))),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 3.w,
                                          vertical: 1.0.h),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              ImageUtils.uploadIcon),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          Text(
                                            "Share",
                                            style: TextStyle(
                                                fontFamily:
                                                FontUtils.avertaBold,
                                                fontSize: 1.6.t,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
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
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      //color: Colors.amber,
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.horizontalPadding,
                        vertical: 3.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.upComingeventsList[widget.index]
                                .eventName!,
                            style: TextStyle(
                                fontFamily: FontUtils.avertaBold,
                                fontSize: 3.t,
                                color: ColorUtils.titleText),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 12.w,
                                    height: 6.h,
                                    decoration: BoxDecoration(
                                        color: ColorUtils.eventIconBg,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        ImageUtils.redCalender,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        model
                                            .upComingeventsList[
                                        widget.index]
                                            .eventDate!
                                            .substring(8, 10) +
                                            " " +
                                            DateFormat('MMMM')
                                                .format(DateTime(
                                                0,
                                                int.parse(model
                                                    .upComingeventsList[
                                                widget.index]
                                                    .eventDate!
                                                    .substring(
                                                    5, 7))))
                                                .toString() +
                                            "," +
                                            " " +
                                            model
                                                .upComingeventsList[
                                            widget.index]
                                                .eventDate!
                                                .substring(0, 4),
                                        style: TextStyle(
                                            fontFamily:
                                            FontUtils.avertaSemiBold,
                                            fontSize: 2.t,
                                            color: ColorUtils.darkText),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Text(
                                        DateFormat('EEEE').format(DateTime.parse(model.upComingeventsList[widget.index].eventDate!)) +
                                            "," +
                                            " " +
                                            DateFormat.jm().format(
                                                DateTime.parse(model
                                                    .upComingeventsList[
                                                widget.index]
                                                    .eventDate! +
                                                    " " +
                                                    model
                                                        .upComingeventsList[
                                                    widget.index]
                                                        .timeFrom!)) +
                                            " - " +
                                            DateFormat.jm().format(
                                                DateTime.parse(model
                                                    .upComingeventsList[widget.index]
                                                    .eventDate! +
                                                    " " +
                                                    model.upComingeventsList[widget.index].timeTo!)),
                                        style: TextStyle(
                                            fontFamily: FontUtils
                                                .avertaDemoRegular,
                                            fontSize: 1.6.t,
                                            color: ColorUtils.darkText),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              //SvgPicture.asset(ImageUtils.forwardIcon),
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 12.w,
                                      height: 6.h,
                                      decoration: BoxDecoration(
                                          color: ColorUtils.eventIconBg,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      child: Center(
                                          child: SvgPicture.asset(
                                              ImageUtils.redLocation)),
                                    ),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            model
                                                .upComingeventsList[
                                            widget.index]
                                                .location!
                                                .toString()
                                                .split(',')[0],
                                            style: TextStyle(
                                                fontFamily: FontUtils
                                                    .avertaSemiBold,
                                                fontSize: 2.t,
                                                color:
                                                ColorUtils.darkText),
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Text(
                                            model
                                                .upComingeventsList[
                                            widget.index]
                                                .location!,
                                            style: TextStyle(
                                                fontFamily: FontUtils
                                                    .avertaDemoRegular,
                                                fontSize: 1.6.t,
                                                color:
                                                ColorUtils.darkText),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //SvgPicture.asset(ImageUtils.forwardIcon),
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: ColorUtils.eventIconBg,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(12.0),
                                      child: CachedNetworkImage(
                                        imageUrl: model
                                            .upComingeventsList[
                                        widget.index]
                                            .ProfileImage??'',
                                        width: 12.i,
                                        height: 12.i,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        model
                                            .upComingeventsList[
                                        widget.index]
                                            .fname??'',
                                        //model.eventsList[widget.index].organizer!,
                                        style: TextStyle(
                                            fontFamily:
                                            FontUtils.avertaSemiBold,
                                            fontSize: 2.t,
                                            color: ColorUtils.darkText),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Text(
                                        "Organizer",
                                        style: TextStyle(
                                            fontFamily: FontUtils
                                                .avertaDemoRegular,
                                            fontSize: 1.6.t,
                                            color: ColorUtils.darkText),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              if(model
                                  .upComingeventsList[widget.index].UserId !=
                                  model.userId!)
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type: PageTransitionType.fade,
                                            child: ChatScreen(
                                              otherFirebaseId: model.upComingeventsList[widget.index].FirebaseUserId??'',
                                              userName: model.upComingeventsList[widget.index].fname!,
                                              profilePicture: model.upComingeventsList[widget.index].ProfileImage!,
                                              otherUserId: model.upComingeventsList[widget.index].UserId!,
                                            )));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: ColorUtils.eventIconBg,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(6)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 3.5.w, vertical: 1.h),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              ImageUtils.red_chat),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          Text("Chat"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                "Event Agenda",
                                style: TextStyle(
                                    fontFamily: FontUtils.modernistBold,
                                    fontSize: 2.2.t,
                                    color: ColorUtils.titleText),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                model.upComingeventsList[widget.index]
                                    .eventDescription!,
                                style: TextStyle(
                                    fontFamily:
                                    FontUtils.modernistRegular,
                                    fontSize: 1.9.t,
                                    color: ColorUtils.darkText),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 7.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
            : Loader2();
      },
    );
  }
// void share(context){
//   showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context){
//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(height: 2.h),
//           ],
//         );
//       }
//   );
// }
}
