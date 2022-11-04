import 'package:cached_network_image/cached_network_image.dart';
import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/dimensions.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/Volunteer/volunteer.dart';
import 'package:democratic_unity/views/main_view.dart';
import 'package:democratic_unity/widgets/back_arrow_with_container.dart';
import 'package:democratic_unity/widgets/loader_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stacked/stacked.dart';

class EventsVolunteeringDetails extends StatefulWidget {

  int? index;
  String? eventId;
  String? eventName;
  String? userId;
  List? volunteerList;

  EventsVolunteeringDetails({this.index, this.eventId, this.eventName, this.userId, this.volunteerList, Key? key}) : super(key: key);

  @override
  _EventsVolunteeringDetailsState createState() => _EventsVolunteeringDetailsState();
}

class _EventsVolunteeringDetailsState extends State<EventsVolunteeringDetails> {
  @override
  Widget build(BuildContext context) {
     return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return model.isLoading == true ? Loader2() :
        SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            floatingActionButton:
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              child:
              Container(
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
                        await model.volunteeringTheEvents(widget.eventId!, widget.volunteerList!.join(","), widget.eventName!);
                        //model.navigationService.navigateToUntil(to: MainView(index: 0,));
                        Navigator.pushAndRemoveUntil(
                            context,
                            PageTransition(
                                child: MainView(index: 0,), type: PageTransitionType.fade),
                                (route) => false);


                        model.notifyListeners();
                        model.showVolunteerDialog(
                          context,
                          widget.eventId!,
                          widget.eventName!,
                        );
                      },



                      child:
                      //model.volunteerEventSelected == true ?
                      Text(
                        "Remove Volunteering",
                        style: TextStyle(
                            fontFamily: FontUtils.avertaSemiBold,
                            fontSize: 2.2.t,
                            color: Colors.white),
                      )

                  ),
                ),

                // MaterialButton(
                //     onPressed: onButtonPressed,
                //   color: ColorUtils.greenColor,
                //   minWidth: MediaQuery.of(context).size.width /1,
                //   height: 7.h,
                //   textColor: Colors.white,
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(6.0),
                //   ),
                //   // style: ElevatedButton.styleFrom(
                //   //     primary: ColorUtils.greenColor,
                //   //     shadowColor: ColorUtils.greenColor.withOpacity(0.25),
                //   //     shape: RoundedRectangleBorder(
                //   //         borderRadius: BorderRadius.circular(10.0)),
                //   //     minimumSize: Size(MediaQuery.of(context).size.width /1, 7.h),
                //   //   ),
                //     child: Text(
                //       textValue!,
                //       textAlign: TextAlign.center,
                //       style: TextStyle(
                //         fontFamily: FontUtils.avertaSemiBold,
                //         fontSize: 2.2.t,
                //         color: Colors.white,
                //       ),
                //     ),
                // ),
              )
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            backgroundColor: Colors.white,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: context.getPadding().top,),
                Container(
                  height: MediaQuery.of(context).size.height /2.7,
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 3.5.h),
                        decoration: BoxDecoration(
                          color: ColorUtils.blueColor,
                        ),
                        child: CachedNetworkImage(
                          width: MediaQuery.of(context).size.width / 1,
                          imageUrl:model.volunteerEventsByUserId[widget.index!].eventBanner!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 4.w, right: 4.w, top: 3.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                BackArrowContainer(),
                                SizedBox(width: 3.w,),
                                Text("Event Details",
                                  style: TextStyle(
                                      fontFamily: FontUtils.avertaBold,
                                      fontSize: 2.7.t,
                                      color: Colors.white
                                  ),
                                ),
                              ],
                            ),
                            SvgPicture.asset(ImageUtils.bellNotification),
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
                                  offset: Offset(0, 5), // changes position of shadow
                                ),
                              ],
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(30))
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 7.w),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.6.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    //model.navigationService.navigateTo(to: AttendeesList());
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(ImageUtils.groupGoing,
                                        width: 18.i,
                                        height: 8.i,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(width: 3.w,),
                                      Text("Volunteering",
                                        style: TextStyle(
                                            fontFamily: FontUtils.avertaBold,
                                            fontSize: 1.8.t,
                                            color: ColorUtils.redColor
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Share.share("Hello");
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: ColorUtils.redColor,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(Radius.circular(6))
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.0.h),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(ImageUtils.uploadIcon),
                                          SizedBox(width: 2.w,),
                                          Text("Share",
                                            style: TextStyle(
                                                fontFamily: FontUtils.avertaBold,
                                                fontSize: 1.6.t,
                                                color: Colors.white
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
                            model.volunteerEventsByUserId[widget.index!].eventName!,
                            style: TextStyle(
                                fontFamily: FontUtils.avertaBold,
                                fontSize: 3.t,
                                color: ColorUtils.titleText
                            ),
                          ),
                          SizedBox(height: 3.h,),
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
                                      Text(
                                        model.volunteerEventsByUserId[widget.index!]
                                            .eventDate!
                                            .substring(8, 10) +
                                            " " +
                                            DateFormat('MMMM')
                                                .format(DateTime(
                                                0,
                                                int.parse(model
                                                    .volunteerEventsByUserId[
                                                widget.index!]
                                                    .eventDate!
                                                    .substring(5, 7))))
                                                .toString() +
                                            "," +
                                            " " +
                                            model.volunteerEventsByUserId[widget.index!]
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
                                        DateFormat('EEEE').format(
                                            DateTime.parse(model
                                                .volunteerEventsByUserId[
                                            widget.index!]
                                                .eventDate!)) +
                                            ","
                                            +
                                            " "
                                            +
                                            DateFormat.jm().format(DateTime.parse(model.volunteerEventsByUserId[widget.index!].eventDate! + " " + model.volunteerEventsByUserId[widget.index!].timeFrom!))
                                            +
                                            " - "
                                            +
                                            DateFormat.jm().format(DateTime.parse(model.volunteerEventsByUserId[widget.index!].eventDate! + " " + model.volunteerEventsByUserId[widget.index!].timeTo!))
                                        ,
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

                          SizedBox(height: 3.h,),
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
                                            model.volunteerEventsByUserId[widget.index!].location!.toString().split(',')[0],
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
                                            model.volunteerEventsByUserId[widget.index!].location!,
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

                          SizedBox(height: 3.h,),
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
                                        imageUrl:model.volunteerEventsByUserId[widget.index!].ProfileImage!,
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
                                        model.volunteerEventsByUserId[widget.index!].fname!,
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
                              /*GestureDetector(
                                onTap: () {
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
                              ),*/
                            ],
                          ),

                          if(model.volunteerEventSelected == true)
                            Column(
                              children: [
                                SizedBox(height: 6.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Volunteering As",
                                      style: TextStyle(
                                          fontFamily: FontUtils.modernistBold,
                                          fontSize: 2.2.t,
                                          color: ColorUtils.titleText
                                      ),
                                    ),
                                    // Container(
                                    //   margin: EdgeInsets.only(top: 1.25.h),
                                    //   child: Text(
                                    //     "Edit",
                                    //     style: TextStyle(
                                    //       shadows: [
                                    //         Shadow(
                                    //             color: ColorUtils.blueColor,
                                    //             offset: Offset(0, -2))
                                    //       ],
                                    //       color: Colors.transparent,
                                    //       decoration:
                                    //       TextDecoration.underline,
                                    //       decorationColor: ColorUtils.blueColor,
                                    //       //decorationThickness: 4,
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                ),
                                SizedBox(height: 2.5.h,),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(6)),
                                    border: Border.all(color: ColorUtils.blueColor),
                                  ),
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding:  EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.75.h),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: ColorUtils.blueColor,
                                              borderRadius: BorderRadius.all(Radius.circular(4)),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                widget.volunteerList![index],
                                                style: TextStyle(
                                                  fontFamily: FontUtils.modernistRegular,
                                                  fontSize: 1.7.t,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: widget.volunteerList!.length,
                                  ),
                                ),
                              ],
                            ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5.h,),
                              Text("Event Agenda",
                                style: TextStyle(
                                    fontFamily: FontUtils.modernistBold,
                                    fontSize: 2.2.t,
                                    color: ColorUtils.titleText
                                ),
                              ),

                              SizedBox(height: 2.h,),
                              Text(
                                model.volunteerEventsByUserId[widget.index!].eventDescription!,
                                style: TextStyle(
                                    fontFamily: FontUtils.modernistRegular,
                                    fontSize: 1.9.t,
                                    color: ColorUtils.darkText
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 7.h,),
                        ],
                      ),
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
}
