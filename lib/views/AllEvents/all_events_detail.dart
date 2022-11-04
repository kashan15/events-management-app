import 'package:cached_network_image/cached_network_image.dart';
import 'package:democratic_unity/Services/delete_event.dart';
import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/dimensions.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/AllEvents/delete_event.dart';
import 'package:democratic_unity/views/EventDetails/attendees_list.dart';
import 'package:democratic_unity/views/EventDetails/chat_screen.dart';
import 'package:democratic_unity/views/Notifications/notifications.dart';
import 'package:democratic_unity/views/main_view.dart';
import 'package:democratic_unity/widgets/back_arrow_with_container.dart';
import 'package:democratic_unity/widgets/loader_2.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stacked/stacked.dart';

class AllEventsDetail extends StatefulWidget {
  final int index;
  String? eventId;
  String? id;
  String? Id;
  String? eventBanner;
  int? attendeeLength;
  String? eventName;
  String? eventDate;
  String? timeFrom;
  String? timeTo;
  String? location;
  String? profileImage;
  String? fName;
  String? eventDescription;
  AllEventsDetail({
    required
    this.index,
    this.eventId,
    this.id,
    this.Id,
    this.eventBanner,
    this.attendeeLength,
    this.eventName,
    this.eventDate,
    this.timeFrom,
    this.timeTo,
    this.location,
    this.profileImage,
    this.fName,
    this.eventDescription,
    Key? key
  }) : super(key: key);

  @override
  _AllEventsDetailState createState() => _AllEventsDetailState();
}

