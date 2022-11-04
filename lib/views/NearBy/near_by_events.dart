import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/utils/size_config.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/drawer.dart';
import 'package:democratic_unity/views/search/search_events.dart';
import 'package:democratic_unity/widgets/cupertino_back_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stacked/stacked.dart';

class NearByEvents extends StatefulWidget {
  const NearByEvents({Key? key}) : super(key: key);

  @override
  State<NearByEvents> createState() => _NearByEventsState();
}

class _NearByEventsState extends State<NearByEvents> {

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
      },
      disposeViewModel: false,
      builder: (context, model, child) {
        return GestureDetector(
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
                          Text("Nearby You",
                            style: TextStyle(
                                fontFamily: FontUtils.avertaSemiBold,
                                fontSize: 3.t,
                                color: ColorUtils.darkText
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.5.h,),
                    //SizedBox(height: 2.h,),
                    Expanded(
                      child: ListView.separated(
                        //padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
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
                                        child: Image.asset(places[index]["image"],
                                          width: 23.i,
                                          height: 23.i,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 3.w,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(places[index]["date"],
                                            style: TextStyle(
                                                fontFamily: FontUtils.avertaDemoRegular,
                                                fontSize: 1.7.t,
                                                color: ColorUtils.redColor
                                            ),
                                          ),
                                          SizedBox(height: 1.h,),
                                          Text(places[index]["eventName"],
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
                                              Text(places[index]["location"],
                                                style: TextStyle(
                                                  fontFamily: FontUtils.modernistRegular,
                                                  fontSize: 1.7.t,
                                                  //color: ColorUtils.text_dark
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height:  SizeConfig.heightMultiplier * 2.5,);
                        },
                        itemCount: places.length,
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
}
