

import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/drawer.dart';
import 'package:democratic_unity/widgets/cupertino_back_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class AllNotifications extends StatefulWidget {
  const AllNotifications({Key? key}) : super(key: key);

  @override
  _AllNotificationsState createState() => _AllNotificationsState();
}

class _AllNotificationsState extends State<AllNotifications> {

  List friendsList = [
    // {
    //   'name': "David Silbia",
    //   'message': "Lorem ipsum dolor sit amet.",
    //   'time': "Just now",
    //   'image': ImageUtils.chat_person1,
    // },
    // {
    //   'name': "Adnan Safi",
    //   'message': "Lorem ipsum dolor sit amet.",
    //   'time': "5 min ago",
    //   'image': ImageUtils.chat_person2,
    // },
    // {
    //   'name': "Joan Baker",
    //   'message': "Lorem ipsum dolor sit amet.",
    //   'time': "20 min ago",
    //   'image': ImageUtils.chat_person3,
    // },
    // {
    //   'name': "Ronald C. Kinch",
    //   'message': "Lorem ipsum dolor sit amet.",
    //   'time': "1 hr ago",
    //   'image': ImageUtils.chat_person4,
    // },
    // {
    //   'name': "Clara Tolson",
    //   'message': "Lorem ipsum dolor sit amet.",
    //   'time': "9 hr ago",
    //   'image': ImageUtils.chat_person5,
    // },
    // {
    //   'name': "Jennifer Fritz",
    //   'message': "Lorem ipsum dolor sit amet.",
    //   'time': "Tue , 5:10 pm",
    //   'image': ImageUtils.chat_person6,
    // },
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return GestureDetector(
          onTap: (){
            context.unFocus();
          },
          child: SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
              drawer: DrawerScreen(),
              backgroundColor: Colors.white,
              body: Container(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      //color: Colors.amber,
                      padding: EdgeInsets.only(
                          left: 4.w,
                          right: 4.w,
                          top: 6.h
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: context.getPadding().top,),
                          Container(
                            child: Row(
                              children: [
                                CupertinoBackArrow(),
                                SizedBox(width: 4.w,),
                                Text("Notifications",
                                  style: TextStyle(
                                      fontFamily: FontUtils.avertaSemiBold,
                                      fontSize: 3.t,
                                      color: ColorUtils.darkText
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    friendsList.isEmpty ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:[
                          SizedBox(height: 15.h,),

                              // height: 65.h,
                              // width: 65.h,
                             Image.asset(ImageUtils.notifications,
                            height: 45.h,
                              width: 45.w,
                            ),

                          // SvgPicture.asset(ImageUtils.bellNotification,
                          // color: Colors.blue,
                          // ),

                          // , SizedBox(height: 1.h,),

                         // ,Container(
                         //   child:
                         // Text("No Notifications!",
                         // style: TextStyle(
                         //   color: Colors.red,
                         //   fontSize: 25,
                         //   fontWeight: FontWeight.bold
                         // )
                         // ),
                         // ),
                         //  SizedBox(height: 0.3.h,),
                            // height: 50,
                            // width: 50,
                            //  Text(
                            //   "Lorum ipsum dolor sit amet consectetur\n adipiscing elit sed to eiusmod tempor",
                            //     textAlign: TextAlign.center,
                            // style: TextStyle(
                            //   fontSize: 22
                            // ),
                            // ),
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus varius dictum cursus.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: FontUtils.modernistRegular,
                              fontSize: 1.8.t,
                              color: ColorUtils.darkText,
                            ),
                          ),

                        ] )

                        : Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 4.w,
                          right: 4.w,
                        ),
                        child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     PageTransition(
                                  //         type: PageTransitionType.fade,
                                  //         child: MessageScreen()));
                                },
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: AssetImage(
                                                friendsList[index]["image"],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  friendsList[index]["name"],
                                                  style: TextStyle(
                                                    fontFamily: FontUtils
                                                        .modernistBold,
                                                    fontSize: 1.9.t,
                                                    color: ColorUtils.blueColor
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 0.3.h,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context).size.width / 2,
                                                  child: Text(
                                                    friendsList[index]
                                                    ["message"],
                                                    style: TextStyle(
                                                      fontFamily: FontUtils
                                                          .modernistBold,
                                                      fontSize: 1.8.t,
                                                      //color: ColorUtils.lightTextColor
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              friendsList[index]["time"],
                                              style: TextStyle(
                                                fontFamily: FontUtils
                                                    .avertaDemoRegular,
                                                fontSize: 1.6.t,
                                                color: ColorUtils.icon_color,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 2.h,
                              );
                            },
                            itemCount: friendsList.length),



                      ),
         ),
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