class _AllEventsDetailState extends State<AllEventsDetail> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      onModelReady: (model) {
       // await model.gettingAttendeeDetails(model.eventsList[widget.index].id!);
      },
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return
          // model.isLoading? Loader2():
          // model.isloading1? Loader2():
          model.isLoading == true ? Loader2():
          SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
              //drawer: DrawerScreen(),
              // floatingActionButton:
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 4.w),
              //   child: Container(
              //     decoration: BoxDecoration(
              //       shape: BoxShape.rectangle,
              //       borderRadius: BorderRadius.all(Radius.circular(16.0)),
              //     ),
              //     child: AnimatedContainer(
              //       duration: Duration(milliseconds: 400),
              //       width: MediaQuery.of(context).size.width / 1,
              //       height: 6.5.h,
              //       //margin: EdgeInsets.symmetric(horizontal: 5.w),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(6),
              //         color: ColorUtils.blueColor,
              //         boxShadow: [
              //           BoxShadow(
              //             color: ColorUtils.blueColor.withOpacity(0.25),
              //             spreadRadius: 0,
              //             blurRadius: 10,
              //             offset: Offset(0, 5), // changes position of shadow
              //           ),
              //         ],
              //       ),
              //       child: MaterialButton(
              //         padding: EdgeInsets.zero,
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(6)),
              //         onPressed: () {
              //           // if(model.attendingEvent == false){
              //           //   model.attendingTheEvent(model
              //           //       .eventsList[widget.index].id!, widget.index,);
              //           // }
              //           // model.attendingEvent = !model.attendingEvent;
              //           // model.notifyListeners();
              //           model.attendingTheEvent(model
              //               .eventsList[widget.index].id!, widget.index,);
              //         },
              //         child: Row(
              //           mainAxisSize: MainAxisSize.min,
              //           children: [
              //             if (model.containsId == true)
              //             // model.eventsList[widget.index].id == model.attendeeEventId
              //             //     &&
              //             //     model.attendeesUserId!.contains(model.userId))
              //               SvgPicture.asset(ImageUtils.attendingCheck),
              //             SizedBox(
              //               width: 2.w,
              //             ),
              //             model.attendingTheEvents == false ?
              //             Text(
              //               // model.eventsList[widget.index].id == model.attendeeEventId
              //               // &&
              //               model.containsId == true
              //               //model.attendeeId == model.userId
              //               //model.attendingEvent == true
              //               // &&
              //               // model.eventsList[widget.index].id! == model.userId
              //                   ? "Attending Event"
              //                   : "Attend Event",
              //               style: TextStyle(
              //                   fontFamily: FontUtils.avertaSemiBold,
              //                   fontSize: 2.2.t,
              //                   color: Colors.white),
              //             ) : Loader(),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // floatingActionButtonLocation:
              // FloatingActionButtonLocation.centerFloat,
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
                          ),
                          child: CachedNetworkImage(
                            width: MediaQuery.of(context).size.width / 1,
                            imageUrl:widget.eventBanner!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          margin:
                          EdgeInsets.only(left: 4.w, right: 4.w, top: 3.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                              // if(model.myEventsSelected == true)

                              Container(
                                //width: 5.w,
                                child: PopupMenuButton(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                                      child: Icon(Icons.more_vert,
                                      color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  itemBuilder: (_) => <PopupMenuItem<String>>[
                                    new PopupMenuItem<String>(
                                        child: new Text('Delete Event'), value: 'Delete Event'),
                                    // new PopupMenuItem<String>(
                                    //     child: new Text('Report'), value: 'Report'),
                                  ],
                                  onSelected: (onSelected){
                                    // model.deletingTheEvent(widget.eventId??'');
                                    // model.deletingTheEvent(widget.id??'');
                                    // model.isloading1 == true ? Loader2():

                                   DeleteEventService().isLoading1 ? Loader2() :
                                    DeleteEventService().deleteEvent(
                                        model.upComingeventsList[widget.index].id??'',
                                        model.userId??'');
                                        model.notifyListeners();
                                        model.navigationService.navigateToUntil(
                                          to: MainView(
                                        index: 0,
                                      ));
                                  },

                                ),
                              ),
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      model.navigationService
                                          .navigateTo(to: AttendeesList());
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          ImageUtils.groupGoing,
                                          width: 18.i,
                                          height: 8.i,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        Text(
                                          widget.attendeeLength.toString() + " Going",
                                          //"+ 20 Going",
                                          style: TextStyle(
                                              fontFamily: FontUtils.avertaBold,
                                              fontSize: 1.8.t,
                                              color: ColorUtils.redColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Share.share("Hello");
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: ColorUtils.redColor,
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6))),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 3.w, vertical: 1.0.h),
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
                              widget.eventName!,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        Text(widget.eventDate!.split(' ')[0].substring(8, 10) + " " +
                                              DateFormat('MMMM').format(DateTime(0, int.parse(widget.eventDate!.split(' ')[0].substring(5, 7)))).toString() +
                                              "," +
                                              " " +
                                              widget.eventDate!.split(' ')[0].substring(0, 4),
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
                                          DateFormat('EEEE').format(DateTime.parse(widget.eventDate!.split(' ')[0])) +
                                              "," +
                                              " " +
                                              // DateFormat.jm().format(DateTime.parse(widget.eventDate! + " " + widget.timeFrom!))
                                              // +
                                              // " - "
                                              // +
                                              // DateFormat.jm().format(DateTime.parse(widget.eventDate! + " " + widget.timeTo!))
                                          //     widget.eventDate!.split(' ')[0] + " " + widget.timeFrom!
                                          // +
                                          // " - "
                                          // +
                                          //     widget.eventDate!.split(' ')[0] + " " + widget.timeTo!,

                                          widget.timeFrom!
                                              + " - "
                                              +
                                              widget.timeTo!,

                                          style: TextStyle(
                                              fontFamily:
                                              FontUtils.avertaDemoRegular,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                              widget.location!.toString().split(',')[0],
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
                                              widget.location!,
                                              style: TextStyle(
                                                  fontFamily:
                                                  FontUtils.avertaDemoRegular,
                                                  fontSize: 1.6.t,
                                                  color: ColorUtils.darkText),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: ColorUtils.eventIconBg,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12.0),
                                        child: CachedNetworkImage(
                                          imageUrl:widget.profileImage?? '',
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
                                          widget.fName ?? "",
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
                                              fontFamily:
                                              FontUtils.avertaDemoRegular,
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
                                            child: ChatScreen()));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: ColorUtils.eventIconBg,
                                      shape: BoxShape.rectangle,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 3.5.w, vertical: 1.h),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(ImageUtils.red_chat),
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
                                  widget.eventDescription!,
                                  style: TextStyle(
                                      fontFamily: FontUtils.modernistRegular,
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
          );
        // : Loader2();
      },
    );
  }
}
