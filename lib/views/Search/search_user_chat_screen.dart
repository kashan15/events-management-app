import 'dart:io';

import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/utils/size_config.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/search/user_profile.dart';
import 'package:democratic_unity/widgets/cupertino_back_arrow.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stacked/stacked.dart';
import 'package:democratic_unity/utils/extensions.dart';

class SearchUserChatScreen extends StatefulWidget {
  const SearchUserChatScreen({Key? key}) : super(key: key);

  @override
  _SearchUserChatScreenState createState() => _SearchUserChatScreenState();
}

class _SearchUserChatScreenState extends State<SearchUserChatScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return GestureDetector(
          onTap: (){
            context.unFocus();
            model.searchUserEmojiSelected = false;
            model.searchUserEmojiShowing = false;
            setState(() {

            });
          },
          child: SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: context.getPadding().top,),
                  Container(
                    padding: EdgeInsets.only(
                        left: 4.w,
                        right: 4.w,
                        top: 6.h
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CupertinoBackArrow(),
                            SizedBox(width: 4.w,),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:UserProfile()));
                              },
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(16)),
                                    child: Image.asset(ImageUtils.eventOrganizer,
                                      width: 16.5.i,
                                      height: 16.5.i,
                                    ),
                                  ),
                                  SizedBox(width: 2.w,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Barry Allen",
                                        style: TextStyle(
                                          fontFamily: FontUtils.avertaSemiBold,
                                          fontSize: 2.5.t,
                                          color: ColorUtils.darkText,
                                        ),
                                      ),
                                      SizedBox(height: 0.5.h,),
                                      Text("Online",
                                        style: TextStyle(
                                          fontFamily: FontUtils.avertaDemoRegular,
                                          fontSize: 1.7.t,
                                          color: ColorUtils.lightGreen,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 5.w,
                          child: PopupMenuButton(
                            child: Icon(Icons.more_vert),
                            itemBuilder: (_) => <PopupMenuItem<String>>[
                              new PopupMenuItem<String>(
                                  child: new Text('Block'), value: 'Block'),
                              new PopupMenuItem<String>(
                                  child: new Text('Report'), value: 'Report'),
                            ],
                            onSelected: (onSelected){},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: model.searchUserScrollController,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 4.w,
                            right: 4.w,
                            top: 6.h
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 5.h,),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width / 1.6,
                                    decoration: BoxDecoration(
                                      color: ColorUtils.blueColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25),
                                        bottomRight: Radius.circular(25),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.5.h),
                                      child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin maximus ac arcu nec tristique. ",
                                        style: TextStyle(
                                            fontFamily: FontUtils.avertaDemoRegular,
                                            fontSize: 1.8.t,
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 1.h,),
                                  Text("Wed. 20:32",
                                    style: TextStyle(
                                        fontFamily: FontUtils.avertaDemoRegular,
                                        fontSize: 1.5.t,
                                        color: ColorUtils.blueColor
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 5.h,),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width / 1.6,
                                    decoration: BoxDecoration(
                                      color: ColorUtils.chatBackground,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25),
                                        //bottomRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(25),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.5.h),
                                      child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin maximus ac arcu nec tristique. ",
                                        style: TextStyle(
                                            fontFamily: FontUtils.avertaDemoRegular,
                                            fontSize: 1.8.t,
                                            color: ColorUtils.darkText
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 1.h,),
                                  Text("Wed. 20:32",
                                    style: TextStyle(
                                        fontFamily: FontUtils.avertaDemoRegular,
                                        fontSize: 1.5.t,
                                        color: ColorUtils.blueColor
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 5.h,),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width / 1.6,
                                    decoration: BoxDecoration(
                                      color: ColorUtils.blueColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25),
                                        bottomRight: Radius.circular(25),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.5.h),
                                      child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin maximus ac arcu nec tristique. ",
                                        style: TextStyle(
                                            fontFamily: FontUtils.avertaDemoRegular,
                                            fontSize: 1.8.t,
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 1.h,),
                                  Text("Wed. 20:32",
                                    style: TextStyle(
                                        fontFamily: FontUtils.avertaDemoRegular,
                                        fontSize: 1.5.t,
                                        color: ColorUtils.blueColor
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 5.h,),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width / 1.6,
                                    decoration: BoxDecoration(
                                      color: ColorUtils.chatBackground,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25),
                                        //bottomRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(25),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.5.h),
                                      child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin maximus ac arcu nec tristique. ",
                                        style: TextStyle(
                                            fontFamily: FontUtils.avertaDemoRegular,
                                            fontSize: 1.8.t,
                                            color: ColorUtils.darkText
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 1.h,),
                                  Text("Wed. 20:32",
                                    style: TextStyle(
                                        fontFamily: FontUtils.avertaDemoRegular,
                                        fontSize: 1.5.t,
                                        color: ColorUtils.blueColor
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h,),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              //crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Container(
                                    //width: 200.0,
                                    margin: EdgeInsets.only(
                                      //left: SizeConfig.widthMultiplier * 4.5,
                                      right: SizeConfig.widthMultiplier * 2,
                                      //top: SizeConfig.heightMultiplier * 3,
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15.0),
                                        ),
                                        border: Border.all(color: ColorUtils.blueColor)
                                    ),
                                    child: Container(
                                      //color: Colors.amber,
                                      margin:
                                      EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 3,),
                                      child: Row(
                                        children: [
                                          ExpandTapWidget(
                                            onTap: () {
                                              model.searchUserEmojiShowing = !model.searchUserEmojiShowing;
                                              model.searchUserEmojiSelected = !model.searchUserEmojiSelected;
                                              SchedulerBinding.instance!.addPostFrameCallback((_) {
                                                model.searchUserScrollController.jumpTo(model.searchUserScrollController.position.maxScrollExtent);
                                              });
                                              setState(() {
                                              });
                                            },
                                            tapPadding: EdgeInsets.all(25.0),
                                            child: SvgPicture.asset(ImageUtils.smileyIcon),
                                          ),
                                          // GestureDetector(
                                          //   onTap: (){
                                          //     emojiShowing = !emojiShowing;
                                          //     emojiSelected = !emojiSelected;
                                          //     SchedulerBinding.instance!.addPostFrameCallback((_) {
                                          //       scrollController.jumpTo(scrollController.position.maxScrollExtent);
                                          //     });
                                          //     setState(() {
                                          //     });
                                          //   },
                                          //   child: Container(
                                          //     child: SvgPicture.asset(ImageUtils.smileyIcon),
                                          //   ),
                                          // ),
                                          SizedBox(width: 1.w,),
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: SizeConfig.widthMultiplier * 3,
                                                  right: SizeConfig.widthMultiplier * 3),
                                              child: TextField(
                                                onTap: () {},
                                                enabled: true,
                                                //readOnly: true,
                                                //focusNode: model.searchFocus,
                                                controller: model.searchUserChatController,
                                                decoration: InputDecoration(
                                                  hintText: "Type your message...",
                                                  hintStyle: TextStyle(
                                                    //fontFamily: FontUtils.proximaNovaRegular,
                                                    color: ColorUtils.silverColor,
                                                    fontSize: SizeConfig.textMultiplier * 1.9,
                                                  ),
                                                  border: InputBorder.none,
                                                  isDense: true,
                                                  contentPadding: EdgeInsets.symmetric(
                                                      vertical: SizeConfig.heightMultiplier * 2),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              //color: ColorUtils.text_red,
                                              borderRadius: BorderRadius.all(Radius.circular(15)),
                                            ),
                                            child: Row(
                                              children: [
                                                ExpandTapWidget(
                                                  onTap: () {
                                                    model.getImage();
                                                    setState(() {
                                                    });
                                                  },
                                                  tapPadding: EdgeInsets.all(50.0),
                                                  child: SvgPicture.asset(ImageUtils.plusIcon),
                                                ),
                                                // GestureDetector(
                                                //   onTap: (){
                                                //     model.getImage();
                                                //   },
                                                //     child: SvgPicture.asset(ImageUtils.plusIcon),
                                                // ),
                                                SizedBox(width: 4.w,),
                                                ExpandTapWidget(
                                                    onTap: () async{
                                                      // final cameras = await availableCameras();
                                                      // final firstCamera = cameras.first;
                                                      //model.navigationService.navigateTo(to: TakePictureScreen(camera: firstCamera,));
                                                      model.openCamera();
                                                    },
                                                    tapPadding: EdgeInsets.all(25.0),
                                                    child: SvgPicture.asset(ImageUtils.photoCamera)
                                                ),
                                                // GestureDetector(
                                                //   onTap: (){
                                                //   },
                                                //   child: SvgPicture.asset(ImageUtils.photoCamera)
                                                // ),
                                              ],
                                            ),
                                          ),
                                          // Text(searchHere,
                                          //   style: TextStyle(
                                          //     fontFamily: FontUtils.gibsonRegular,
                                          //     fontWeight: FontWeight.w400,
                                          //     fontSize: SizeConfig.textMultiplier * 1.8,
                                          //     color: ColorUtils.searchFieldText,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorUtils.blueColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: SvgPicture.asset(ImageUtils.voiceRecorder,
                                      //color: ColorUtils.blueColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2.h,),
                            if(model.searchUserEmojiSelected == true)
                              Container(
                                height: 30.h,
                                child: Offstage(
                                  offstage: !model.searchUserEmojiShowing,
                                  child: EmojiPicker(
                                      onEmojiSelected: (Category category, Emoji emoji) {
                                        model.searchUserOnEmojiSelected(emoji);
                                      },
                                      onBackspacePressed: model.searchUserOnBackspacePressed,
                                      config: Config(
                                          columns: 7,
                                          // Issue: https://github.com/flutter/flutter/issues/28894
                                          emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                                          verticalSpacing: 0,
                                          horizontalSpacing: 0,
                                          initCategory: Category.RECENT,
                                          bgColor: const Color(0xFFF2F2F2),
                                          indicatorColor: Colors.blue,
                                          iconColor: Colors.grey,
                                          iconColorSelected: Colors.blue,
                                          progressIndicatorColor: Colors.blue,
                                          backspaceColor: Colors.blue,
                                          showRecentsTab: true,
                                          recentsLimit: 28,
                                          noRecentsText: 'No Recents',
                                          noRecentsStyle: const TextStyle(
                                              fontSize: 20, color: Colors.black26),
                                          tabIndicatorAnimDuration: kTabScrollDuration,
                                          categoryIcons: const CategoryIcons(),
                                          buttonMode: ButtonMode.MATERIAL)),
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
        );
      },
    );
  }
}
