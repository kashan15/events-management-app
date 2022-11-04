
import 'package:cached_network_image/cached_network_image.dart';
import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/NewsDetails/news_detail.dart';
import 'package:democratic_unity/views/NewsDetails/see_all_news.dart';
import 'package:democratic_unity/views/SeeAllUpcomings/seeAll_upcomings.dart';
import 'package:democratic_unity/widgets/app_localization.dart';
import 'package:democratic_unity/widgets/loader_2.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../utils/size_config.dart';
import 'Notifications/notifications.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  List upComingEvents = [
    {'image': ImageUtils.americanFlag,
      'eventName': 'Lorem Ipsum',
      'date': '10',
      'month': ' June',
      'location': 'Lot 13 • Oakland, CA',
      'going': '+20',
      'goingGroup': ImageUtils.groupGoing
    },
    {'image': ImageUtils.event,
      'eventName': 'Lorem Ipsum',
      'date': '10',
      'month': ' June',
      'location': 'Lot 13 • Oakland, CA',
      'going': '+20',
      'goingGroup': ImageUtils.groupGoing
    },
  ];

  List campaign = [
    {
      'image': ImageUtils.campaign,
      'eventName': 'Lorem ipsum dolor sit amet, consectetur.',
      'speaker' : 'By David Beckham',
      'time' : '4',
    },
    {
      'image': ImageUtils.campaign,
      'eventName': 'Lorem ipsum dolor sit amet, consectetur.',
      'speaker' : 'By David Beckham',
      'time' : '4',
    },
  ];

  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      //fireOnModelReadyOnce: true,
      onModelReady: (model) async{
        await model.getUserData();
        model.gettingTheNewsFeed();
        //model.getEvents();
      },
      builder: (context, model, child) {
        return model.isLoading == true ? Loader2() :
        SafeArea(
          top: false,
          bottom: false,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 6.h,),
                Container(
                  margin: EdgeInsets.only(left: 1.5.w, right: 4.w),
                  child:
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                        children: [
                        IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: SvgPicture.asset(
                              ImageUtils.menuIcon),
                        ),


                      ] ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  AllNotifications()),
                            );

                            // Navigator.push(
                            //         context,
                            //         MaterialPageRoute(builder: (context) => EventDetails(index: 0,)),
                            //       );
                          },
                          icon: SvgPicture.asset(

                            ImageUtils.bellNotification,
                            color: Colors.blue,
                          ),
                        ),

                      ] ),


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
                              Text(AppLocalizations.of(context)!.translate("upcoming_events") ?? "",
                                style: TextStyle(
                                  fontFamily: FontUtils.avertaSemiBold,
                                  fontSize: 2.6.t,
                                  color: ColorUtils.darkText,
                                ),
                              ),
                              // Image.asset("assets/images/american_flag.png",
                              // fit: BoxFit.contain,
                              // ),
                              ExpandTapWidget(
                                onTap: (){
                                  model.navigationService.navigateTo(to: SeeAllUpComings());
                                },
                                tapPadding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 2.h),
                                child: Text(
                                  AppLocalizations.of(context)!.translate("see_all") ?? "",
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
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 3.h,),
                        Container(
                            margin: EdgeInsets.only(left: 0.w,right: 1.w),
                            //height: MediaQuery.of(context).size.height / 2.3,
                            // height: 38.5.h,
                            height: 40.h,
                            //width: 70.w,
                            child:
                            model.upComingeventsList.length != 0 ?
                            ListView.separated(
                                scrollDirection: Axis.horizontal,
                              itemCount: model.upComingeventsList.length,
                                shrinkWrap: true,
                                // physics: ClampingScrollPhysics(),
                                //padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: (){
                                      model.gettingAttendeeDetails(
                                        // model.upComingeventsList[index].id!,index,
                                        // model.upComingeventsList[index].Id!,index,

                                        // model.upComingeventsList[index].eventId??'',index,
                                        model.upComingeventsList[index].id??'',index,

                                      );
                                      // model.navigationService.navigateTo(to: EventDetails(index: index,));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 4.w, bottom: 2.h),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width / 1.35,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          // image: DecorationImage(
                                          // image: AssetImage(
                                          //   "assets/images/american_flag.png",),
                                          // fit: BoxFit.fill,
                                          // ),
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
                                                      child:
                                                      // Image.network(
                                                      //   model.upComingeventsList[index].eventBanner!,
                                                      //   fit: BoxFit.cover,
                                                      //   height: 40.i,
                                                      //   width: MediaQuery.of(context).size.width / 1,
                                                      // ),
                                                      CachedNetworkImage(
                                                        imageUrl: model.upComingeventsList[index].eventBanner!,
                                                        // placeholder: (context, imageUrl) => Image.asset(ImageUtils.error),
                                                        errorWidget: (context, url, error) => new Image.asset(ImageUtils.error),
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
                                                              child: model.attendeesProfilePics!.length > 1 ?
                                                              CachedNetworkImage(
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
                                                            child: model.attendeesProfilePics!.length > 2
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
                                                            BorderRadius.only(
                                                              bottomLeft: Radius.circular(
                                                                  20.0),
                                                              topLeft: Radius.circular(
                                                                  20.0),
                                                              bottomRight:
                                                              Radius.circular(
                                                                  20.0),
                                                              topRight: Radius.circular(
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

                                // itemCount: model.upComingeventsList.length

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
                        SizedBox(height: 3.h,),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.translate("news_feed") ?? "",
                                style: TextStyle(
                                  fontFamily: FontUtils.avertaSemiBold,
                                  fontSize: 2.5.t,
                                  color: ColorUtils.darkText,
                                ),
                              ),
                              ExpandTapWidget(
                                onTap: (){
                                  model.navigationService.navigateTo(to: AllNews());
                                },
                                tapPadding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 2.h),
                                child: Text(
                                  AppLocalizations.of(context)!.translate("see_all") ?? "",
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
                            //height: MediaQuery.of(context).size.height / 2.3,
                            //height: 37.5.h,
                            //width: 70.w,
                            child: model.newsFeedList.length != 0 ?
                            ListView.separated(
                              itemCount: model.newsFeedList.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              //padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: (){
                                    model.navigationService.navigateTo(to: NewsDetail(index: index,));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 4.w,bottom: 2.h),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width / 1.35,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0.0, 3),
                                              color: Colors.black.withOpacity(0.1),
                                              blurRadius: 5.0,
                                              spreadRadius: 0
                                          ),
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(18)),
                                        border: Border.all(color: ColorUtils.blueColor),
                                      ),
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            //mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child:
                                                  CachedNetworkImage(imageUrl: model.newsFeedList[index].NewsImage!,
                                                    errorWidget: (context, url, error) => new Image.asset(ImageUtils.error),

                                                    fit: BoxFit.cover,
                                                    height: 40.i,
                                                    width: MediaQuery.of(context).size.width / 1,
                                                  )
                                              ),
                                              SizedBox(height: 2.h,),
                                              Container(
                                                width: MediaQuery.of(context).size.width / 2,
                                                child: Text(model.newsFeedList[index].NewsTitle ?? "The News",
                                                  style: TextStyle(
                                                      fontFamily: FontUtils.avertaSemiBold,
                                                      fontSize: 2.2.t,
                                                      color: ColorUtils.titleText
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 2.5.h,),
                                              Container(
                                                width: MediaQuery.of(context).size.width/1.5,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    // Text(campaign[index]["speaker"],
                                                    //   style: TextStyle(
                                                    //     fontFamily: FontUtils.avertaDemoRegular,
                                                    //     fontSize: 1.7.t,
                                                    //     color: ColorUtils.silverColor,
                                                    //   ),
                                                    // ),
                                                    Container(),
                                                    //SizedBox(width: 1.w,),
                                                    Text(
                                                      DateFormat('EEEE').format(
                                                          DateTime.parse(model
                                                              .newsFeedList[index]
                                                              .createdDtm!)) + ", " +
                                                          model.newsFeedList[index].createdDtm!.substring(8,10) + " " +
                                                          DateFormat('MMMM').format(DateTime(0, int.parse(model.newsFeedList[index].createdDtm!.substring(5,7)))).toString(),
                                                      //model.newsFeedList[index].NewsTitle!,
                                                      //campaign[index]["time"] + " hours ago",
                                                      style: TextStyle(
                                                        fontFamily: FontUtils.avertaDemoRegular,
                                                        fontSize: 1.7.t,
                                                        color: ColorUtils.silverColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
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
                              child: Text("No News Feed",
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
        );
      },
    );
  }
}
