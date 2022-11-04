import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/dontate.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/dimensions.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/widgets/back_arrow_with_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stacked/stacked.dart';

class DeleteEvent extends StatefulWidget {
  const DeleteEvent({Key? key}) : super(key: key);

  @override
  _DeleteEventState createState() => _DeleteEventState();
}

class _DeleteEventState extends State<DeleteEvent> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
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
                            image: DecorationImage(
                                image: AssetImage(ImageUtils.americanFlagEvent,),
                                fit: BoxFit.fitHeight
                            )
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
                                      child: Icon(Icons.more_vert),
                                    ),
                                ),
                                itemBuilder: (_) => <PopupMenuItem<String>>[
                                  new PopupMenuItem<String>(
                                      child: new Text('Delete Event'), value: 'Delete Event'),
                                  // new PopupMenuItem<String>(
                                  //     child: new Text('Report'), value: 'Report'),
                                ],
                                onSelected: (onSelected){},
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
                                      Text("+ 20 Going",
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
                          Text("Lorem Ipsum",
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
                                        borderRadius: BorderRadius.all(Radius.circular(12))
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(ImageUtils.redCalender,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 4.w,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("14 December, 2021",
                                        style: TextStyle(
                                            fontFamily: FontUtils.avertaSemiBold,
                                            fontSize: 2.t,
                                            color: ColorUtils.darkText
                                        ),
                                      ),
                                      SizedBox(height: 1.h,),
                                      Text("Tuesday, 4:00PM - 9:00PM",
                                        style: TextStyle(
                                            fontFamily: FontUtils.avertaDemoRegular,
                                            fontSize: 1.6.t,
                                            color: ColorUtils.darkText
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SvgPicture.asset(ImageUtils.forwardIcon),
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
                                    width: 12.w,
                                    height: 6.h,
                                    decoration: BoxDecoration(
                                        color: ColorUtils.eventIconBg,
                                        borderRadius: BorderRadius.all(Radius.circular(12))
                                    ),
                                    child: Center(child: SvgPicture.asset(ImageUtils.redLocation)),
                                  ),
                                  SizedBox(width: 4.w,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Gala Convention Center",
                                        style: TextStyle(
                                            fontFamily: FontUtils.avertaSemiBold,
                                            fontSize: 2.t,
                                            color: ColorUtils.darkText
                                        ),
                                      ),
                                      SizedBox(height: 1.h,),
                                      Text("Major Lazer, Showtek",
                                        style: TextStyle(
                                            fontFamily: FontUtils.avertaDemoRegular,
                                            fontSize: 1.6.t,
                                            color: ColorUtils.darkText
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SvgPicture.asset(ImageUtils.forwardIcon),
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
                                        borderRadius: BorderRadius.all(Radius.circular(12))
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Image.asset(ImageUtils.eventOrganizer,
                                        width: 12.i,
                                        height: 12.i,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 4.w,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Barry Allen",
                                        style: TextStyle(
                                            fontFamily: FontUtils.avertaSemiBold,
                                            fontSize: 2.t,
                                            color: ColorUtils.darkText
                                        ),
                                      ),
                                      SizedBox(height: 1.h,),
                                      Text("Organizer",
                                        style: TextStyle(
                                            fontFamily: FontUtils.avertaDemoRegular,
                                            fontSize: 1.6.t,
                                            color: ColorUtils.darkText
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: (){
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: ColorUtils.eventIconBg,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.all(Radius.circular(6)),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 3.5.w,vertical: 1.h),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(ImageUtils.red_chat),
                                        SizedBox(width: 2.w,),
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
                              SizedBox(height: 5.h,),
                              Text("Event Agenda",
                                style: TextStyle(
                                    fontFamily: FontUtils.modernistBold,
                                    fontSize: 2.2.t,
                                    color: ColorUtils.titleText
                                ),
                              ),

                              SizedBox(height: 2.h,),
                              Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus varius dictum cursus. Donec nec facilisis urna. Nulla velit magna, dictum ultricies magna eu, varius aliquam diam. Sed non auctor augue. Nullam vitae sem eros. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus varius dictum cursus. Donec nec facilisis urna. Nulla velit magna, dictum ultricies magna eu, varius aliquam diam. Sed non auctor augue. Nullam vitae sem eros. ",
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
