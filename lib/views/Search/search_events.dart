import 'package:cached_network_image/cached_network_image.dart';
import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/dimensions.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/utils/size_config.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/AllEvents/all_events_detail.dart';
import 'package:democratic_unity/views/EventDetails/chat_screen.dart';
import 'package:democratic_unity/views/Search/user_profile.dart';
import 'package:democratic_unity/views/drawer.dart';
import 'package:democratic_unity/views/search/search_user.dart';
import 'package:democratic_unity/widgets/cupertino_back_arrow.dart';
import 'package:democratic_unity/widgets/custom_button.dart';
import 'package:democratic_unity/widgets/loader_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stacked/stacked.dart';

//enum SingingCharacter { LeastNumberOfPeople, MostNoOfPeople,}


class SearchEvents extends StatefulWidget {
  const SearchEvents({Key? key}) : super(key: key);

  @override
  _SearchEventsState createState() => _SearchEventsState();
}

class _SearchEventsState extends State<SearchEvents> {

  //SingingCharacter? _character = SingingCharacter.LeastNumberOfPeople;
  //String? _character = "Least No. of People";
  // List<String> _sortOptions = [
  //   "Least No. of People",
  //   "Most No. of People",
  // ];

  // List<String> _sort = ["sort1", "sort2",];
  //
  // String? _sortSelected;
  //
  // List<String> _allUpComings = ["upcoming1", "upcoming2",];
  //
  // String? _selectedUpcoming;

  List places = [
    {
      'image': ImageUtils.event1,
      'eventName': 'Trivia Nights',
      'date': '1st  May- Sat -2:00 PM',
      'location': 'Lot 13 • Oakland, CA',
    },
    {
      'image': ImageUtils.event2,
      'eventName': 'Bar Crawl Stop',
      'date': '1st  May- Sat -2:00 PM',
      'location': 'Lot 13 • Oakland, CA',
    },
    {
      'image': ImageUtils.event3,
      'eventName': 'Singles Night',
      'date': '1st  May- Sat -2:00 PM',
      'location': 'Lot 13 • Oakland, CA',
    },
    {
      'image': ImageUtils.event4,
      'eventName': 'Bar Olympics',
      'date': '1st  May- Sat -2:00 PM',
      'location': 'Lot 13 • Oakland, CA',
    },
    {
      'image': ImageUtils.event3,
      'eventName': 'Singles Night',
      'date': '1st  May- Sat -2:00 PM',
      'location': 'Lot 13 • Oakland, CA',
    },
    {
      'image': ImageUtils.event3,
      'eventName': 'Singles Night',
      'date': '1st  May- Sat -2:00 PM',
      'location': 'Lot 13 • Oakland, CA',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      onModelReady: (model){
        model.userSelected = false;
        model.eventSelected = true;
        model.searchEventsController.clear();
        model.peopleButtonPressed = false;
        model.eventButtonPressed = false;
        model.districtsRadioSelected = false;
        // model.eventButtonPressed = false;
        // model.peopleButtonPressed = false;
        model.searchedDateEvents = [];
        model.allSearchedEventsList = [];
        //model.isLoading = false;
        // model.eventButtonPressed = false;
        // model.doneDatePressed = false;
      },
      disposeViewModel: false,
      builder: (context, model, child) {
        return model.isLoading == true ? Loader2():
        GestureDetector(
          onTap: () {
            context.unFocus();
          },
          child: SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
              drawer: DrawerScreen(),
              backgroundColor: Colors.white,
              body: Container(
                padding: EdgeInsets.only(
                  left: 4.w,
                  right: 4.w,
                  top: 6.h,
                  //vertical: Dimensions.verticalPadding
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: context.getPadding().top,
                    ),
                    Container(
                      child: Row(
                        children: [
                          CupertinoBackArrow(),
                          SizedBox(width: 4.w,),
                          Text("Search",
                            style: TextStyle(
                                fontFamily: FontUtils.avertaSemiBold,
                                fontSize: 3.t,
                                color: ColorUtils.darkText
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 3.h,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          //color: ColorUtils.textFieldBg,
                          borderRadius: BorderRadius.all(
                            Radius.circular(6.0),
                          ),
                          border: Border.all(
                              color: ColorUtils.blueColor)),
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 3,
                        ),
                        child: Row(
                          children: [
                            Container(
                              child: SvgPicture.asset(
                                ImageUtils.textFieldSearchIcon,
                                color: ColorUtils.blueColor,
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
                                  autofocus: true,
                                  onChanged: (String text) async{
                                    if(model.peopleButtonPressed == false && model.searchEventsController.text.length > 0){
                                      // model.searchEventsController.text.length > 0;
                                      // model.notifyListeners();
                                      model.allSearchedEvents(text);
                                    }
                                    if(model.peopleButtonPressed == true && model.searchEventsController.text.length > 0){
                                      // model.searchEventsController.text.length > 0;
                                      // model.notifyListeners();
                                      await model.allSearchedUsers(text);
                                    }
                                  },
                                  // onTap: () {
                                  //   model.allSearchedEvents(model.searchEventsController.text);
                                  // },
                                  enabled: true,
                                  style: TextStyle(
                                    fontFamily: FontUtils.avertaDemoRegular,
                                    color: ColorUtils.blueColor,
                                    fontSize: SizeConfig.textMultiplier * 1.9,
                                  ),
                                  //readOnly: true,
                                  //focusNode: model.searchFocus,
                                  controller: model.searchEventsController,
                                  decoration: InputDecoration(
                                    // hintText:
                                    // "Cusco",
                                    // hintStyle: TextStyle(
                                    //   fontFamily:
                                    //   FontUtils.avertaDemoRegular,
                                    //   color: ColorUtils.blueColor,
                                    //   fontSize:
                                    //   SizeConfig.textMultiplier *
                                    //       1.9,
                                    // ),
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
                            //SvgPicture.asset(ImageUtils.targetIcon),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h,),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child:
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: Container(
                      //         //margin: EdgeInsets.symmetric(horizontal: 4.w),
                      //         child: Container(
                      //           decoration: BoxDecoration(
                      //             shape: BoxShape.rectangle,
                      //             borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      //           ),
                      //           child: AnimatedContainer(
                      //             duration: Duration(milliseconds: 400),
                      //             width: MediaQuery.of(context).size.width / 1,
                      //             height: 6.5.h,
                      //             //margin: EdgeInsets.symmetric(horizontal: 5.w),
                      //             decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(6),
                      //               color: model.eventSelected == true ?  ColorUtils.blueColor : Colors.white,
                      //               boxShadow: [
                      //                 if(model.eventSelected == true)
                      //                 BoxShadow(
                      //                   color: ColorUtils.blueColor.withOpacity(0.25),
                      //                   spreadRadius: 0,
                      //                   blurRadius: 10,
                      //                   offset: Offset(0, 5), // changes position of shadow
                      //                 ),
                      //               ],
                      //             ),
                      //             child: MaterialButton(
                      //               padding: EdgeInsets.zero,
                      //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      //               onPressed: (){
                      //                 // model.eventSelected = true;
                      //                 // model.userSelected = false;
                      //                 // model.notifyListeners();
                      //                 Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:SearchEvents()));
                      //               },
                      //               child: Text(
                      //                 "Event",
                      //                 style: TextStyle(
                      //                     fontFamily: FontUtils.avertaSemiBold,
                      //                     fontSize: 1.8.t,
                      //                     color: model.eventSelected == true ?  Colors.white : ColorUtils.icon_color,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(width: 2.w,),
                      //     Expanded(
                      //       child: Container(
                      //         //margin: EdgeInsets.symmetric(horizontal: 4.w),
                      //         child: Container(
                      //           decoration: BoxDecoration(
                      //             shape: BoxShape.rectangle,
                      //             borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      //           ),
                      //           child: AnimatedContainer(
                      //             duration: Duration(milliseconds: 400),
                      //             width: MediaQuery.of(context).size.width / 1,
                      //             height: 6.5.h,
                      //             //margin: EdgeInsets.symmetric(horizontal: 5.w),
                      //             decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(6),
                      //               color: model.userSelected == true ?  ColorUtils.blueColor : Colors.white,
                      //               boxShadow:[
                      //               if(model.userSelected == true)
                      //                 BoxShadow(
                      //                   color: ColorUtils.blueColor.withOpacity(0.25),
                      //                   spreadRadius: 0,
                      //                   blurRadius: 10,
                      //                   offset: Offset(0, 5), // changes position of shadow
                      //                 ),
                      //               ],
                      //             ),
                      //             child: MaterialButton(
                      //               padding: EdgeInsets.zero,
                      //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      //               onPressed: (){
                      //                 //model.userSelected = true;
                      //                 //model.eventSelected = false;
                      //                 Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:SearchUser()));
                      //                 //model.notifyListeners();
                      //               },
                      //               child: Text(
                      //                 "User",
                      //                 style: TextStyle(
                      //                   fontFamily: FontUtils.avertaSemiBold,
                      //                   fontSize: 1.8.t,
                      //                   color: model.userSelected == true ?  Colors.white : ColorUtils.icon_color,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Row(
                        children: [
                          // GestureDetector(
                          //   onTap: (){
                          //     model.eventButtonPressed = true;
                          //     model.peopleButtonPressed = false;
                          //     model.notifyListeners();
                          //     //sort(context,model);
                          //   },

                          if((model.searchEventsController.text.length > 0 || model.eventButtonPressed == true) && model.peopleButtonPressed == false)
                            GestureDetector(
                              onTap: (){
                                date(context,model);
                              },
                              child:
                              model.peopleButtonPressed == false ?

                              Container(
                                //width: 300,
                                decoration: BoxDecoration(
                                    color: model.searchEventsController.text.length > 0 || model.eventButtonPressed == true  ?
                                    ColorUtils.blueColor : ColorUtils.dropDownButtonBg ,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4.w,
                                      vertical: 1.5.h
                                  ),
                                  child: Row(
                                    children: [
                                      Text("Events",
                                        style: TextStyle(
                                          fontFamily: FontUtils.avertaDemoRegular,
                                          color: model.searchEventsController.text.length > 0 || model.eventButtonPressed == true  ?
                                          Colors.white : ColorUtils.blueColor,
                                          fontSize: 1.8.t,
                                        ),
                                      ),
                                      if(model.searchEventsController.text.length > 0 || model.eventButtonPressed == true )
                                        SizedBox(width: 2.w,),
                                      if(model.searchEventsController.text.length > 0 || model.eventButtonPressed == true )
                                        SvgPicture.asset(ImageUtils.arrowDownDropDown,
                                          color: Colors.white,
                                        ),
                                    ],
                                  ),
                                ),

                              ) : Container(),
                            ),
                          SizedBox(width: 2.w,),
                          if((model.searchEventsController.text.length == 0 && model.eventButtonPressed == false) || model.peopleButtonPressed == true)
                            GestureDetector(
                              onTap: (){
                                model.peopleButtonPressed = true;
                                model.notifyListeners();
                                //date(context,model);
                              },
                              child: Container(
                                //width: 300,
                                decoration: BoxDecoration(
                                    color: model.peopleButtonPressed == true  ?
                                    ColorUtils.blueColor : ColorUtils.dropDownButtonBg ,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4.w,
                                      vertical: 1.5.h
                                  ),
                                  child: Row(
                                    children: [
                                      Text("People",
                                        style: TextStyle(
                                          fontFamily: FontUtils.avertaDemoRegular,
                                          color: model.peopleButtonPressed == true  ?
                                          Colors.white : ColorUtils.blueColor,
                                          fontSize: 1.8.t,
                                        ),
                                      ),
                                      SizedBox(width: 2.w,),
                                      SvgPicture.asset(ImageUtils.arrowDownDropDown,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(width: 2.w,),
                          if((model.searchEventsController.text.length > 0 || model.eventButtonPressed == true) && model.peopleButtonPressed == false)
                            GestureDetector(
                              onTap: (){
                                date(context,model);
                              },
                              child: Container(
                                //width: 300,
                                decoration: BoxDecoration(
                                    color: ColorUtils.dropDownButtonBg,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4.w,
                                      vertical: 1.5.h
                                  ),
                                  child: Row(
                                    children: [
                                      Text("Date Posted",
                                        style: TextStyle(
                                          fontFamily: FontUtils.avertaDemoRegular,
                                          color: ColorUtils.blueColor,
                                          fontSize: 1.8.t,
                                        ),
                                      ),
                                      SizedBox(width: 2.w,),
                                      SvgPicture.asset(ImageUtils.arrowDownDropDown),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                          if(model.peopleButtonPressed == true)
                            GestureDetector(
                              onTap: (){
                                districtFilter(context,model);
                              },
                              child: Container(
                                //width: 300,
                                decoration: BoxDecoration(
                                    color: ColorUtils.dropDownButtonBg,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4.w,
                                      vertical: 1.5.h
                                  ),
                                  child: Row(
                                    children: [
                                      Text("District",
                                        style: TextStyle(
                                          fontFamily: FontUtils.avertaDemoRegular,
                                          color: ColorUtils.blueColor,
                                          fontSize: 1.8.t,
                                        ),
                                      ),
                                      SizedBox(width: 2.w,),
                                      SvgPicture.asset(ImageUtils.arrowDownDropDown),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 2.5.h,),
                    // Row(
                    //   children: [
                    //     GestureDetector(
                    //       onTap: (){
                    //         sort(context,model);
                    //       },
                    //       child: Container(
                    //         //width: 300,
                    //         decoration: BoxDecoration(
                    //             color: ColorUtils.dropDownButtonBg,
                    //             borderRadius: BorderRadius.circular(30)),
                    //         child: Padding(
                    //           padding: EdgeInsets.symmetric(
                    //             horizontal: 4.w,
                    //             vertical: 1.5.h
                    //           ),
                    //           child: Row(
                    //             children: [
                    //               Text("Sort",
                    //                 style: TextStyle(
                    //                   fontFamily: FontUtils.avertaDemoRegular,
                    //                   color: ColorUtils.blueColor,
                    //                   fontSize: 1.8.t,
                    //                 ),
                    //               ),
                    //               SizedBox(width: 2.w,),
                    //               SvgPicture.asset(ImageUtils.arrowDownDropDown),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(width: 2.w,),
                    //     GestureDetector(
                    //       onTap: (){
                    //         date(context,model);
                    //       },
                    //       child: Container(
                    //         //width: 300,
                    //         decoration: BoxDecoration(
                    //             color: ColorUtils.dropDownButtonBg,
                    //             borderRadius: BorderRadius.circular(30)),
                    //         child: Padding(
                    //           padding: EdgeInsets.symmetric(
                    //               horizontal: 4.w,
                    //               vertical: 1.5.h
                    //           ),
                    //           child: Row(
                    //             children: [
                    //               Text("All Upcoming",
                    //                 style: TextStyle(
                    //                   fontFamily: FontUtils.avertaDemoRegular,
                    //                   color: ColorUtils.blueColor,
                    //                   fontSize: 1.8.t,
                    //                 ),
                    //               ),
                    //               SizedBox(width: 2.w,),
                    //               SvgPicture.asset(ImageUtils.arrowDownDropDown),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    //SizedBox(height: 2.h,),
                    if(model.searchEventsController.text.length > 0 && model.peopleButtonPressed == false)
                      Expanded(
                        child: ListView.separated(
                          //padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async{
                                // model.gettingAttendeeDetails(
                                //   model.allSearchedEventsList[index].id!,index,
                                // );
                                // await model.numberOfAttendee(model.upComingeventsList[index].id!, index);
                                await model.numberOfAttendee(model.upComingeventsList[index].eventId!, index);
                                model.navigationService.navigateTo(to: AllEventsDetail(
                                  index: index,
                                  // eventId:model.allSearchedEventsList[index].id,
                                  eventId:model.allSearchedEventsList[index].eventId,
                                  eventBanner: model.allSearchedEventsList[index].eventBanner,
                                  attendeeLength: model.totalAttendee,
                                  eventName: model.allSearchedEventsList[index].eventName,
                                  eventDate: model.allSearchedEventsList[index].eventDate,
                                  timeFrom: model.allSearchedEventsList[index].timeFrom,
                                  timeTo: model.allSearchedEventsList[index].timeTo,
                                  location: model.allSearchedEventsList[index].location,
                                  profileImage: model.allSearchedEventsList[index].ProfileImage,
                                  fName: model.allSearchedEventsList[index].fname,
                                  eventDescription: model.allSearchedEventsList[index].eventDescription,
                                ));
                                //model.navigationService.navigateTo(to: EventDetails(index: index,));
                              },
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
                                  borderRadius: BorderRadius.all(Radius.circular(18)),
                                  border: Border.all(color: ColorUtils.blueColor),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.5.h),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: CachedNetworkImage(imageUrl: model.allSearchedEventsList[index].eventBanner!,
                                                fit: BoxFit.cover,
                                                width: 20.i,
                                                height: 20.i,
                                                //width: MediaQuery.of(context).size.width / 1,
                                              )
                                          ),
                                          SizedBox(width: 3.w,),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  model.allSearchedEventsList[index].eventDate!.substring(8,10)
                                                      +
                                                      " "
                                                      +
                                                      DateFormat('MMMM').format(DateTime(0, int.parse(model.allSearchedEventsList[index].eventDate!.substring(5,7)))).toString()
                                                      +
                                                      "- "
                                                      +
                                                      DateFormat('EEEE').format(
                                                          DateTime.parse(model.allSearchedEventsList[index].eventDate!)
                                                      )
                                                      +
                                                      " -"
                                                      +
                                                      DateFormat.jm().format(DateTime.parse(model.allSearchedEventsList[index].eventDate! + " " + model.allSearchedEventsList[index].timeFrom!))
                                                  ,
                                                  style: TextStyle(
                                                      fontFamily: FontUtils.avertaDemoRegular,
                                                      fontSize: 1.7.t,
                                                      color: ColorUtils.redColor
                                                  ),
                                                ),
                                                SizedBox(height: 1.h,),
                                                Text(model.allSearchedEventsList[index].eventName!,
                                                  style: TextStyle(
                                                    fontFamily: FontUtils.modernistBold,
                                                    fontSize: 2.2.t,
                                                    //color: ColorUtils.blackText
                                                  ),
                                                ),
                                                SizedBox(height: 1.h,),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(ImageUtils.locationEvent),
                                                    SizedBox(width: 1.5.w,),
                                                    Expanded(
                                                      child: Text(model.allSearchedEventsList[index].location!,
                                                        style: TextStyle(
                                                          overflow: TextOverflow.ellipsis,
                                                          fontFamily: FontUtils.modernistRegular,
                                                          fontSize: 1.7.t,
                                                          //color: ColorUtils.text_dark
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
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height:  SizeConfig.heightMultiplier * 2.5,);
                          },
                          itemCount: model.allSearchedEventsList.length,
                        ),
                      ),
                    if(model.doneDatePressed == true)
                      Expanded(
                        child:
                        model.searchedDateEvents.isNotEmpty ?
                        ListView.separated(
                          //padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async{
                                // await model.numberOfAttendee(model.upComingeventsList[index].id!, index);
                                await model.numberOfAttendee(model.upComingeventsList[index].eventId!, index);
                                model.navigationService.navigateTo(to: AllEventsDetail(
                                  index: index,
                                  // eventId:model.searchedDateEvents[index].id,
                                  eventId:model.searchedDateEvents[index].eventId,
                                  eventBanner: model.searchedDateEvents[index].eventBanner,
                                  attendeeLength: model.totalAttendee,
                                  eventName: model.searchedDateEvents[index].eventName,
                                  eventDate: model.searchedDateEvents[index].eventDate,
                                  timeFrom: model.searchedDateEvents[index].timeFrom,
                                  timeTo: model.searchedDateEvents[index].timeTo,
                                  location: model.searchedDateEvents[index].location,
                                  profileImage: model.searchedDateEvents[index].ProfileImage,
                                  fName: model.searchedDateEvents[index].fname,
                                  eventDescription: model.searchedDateEvents[index].eventDescription,
                                ));
                                //model.navigationService.navigateTo(to: EventDetails(index: index,));
                              },
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
                                  borderRadius: BorderRadius.all(Radius.circular(18)),
                                  border: Border.all(color: ColorUtils.blueColor),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.5.h),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: CachedNetworkImage(imageUrl: model.searchedDateEvents[index].eventBanner!,
                                              fit: BoxFit.cover,
                                              width: 20.i,
                                              height: 20.i,
                                              //width: MediaQuery.of(context).size.width / 1,
                                            ),
                                          ),
                                          SizedBox(width: 3.w,),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  model.searchedDateEvents[index].eventDate!.substring(8,10)
                                                      +
                                                      " "
                                                      +
                                                      DateFormat('MMMM').format(DateTime(0, int.parse(model.searchedDateEvents[index].eventDate!.substring(5,7)))).toString()
                                                      +
                                                      "- "
                                                      +
                                                      DateFormat('EEEE').format(
                                                          DateTime.parse(model.searchedDateEvents[index].eventDate!)
                                                      )
                                                      +
                                                      " -"
                                                      +
                                                      DateFormat.jm().format(DateTime.parse(model.searchedDateEvents[index].eventDate! + " " + model.searchedDateEvents[index].timeFrom!))
                                                  ,
                                                  style: TextStyle(
                                                      fontFamily: FontUtils.avertaDemoRegular,
                                                      fontSize: 1.7.t,
                                                      color: ColorUtils.redColor
                                                  ),
                                                ),
                                                SizedBox(height: 1.h,),
                                                Text(model.searchedDateEvents[index].eventName!,
                                                  style: TextStyle(
                                                    fontFamily: FontUtils.modernistBold,
                                                    fontSize: 2.2.t,
                                                    //color: ColorUtils.blackText
                                                  ),
                                                ),
                                                SizedBox(height: 1.h,),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(ImageUtils.locationEvent),
                                                    SizedBox(width: 1.5.w,),
                                                    Expanded(
                                                      child: Text(model.searchedDateEvents[index].location!,
                                                        style: TextStyle(
                                                          overflow: TextOverflow.ellipsis,
                                                          fontFamily: FontUtils.modernistRegular,
                                                          fontSize: 1.7.t,
                                                          //color: ColorUtils.text_dark
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
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height:  SizeConfig.heightMultiplier * 2.5,);
                          },
                          itemCount: model.searchedDateEvents.length,
                        ) : Center(
                          child: Text("No Event Found"),
                        ),
                      ),
                    if(model.searchEventsController.text.length > 0 && model.peopleButtonPressed == true)
                      Expanded(
                          child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  model.navigationService.navigateTo(to: UserProfile(
                                    profilePic:model.allSearchedPeopleList[index].ProfileImage,
                                    name: model.allSearchedPeopleList[index].fname,
                                    province:model.allSearchedPeopleList[index].province,
                                    district:model.allSearchedPeopleList[index].district,
                                    state:model.allSearchedPeopleList[index].department,
                                    createdAt:model.allSearchedPeopleList[index].createdDtm,
                                  ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.all(Radius.circular(6)),
                                    border: Border.all(color: ColorUtils.blueColor),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.0.h),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(16.0),
                                              child: CachedNetworkImage(
                                                imageUrl:model.allSearchedPeopleList[index].ProfileImage!,
                                                width: 17.i,
                                                height: 17.i,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(width: 2.w,),
                                            Text(model.allSearchedPeopleList[index].fname!,
                                              style: TextStyle(
                                                fontFamily: FontUtils.avertaSemiBold,
                                                fontSize: 2.t,
                                                color: ColorUtils.darkText,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SvgPicture.asset(ImageUtils.rightArrow),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 2.h,);
                            },
                            itemCount: model.allSearchedPeopleList.length,
                          )
                      ),
                    if(model.districtsRadioSelected == true)
                      Expanded(
                        child:
                        model.allSearchedDistrictPeople.isNotEmpty ?
                        ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: (){
                                model.navigationService.navigateTo(to: UserProfile(
                                  profilePic:model.allSearchedDistrictPeople[index].ProfileImage,
                                  name: model.allSearchedDistrictPeople[index].fname,
                                  province:model.allSearchedDistrictPeople[index].province,
                                  district:model.allSearchedDistrictPeople[index].district,
                                  state:model.allSearchedDistrictPeople[index].department,
                                  createdAt:model.allSearchedDistrictPeople[index].createdDtm,
                                ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(Radius.circular(6)),
                                  border: Border.all(color: ColorUtils.blueColor),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.0.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(16.0),
                                            child: CachedNetworkImage(
                                              imageUrl:model.allSearchedDistrictPeople[index].ProfileImage!,
                                              width: 17.i,
                                              height: 17.i,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(width: 2.w,),
                                          Text(model.allSearchedDistrictPeople[index].fname!,
                                            style: TextStyle(
                                              fontFamily: FontUtils.avertaSemiBold,
                                              fontSize: 2.t,
                                              color: ColorUtils.darkText,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SvgPicture.asset(ImageUtils.rightArrow),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 2.h,);
                          },
                          itemCount: model.allSearchedDistrictPeople.length,
                        ) : Center(
                          child: Text("No User Found"),
                        ),
                      ),
                    SizedBox(height: 0.5.h,),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  void districtFilter(context, MainViewModel districtFilterMainModel){
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(38),topRight: Radius.circular(38)),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context){
          return ViewModelBuilder.reactive(
            disposeViewModel: false,
            viewModelBuilder: () => locator<MainViewModel>(),
            builder: (context, model, child) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: SizeConfig.heightMultiplier * 2,),
                    Container(
                      margin: EdgeInsets.only(top: 3.h, left: 4.w, right: 4.w),
                      child: Text(
                        "Filter",
                        style: TextStyle(
                          fontFamily: FontUtils.avertaBold,
                          fontSize: 2.7.t,
                          color: ColorUtils.darkText,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w),
                      child: Text(
                        "District",
                        style: TextStyle(
                          fontFamily: FontUtils.avertaDemoRegular,
                          fontSize: 2.2.t,
                          color: ColorUtils.darkText,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3.h, left: 4.w, right: 4.w, bottom: 3.h),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          //color: ColorUtils.textFieldBg,
                          borderRadius: BorderRadius.all(
                            Radius.circular(6.0),
                          ),
                          border: Border.all(
                              color: ColorUtils.blueColor)),
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 3,
                        ),
                        child: Row(
                          children: [
                            Container(
                              child: SvgPicture.asset(
                                ImageUtils.textFieldSearchIcon,
                                color: ColorUtils.blueColor,
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
                                  autofocus: false,
                                  onChanged: (String text) async{
                                    districtFilterMainModel.groupsValue = "";
                                    districtFilterMainModel.sortByBottomSheet1 = false;
                                    districtFilterMainModel.sortByBottomSheet2 = false;
                                    districtFilterMainModel.sortByBottomSheet3 = false;
                                    districtFilterMainModel.sortByBottomSheet4 = false;
                                    districtFilterMainModel.notifyListeners();
                                    // if(model.peopleButtonPressed == false && model.searchEventsController.text.length > 0){
                                    //   model.allSearchedEvents(text);
                                    // }
                                    // if(model.peopleButtonPressed == true && model.searchEventsController.text.length > 0){
                                    //   await model.allSearchedUsers(text);
                                    // }
                                  },
                                  // onTap: () {
                                  //   model.allSearchedEvents(model.searchEventsController.text);
                                  // },
                                  enabled: true,
                                  style: TextStyle(
                                    fontFamily: FontUtils.avertaDemoRegular,
                                    color: ColorUtils.blueColor,
                                    fontSize: SizeConfig.textMultiplier * 1.9,
                                  ),
                                  //readOnly: true,
                                  //focusNode: model.searchFocus,
                                  controller: districtFilterMainModel.districtSearchController,
                                  decoration: InputDecoration(
                                    // hintText:
                                    // "Cusco",
                                    // hintStyle: TextStyle(
                                    //   fontFamily:
                                    //   FontUtils.avertaDemoRegular,
                                    //   color: ColorUtils.blueColor,
                                    //   fontSize:
                                    //   SizeConfig.textMultiplier *
                                    //       1.9,
                                    // ),
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
                            //SvgPicture.asset(ImageUtils.targetIcon),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      horizontalTitleGap: 0,

                      title: Text('Comas',
                        style: TextStyle(
                          fontFamily: districtFilterMainModel.sortByBottomSheet1 == true ? FontUtils.avertaSemiBold : FontUtils.avertaDemoRegular,
                          color: districtFilterMainModel.sortByBottomSheet1 == true ? ColorUtils.darkText : ColorUtils.lightDarkText,
                          fontSize: 1.8.t,
                        ),
                      ),
                      leading: Radio<String>(
                        value: "Comas",
                        groupValue: districtFilterMainModel.groupsValue,
                        onChanged: (String? value) {
                          districtFilterMainModel.radioSelected = true;
                          districtFilterMainModel.groupsValue = value!;
                          districtFilterMainModel.radioValue = value;
                          districtFilterMainModel.sortByBottomSheet1 = true;
                          districtFilterMainModel.sortByBottomSheet2 = false;
                          districtFilterMainModel.sortByBottomSheet3 = false;
                          districtFilterMainModel.sortByBottomSheet4 = false;
                          districtFilterMainModel.notifyListeners();
                        },
                      ),
                    ),
                    //SizedBox(height: 0.5.h,),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      horizontalTitleGap: 0,
                      title: Text('Ate',
                        style: TextStyle(
                          fontFamily: districtFilterMainModel.sortByBottomSheet2 == true ? FontUtils.avertaSemiBold : FontUtils.avertaDemoRegular,
                          color: districtFilterMainModel.sortByBottomSheet2 == true ? ColorUtils.darkText : ColorUtils.lightDarkText,
                          fontSize: 1.8.t,
                        ),
                      ),
                      leading: Radio<String>(
                        value: "Ate",
                        groupValue: districtFilterMainModel.groupsValue,
                        onChanged: (String? value) {
                          districtFilterMainModel.radioSelected = true;
                          districtFilterMainModel.groupsValue = value!;
                          districtFilterMainModel.radioValue = value;
                          districtFilterMainModel.sortByBottomSheet1 = false;
                          districtFilterMainModel.sortByBottomSheet2 = true;
                          districtFilterMainModel.sortByBottomSheet3 = false;
                          districtFilterMainModel.sortByBottomSheet4 = false;
                          districtFilterMainModel.notifyListeners();
                        },
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      horizontalTitleGap: 0,
                      title: Text('San Martín de Porres',
                        style: TextStyle(
                          fontFamily: districtFilterMainModel.sortByBottomSheet3 == true ? FontUtils.avertaSemiBold : FontUtils.avertaDemoRegular,
                          color: districtFilterMainModel.sortByBottomSheet3 == true ? ColorUtils.darkText : ColorUtils.lightDarkText,
                          fontSize: 1.8.t,
                        ),
                      ),
                      leading: Radio<String>(
                        value: "San Martín de Porres",
                        groupValue: districtFilterMainModel.groupsValue,
                        onChanged: (String? value) {
                          districtFilterMainModel.radioSelected = true;
                          districtFilterMainModel.groupsValue = value!;
                          districtFilterMainModel.radioValue = value;
                          districtFilterMainModel.sortByBottomSheet1 = false;
                          districtFilterMainModel.sortByBottomSheet2 = false;
                          districtFilterMainModel.sortByBottomSheet3 = true;
                          districtFilterMainModel.sortByBottomSheet4 = false;
                          districtFilterMainModel.notifyListeners();
                        },
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      horizontalTitleGap: 0,
                      title: Text('San Juan de Lurigancho',
                        style: TextStyle(
                          fontFamily: districtFilterMainModel.sortByBottomSheet4 == true ? FontUtils.avertaSemiBold : FontUtils.avertaDemoRegular,
                          color: districtFilterMainModel.sortByBottomSheet4 == true ? ColorUtils.darkText : ColorUtils.lightDarkText,
                          fontSize: 1.8.t,
                        ),
                      ),
                      leading: Radio<String>(
                        value: "San Martín de Porres	",
                        groupValue: districtFilterMainModel.groupsValue,
                        onChanged: (String? value) {
                          districtFilterMainModel.radioSelected = true;
                          districtFilterMainModel.groupsValue = value!;
                          districtFilterMainModel.radioValue = value;
                          districtFilterMainModel.sortByBottomSheet1 = false;
                          districtFilterMainModel.sortByBottomSheet2 = false;
                          districtFilterMainModel.sortByBottomSheet3 = false;
                          districtFilterMainModel.sortByBottomSheet4 = true;
                          districtFilterMainModel.notifyListeners();
                        },
                      ),
                    ),
                    SizedBox(height: 4.h,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 12.w),
                      child: CustomButton(
                        textValue: "Apply",
                        onButtonPressed: (){
                          districtFilterMainModel.districtsRadioSelected = true;
                          districtFilterMainModel.peopleButtonPressed = false;
                          districtFilterMainModel.notifyListeners();
                          if(districtFilterMainModel.districtSearchController.text.length > 0){
                            districtFilterMainModel.sortByBottomSheet1 = false;
                            districtFilterMainModel.sortByBottomSheet2 = false;
                            districtFilterMainModel.sortByBottomSheet3 = false;
                            districtFilterMainModel.sortByBottomSheet4 = false;
                            districtFilterMainModel.notifyListeners();
                            districtFilterMainModel.searchingPeopleByDistrict(
                              districtFilterMainModel.districtSearchController.text,
                              context,
                            );
                          }
                          if(districtFilterMainModel.radioSelected == true){
                            districtFilterMainModel.districtSearchController.clear();
                            districtFilterMainModel.notifyListeners();
                            districtFilterMainModel.searchingPeopleByDistrict(
                              districtFilterMainModel.radioValue,
                              context,
                            );
                          }
                          //Navigator.pop(context);
                        },
                        height: 6.5,
                      ),
                    ),
                    SizedBox(height: 2.h,),
                  ],
                ),
              );
            },
          );
        }
    );
  }

  void date(context, MainViewModel datesMainModel){
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(38),topRight: Radius.circular(38)),

        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context){
          return ViewModelBuilder.reactive(
            disposeViewModel: false,
            viewModelBuilder: () => locator<MainViewModel>(),
            builder: (context, model, child) {
              return ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: SizeConfig.heightMultiplier * 2,),
                  Container(
                    margin: EdgeInsets.only(top: 3.h, left: 4.w, right: 4.w),
                    child: Text(
                      "Dates",
                      style: TextStyle(
                        fontFamily: FontUtils.avertaBold,
                        fontSize: 2.7.t,
                        color: ColorUtils.darkText,
                      ),
                    ),
                  ),
                  // ListTile(
                  //   contentPadding: EdgeInsets.zero,
                  //   horizontalTitleGap: 0,
                  //   title: Text('Today',
                  //     style: TextStyle(
                  //       fontFamily: datesMainModel.today == true ? FontUtils.avertaSemiBold : FontUtils.avertaDemoRegular,
                  //       color: datesMainModel.today == true ? ColorUtils.darkText : ColorUtils.lightDarkText,
                  //       fontSize: 1.8.t,
                  //     ),
                  //   ),
                  //   leading: Radio<DatesCharacter>(
                  //     value: DatesCharacter.Today,
                  //     groupValue: datesMainModel.datesCharacterValue,
                  //     onChanged: (DatesCharacter? value) {
                  //       datesMainModel.datesCharacterValue = value;
                  //       datesMainModel.today = true;
                  //       datesMainModel.tomorrow = false;
                  //       datesMainModel.thisWeek = false;
                  //       datesMainModel.thisWeekend = false;
                  //       datesMainModel.nextWeek = false;
                  //       datesMainModel.allUpcoming = false;
                  //       datesMainModel.customDate = false;
                  //       datesMainModel.notifyListeners();
                  //     },
                  //   ),
                  // ),
                  // ListTile(
                  //   contentPadding: EdgeInsets.zero,
                  //   horizontalTitleGap: 0,
                  //   title: Text('Tomorrow',
                  //     style: TextStyle(
                  //       fontFamily: datesMainModel.tomorrow == true ? FontUtils.avertaSemiBold : FontUtils.avertaDemoRegular,
                  //       color: datesMainModel.tomorrow == true ? ColorUtils.darkText : ColorUtils.lightDarkText,
                  //       fontSize: 1.8.t,
                  //     ),
                  //   ),
                  //   leading: Radio<DatesCharacter>(
                  //     value: DatesCharacter.Tomorrow,
                  //     groupValue: datesMainModel.datesCharacterValue,
                  //     onChanged: (DatesCharacter? value) {
                  //       datesMainModel.datesCharacterValue = value;
                  //       datesMainModel.today = false;
                  //       datesMainModel.tomorrow = true;
                  //       datesMainModel.thisWeek = false;
                  //       datesMainModel.thisWeekend = false;
                  //       datesMainModel.nextWeek = false;
                  //       datesMainModel.allUpcoming = false;
                  //       datesMainModel.customDate = false;
                  //       datesMainModel.notifyListeners();
                  //     },
                  //   ),
                  // ),
                  // ListTile(
                  //   contentPadding: EdgeInsets.zero,
                  //   horizontalTitleGap: 0,
                  //   title: Text('This Week',
                  //     style: TextStyle(
                  //       fontFamily: datesMainModel.thisWeek == true ? FontUtils.avertaSemiBold : FontUtils.avertaDemoRegular,
                  //       color: datesMainModel.thisWeek == true ? ColorUtils.darkText : ColorUtils.lightDarkText,
                  //       fontSize: 1.8.t,
                  //     ),
                  //   ),
                  //   leading: Radio<DatesCharacter>(
                  //     value: DatesCharacter.ThisWeek,
                  //     groupValue: datesMainModel.datesCharacterValue,
                  //     onChanged: (DatesCharacter? value) {
                  //       datesMainModel.datesCharacterValue = value;
                  //       datesMainModel.today = false;
                  //       datesMainModel.tomorrow = false;
                  //       datesMainModel.thisWeek = true;
                  //       datesMainModel.thisWeekend = false;
                  //       datesMainModel.nextWeek = false;
                  //       datesMainModel.allUpcoming = false;
                  //       datesMainModel.customDate = false;
                  //       datesMainModel.notifyListeners();
                  //     },
                  //   ),
                  // ),
                  // ListTile(
                  //   contentPadding: EdgeInsets.zero,
                  //   horizontalTitleGap: 0,
                  //   title: Text('This Weekend',
                  //     style: TextStyle(
                  //       fontFamily: datesMainModel.thisWeekend == true ? FontUtils.avertaSemiBold : FontUtils.avertaDemoRegular,
                  //       color: datesMainModel.thisWeekend == true ? ColorUtils.darkText : ColorUtils.lightDarkText,
                  //       fontSize: 1.8.t,
                  //     ),
                  //   ),
                  //   leading: Radio<DatesCharacter>(
                  //     value: DatesCharacter.ThisWeekend,
                  //     groupValue: datesMainModel.datesCharacterValue,
                  //     onChanged: (DatesCharacter? value) {
                  //       datesMainModel.datesCharacterValue = value;
                  //       datesMainModel.today = false;
                  //       datesMainModel.tomorrow = false;
                  //       datesMainModel.thisWeek = false;
                  //       datesMainModel.thisWeekend = true;
                  //       datesMainModel.nextWeek = false;
                  //       datesMainModel.allUpcoming = false;
                  //       datesMainModel.customDate = false;
                  //       datesMainModel.notifyListeners();
                  //     },
                  //   ),
                  // ),
                  // ListTile(
                  //   contentPadding: EdgeInsets.zero,
                  //   horizontalTitleGap: 0,
                  //   title: Text('Next Week',
                  //     style: TextStyle(
                  //       fontFamily: datesMainModel.nextWeek == true ? FontUtils.avertaSemiBold : FontUtils.avertaDemoRegular,
                  //       color: datesMainModel.nextWeek == true ? ColorUtils.darkText : ColorUtils.lightDarkText,
                  //       fontSize: 1.8.t,
                  //     ),
                  //   ),
                  //   leading: Radio<DatesCharacter>(
                  //     value: DatesCharacter.NextWeek,
                  //     groupValue: datesMainModel.datesCharacterValue,
                  //     onChanged: (DatesCharacter? value) {
                  //       datesMainModel.datesCharacterValue = value;
                  //       datesMainModel.today = false;
                  //       datesMainModel.tomorrow = false;
                  //       datesMainModel.thisWeek = false;
                  //       datesMainModel.thisWeekend = false;
                  //       datesMainModel.nextWeek = true;
                  //       datesMainModel.allUpcoming = false;
                  //       datesMainModel.customDate = false;
                  //       datesMainModel.notifyListeners();
                  //     },
                  //   ),
                  // ),
                  // ListTile(
                  //   contentPadding: EdgeInsets.zero,
                  //   horizontalTitleGap: 0,
                  //   title: Text('All Upcoming',
                  //     style: TextStyle(
                  //       fontFamily: datesMainModel.allUpcoming == true ? FontUtils.avertaSemiBold : FontUtils.avertaDemoRegular,
                  //       color: datesMainModel.allUpcoming == true ? ColorUtils.darkText : ColorUtils.lightDarkText,
                  //       fontSize: 1.8.t,
                  //     ),
                  //   ),
                  //   leading: Radio<DatesCharacter>(
                  //     value: DatesCharacter.AllUpcoming,
                  //     groupValue: datesMainModel.datesCharacterValue,
                  //     onChanged: (DatesCharacter? value) {
                  //       datesMainModel.datesCharacterValue = value;
                  //       datesMainModel.today = false;
                  //       datesMainModel.tomorrow = false;
                  //       datesMainModel.thisWeek = false;
                  //       datesMainModel.thisWeekend = false;
                  //       datesMainModel.nextWeek = false;
                  //       datesMainModel.allUpcoming = true;
                  //       datesMainModel.customDate = false;
                  //       datesMainModel.notifyListeners();
                  //     },
                  //   ),
                  // ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    horizontalTitleGap: 0,
                    title: Text('Custom Date',
                      style: TextStyle(
                        fontFamily: datesMainModel.customDate == true ? FontUtils.avertaSemiBold : FontUtils.avertaDemoRegular,
                        color: datesMainModel.customDate == true ? ColorUtils.darkText : ColorUtils.lightDarkText,
                        fontSize: 1.8.t,
                      ),
                    ),
                    leading: Radio<DatesCharacter>(
                      value: DatesCharacter.CustomDate,
                      groupValue: datesMainModel.datesCharacterValue,
                      onChanged: (DatesCharacter? value) {
                        datesMainModel.datesCharacterValue = value;
                        datesMainModel.today = false;
                        datesMainModel.tomorrow = false;
                        datesMainModel.thisWeek = false;
                        datesMainModel.thisWeekend = false;
                        datesMainModel.nextWeek = false;
                        datesMainModel.allUpcoming = false;
                        datesMainModel.customDate = true;
                        datesMainModel.notifyListeners();
                      },
                    ),
                  ),
                  SizedBox(height: 4.h,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12.w),
                    child: CustomButton(
                      textValue: "Apply",
                      onButtonPressed: () async{
                        if(datesMainModel.customDate == true){
                          await datesMainModel.selectDateForCustomEvents(context);
                          //datesMainModel.dateEvents(datesMainModel.customDOB.toString());
                          //Navigator.pop(context);
                          //datesMainModel.selectCustomDate(context);
                        }
                        else{
                          Navigator.pop(context);
                        }
                      },
                      height: 6.5,
                    ),
                  ),
                  SizedBox(height: 2.h,),
                ],
              );
            },
          );
        }
    );
  }

// void customDate(context, MainViewModel customDateMainModel){
//   showModalBottomSheet(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(topLeft: Radius.circular(38),topRight: Radius.circular(38)),
//
//       ),
//       backgroundColor: Colors.white,
//       context: context,
//       builder: (BuildContext context){
//         return ViewModelBuilder.reactive(
//           disposeViewModel: false,
//           viewModelBuilder: () => locator<MainViewModel>(),
//           builder: (context, model, child) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(height: SizeConfig.heightMultiplier * 2,),
//                 Container(
//                   margin: EdgeInsets.only(top: 3.h, left: 4.w, right: 4.w),
//                   child: Text(
//                     "Choose Date",
//                     style: TextStyle(
//                       fontFamily: FontUtils.avertaBold,
//                       fontSize: 2.7.t,
//                       color: ColorUtils.darkText,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 4.h,),
//                 Container(
//                   margin: EdgeInsets.symmetric(horizontal: 12.w),
//                   child: CustomButton(
//                     textValue: "Save",
//                     onButtonPressed: (){
//                       customDateMainModel.selectCustomDate(context);
//                     },
//                     height: 6.5,
//                   ),
//                 ),
//                 SizedBox(height: 2.h,),
//               ],
//             );
//           },
//         );
//       }
//   );
// }
}
