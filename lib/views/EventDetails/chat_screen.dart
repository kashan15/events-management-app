import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/dimensions.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/utils/size_config.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/Search/user_profile.dart';
import 'package:democratic_unity/widgets/audio_player.dart';
import 'package:democratic_unity/widgets/cupertino_back_arrow.dart';
import 'package:democratic_unity/widgets/take_picture_screeb.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pubnub/pubnub.dart';
import 'package:stacked/stacked.dart';

class ChatScreen extends StatefulWidget {

  String? otherFirebaseId;
  String? userName;
  String? profilePicture;
  String? otherUserId;
  String? province;
  String? district;
  String? state;
  String? createdAt;

   ChatScreen({
     this.otherFirebaseId,
     this.userName,
     this.profilePicture,
     this.otherUserId,
     this.province,
     this.district,
     this.state,
     this.createdAt,
     Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {


  //ScrollController _myController = ScrollController();



  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  //   // SchedulerBinding.instance!.addPostFrameCallback((_) {
  //   //   myController.animateTo(
  //   //     _myController.position.maxScrollExtent,
  //   //     duration: const Duration(milliseconds: 500),
  //   //     curve: Curves.easeOut,
  //   //   );
  //   // });
  //   // setState((){
  //   // });
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    MainViewModel model = locator<MainViewModel>();
    model.subscription!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      onModelReady: (model) async{
        await model.loadingAllChat(widget.otherFirebaseId!);
        //model.scrollToEnd();
        //model.docOnUserPressed(widget.otherFirebaseId!);
        // model.subscribeChannel();
        // await model.channeling();
      },
      disposeViewModel: false,
      builder: (context, model, child) {
        return GestureDetector(
          onTap: (){
            context.unFocus();
            model.emojiSelected = false;
            model.emojiShowing = false;
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
                                model.navigationService.navigateTo(to: UserProfile(
                                  profilePic:widget.profilePicture,
                                  name: widget.userName,
                                  province:widget.province,
                                  district:widget.district,
                                  state:widget.state,
                                  createdAt:widget.createdAt,
                                ));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                child: CachedNetworkImage(
                                  imageUrl:widget.profilePicture!,
                                  width: 16.5.i,
                                  height: 16.5.i,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 2.w,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.userName!,
                                  style: TextStyle(
                                    fontFamily: FontUtils.avertaSemiBold,
                                    fontSize: 2.5.t,
                                    color: ColorUtils.darkText,
                                  ),
                                ),
                                SizedBox(height: 0.5.h,),
                                /*Text("Online",
                                  style: TextStyle(
                                    fontFamily: FontUtils.avertaDemoRegular,
                                    fontSize: 1.7.t,
                                    color: ColorUtils.lightGreen,
                                  ),
                                ),*/
                              ],
                            ),
                          ],
                        ),
                        Container(
                          width: 5.w,
                          child: PopupMenuButton(
                            child: Icon(Icons.more_vert),
                            itemBuilder: (_) => <PopupMenuItem<String>>[
                              new PopupMenuItem<String>(
                                  child: new Text('Block'), value: 'Block',
                                onTap: (){
                                  model.blockingUsers(widget.otherFirebaseId!, widget.otherUserId!);
                                },
                              ),
                              // new PopupMenuItem<String>(
                              //     child: new Text('Report'), value: 'Report'),
                            ],
                            //onSelected: (onSelected){},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 4.w,
                          right: 4.w,
                          top: 1.h
                      ),
                      child:
                      model.chatMessagesList.length != 0 ?
                          ListView.builder(
                            controller: model.myController,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: model.chatMessagesList.length,
                            itemBuilder: (context, index) {
                            return
                              model.chatMessagesList[index]["id"] == model.currentUserFbId ?
                              //model.chats[index]["userID"] == model.userId ?
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
                                        child:
                                        model.chatMessagesList[index]["type"] == "text"?
                                        Text(
                                        model.chatMessagesList[index]["content"],
                                            //+ model.chatList[index]["dateTime"].toString(),
                                          //model.chats[index]['content'],
                                          style: TextStyle(
                                              fontFamily: FontUtils.avertaDemoRegular,
                                              fontSize: 1.8.t,
                                              color: ColorUtils.darkText
                                          ),
                                        )
                                            :
                                        //Image.network(model.chatMessagesList[index]["content"]),
                                        model.chatMessagesList[index]["type"] == "image"?
                                        CachedNetworkImage(
                                            imageUrl: model.chatMessagesList[index]["content"],
                                          fit: BoxFit.cover,
                                          //height: 30.i,
                                          //width: 30.i,
                                        ) :
                                        AudioPlayer(
                                            source: model.chatMessagesList[index]["content"],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 0.5.h,),
                                    Text(
                                    DateFormat.E().add_Hm().format(
                              DateTime.parse((model.chatMessagesList[index]['dateTime']).toDate().toString())
                              ),
                                      //model.chatList[index]["createdAt"],
                                      style: TextStyle(
                                          fontFamily: FontUtils.avertaDemoRegular,
                                          fontSize: 1.5.t,
                                          color: ColorUtils.blueColor
                                      ),
                                    ),
                                    SizedBox(height: 1.5.h,),
                                  ],
                                ),
                              )
                              :
                              //model.chatList[index]["userId"] == widget.otherId ?
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
                                        child:
                                        model.chatMessagesList[index]["type"] == "text"?
                                        Text(
                                          model.chatMessagesList[index]["content"],
                                          //model.chats[index]['content'],
                                          style: TextStyle(
                                              fontFamily: FontUtils.avertaDemoRegular,
                                              fontSize: 1.8.t,
                                              color: Colors.white
                                          ),
                                        ) :
                                            //Image.network(model.chatMessagesList[index]["content"]),
                                        CachedNetworkImage(
                                          imageUrl: model.chatMessagesList[index]["content"],
                                          fit: BoxFit.cover,
                                        ),
                                        // Image(
                                        //   image: FirebaseImage(model.chatMessagesList[index]["content"]),
                                        //   // Works with standard parameters, e.g.
                                        //   fit: BoxFit.fitWidth,
                                        //   width: 100,
                                        //   // ... etc.
                                        // ),
                                        // Image(
                                        //   image: FirebaseImage(model.chatMessagesList[index]["content"]),
                                        //   // Works with standard parameters, e.g.
                                        //   fit: BoxFit.fitWidth,
                                        //   width: 100,
                                        //   // ... etc.
                                        // ),
                                      ),
                                      ),
                                    SizedBox(height: 0.5.h,),
                                    Text(
                                      model.chatMessagesList[index]['dateTime'] != null ?
                                      // DateFormat('EEEE').format(
                                      //     DateTime.parse(model.chats[index]['time']))
                                      //     + " " +
                                      //     model.chats[index]['time'].substring(11,16)
                                    DateFormat.E().add_Hm().format(
                                        DateTime.parse((model.chatMessagesList[index]['dateTime']).toDate().toString())
                                    ) : "",
                                      style: TextStyle(
                                          fontFamily: FontUtils.avertaDemoRegular,
                                          fontSize: 1.5.t,
                                          color: ColorUtils.blueColor
                                      ),
                                    ),
                                    SizedBox(height: 1.5.h,),
                                  ],
                                ),
                              );
                              //: Container();
                          },)
                          : Container(),
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  Container(
                    padding: EdgeInsets.only(
                        left: 4.w,
                        right: 4.w,
                        top: 0.h
                    ),
                    child: Row(
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
                                      model.emojiShowing = !model.emojiShowing;
                                      model.emojiSelected = !model.emojiSelected;
                                      SchedulerBinding.instance!.addPostFrameCallback((_) {
                                        model.scrollController.jumpTo(model.scrollController.position.maxScrollExtent);
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
                                        controller: model.chatController,
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
                                            model.chatGetImage(widget.otherFirebaseId!, widget.otherUserId!);
                                          },
                                          tapPadding: EdgeInsets.all(50.0),
                                          child: SvgPicture.asset(ImageUtils.plusIcon),
                                        ),
                                        SizedBox(width: 4.w,),
                                        // ExpandTapWidget(
                                        //     onTap: () async{
                                        //       // final cameras = await availableCameras();
                                        //       // final firstCamera = cameras.first;
                                        //       //model.navigationService.navigateTo(to: TakePictureScreen(camera: firstCamera,));
                                        //       //model.openCamera();
                                        //     },
                                        //     tapPadding: EdgeInsets.all(25.0),
                                        //     child: SvgPicture.asset(ImageUtils.photoCamera)
                                        // ),
                                    /*PopupMenuButton(
                                      //offset: Offset(50,-5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          //color: ColorUtils.blueColor,
                                          // shape: BoxShape.circle,
                                          // border: Border.all(color: Colors.white,width: 1.5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: SvgPicture.asset(ImageUtils.photoCamera),
                                        ),
                                      ),
                                      itemBuilder: (_) => <PopupMenuItem<String>>[
                                        new PopupMenuItem<String>(
                                          child: new Text('Camera'), value: 'Camera',
                                          onTap: (){
                                            model.chatOpenCamera(widget.otherFirebaseId!, widget.otherUserId!);
                                          },
                                        ),
                                        new PopupMenuItem<String>(
                                          child: new Text('Gallery'), value: 'Gallery',
                                          onTap: (){
                                            model.chatGetImage(widget.otherFirebaseId!, widget.otherUserId!);
                                          },
                                        ),
                                      ],
                                    ),*/
                                        GestureDetector(
                                          onTap: (){
                                            model.chatOpenCamera(widget.otherFirebaseId!, widget.otherUserId!);
                                          },
                                          child: SvgPicture.asset(ImageUtils.photoCamera)
                                        ),
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
                        if(model.chatController.text.isEmpty)
                          GestureDetector(
                            onTap: () {
                              if(model.recordPressed == false){
                                model.recordPressed = true;
                                model.notifyListeners();
                                print("record started");
                                model.start(widget.otherFirebaseId!, widget.otherUserId!);
                              }
                              else if(model.recordPressed == true){
                                model.recordPressed = false;
                                model.notifyListeners();
                                print("recording stopped");
                                model.stop(widget.otherFirebaseId!, widget.otherUserId!);
                              }
                              //model.isRecording ? model.stop() : model.start();
                            },
                            // onLongPress: (){
                            //   model.longPressed = true;
                            //   model.notifyListeners();
                            //   model.start();
                            //   print("record started");
                            // },
                            // onLongPressCancel: (){
                            //   model.longPressed = false;
                            //   model.notifyListeners();
                            //   model.stop();
                            //   print("recorded");
                            // },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorUtils.blueColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Icon(
                                  // model.longPressed == true ?
                                  // ImageUtils.searchIcon :
                                  model.recordPressed == true ? Icons.stop :
                                  Icons.keyboard_voice_rounded,
                                  color: Colors.white,
                                  size: 6.i,
                                  //color: ColorUtils.blueColor,
                                ),
                              ),
                            ),
                          ),
                         if(model.chatController.text.isNotEmpty)
                          GestureDetector(
                            onTap: () async{
                              if(model.chatController.text.isNotEmpty){
                                model.fireChat(widget.otherFirebaseId!, widget.otherUserId!);
                                model.scrollToEnd();
                                model.chatController.clear();
                              }
                            },
                            child: Container(
                              //margin: EdgeInsets.only(bottom: 2.2.h),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorUtils.blueColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child:
                                /*Icon(Icons.send,
                                color: Colors.white,
                                ),*/
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  if(model.emojiSelected == true)
                    Container(
                      height: 30.h,
                      child: Offstage(
                        offstage: !model.emojiShowing,
                        child: EmojiPicker(
                            onEmojiSelected: (Category category, Emoji emoji) {
                              model.onEmojiSelected(emoji);
                            },
                            onBackspacePressed: model.onBackspacePressed,
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
        );
      },
    );
    // Column(
    //   children: [
    //     SizedBox(height: 5.h,),
    //     Align(
    //       alignment: Alignment.centerLeft,
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Container(
    //             width: MediaQuery.of(context).size.width / 1.6,
    //             decoration: BoxDecoration(
    //               color: ColorUtils.blueColor,
    //               borderRadius: BorderRadius.only(
    //                 topLeft: Radius.circular(25),
    //                 topRight: Radius.circular(25),
    //                 bottomRight: Radius.circular(25),
    //               ),
    //             ),
    //             child: Padding(
    //               padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.5.h),
    //               child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin maximus ac arcu nec tristique. ",
    //                 style: TextStyle(
    //                     fontFamily: FontUtils.avertaDemoRegular,
    //                     fontSize: 1.8.t,
    //                     color: Colors.white
    //                 ),
    //               ),
    //             ),
    //           ),
    //           SizedBox(height: 1.h,),
    //           Text("Wed. 20:32",
    //             style: TextStyle(
    //                 fontFamily: FontUtils.avertaDemoRegular,
    //                 fontSize: 1.5.t,
    //                 color: ColorUtils.blueColor
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     SizedBox(height: 5.h,),
    //     Align(
    //       alignment: Alignment.centerRight,
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.end,
    //         children: [
    //           Container(
    //             width: MediaQuery.of(context).size.width / 1.6,
    //             decoration: BoxDecoration(
    //               color: ColorUtils.chatBackground,
    //               borderRadius: BorderRadius.only(
    //                 topLeft: Radius.circular(25),
    //                 topRight: Radius.circular(25),
    //                 //bottomRight: Radius.circular(0),
    //                 bottomLeft: Radius.circular(25),
    //               ),
    //             ),
    //             child: Padding(
    //               padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.5.h),
    //               child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin maximus ac arcu nec tristique. ",
    //                 style: TextStyle(
    //                     fontFamily: FontUtils.avertaDemoRegular,
    //                     fontSize: 1.8.t,
    //                     color: ColorUtils.darkText
    //                 ),
    //               ),
    //             ),
    //           ),
    //           SizedBox(height: 1.h,),
    //           Text("Wed. 20:32",
    //             style: TextStyle(
    //                 fontFamily: FontUtils.avertaDemoRegular,
    //                 fontSize: 1.5.t,
    //                 color: ColorUtils.blueColor
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //
    //     SizedBox(height: 5.h,),
    //     Align(
    //       alignment: Alignment.centerLeft,
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Container(
    //             width: MediaQuery.of(context).size.width / 1.6,
    //             decoration: BoxDecoration(
    //               color: ColorUtils.blueColor,
    //               borderRadius: BorderRadius.only(
    //                 topLeft: Radius.circular(25),
    //                 topRight: Radius.circular(25),
    //                 bottomRight: Radius.circular(25),
    //               ),
    //             ),
    //             child: Padding(
    //               padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.5.h),
    //               child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin maximus ac arcu nec tristique. ",
    //                 style: TextStyle(
    //                     fontFamily: FontUtils.avertaDemoRegular,
    //                     fontSize: 1.8.t,
    //                     color: Colors.white
    //                 ),
    //               ),
    //             ),
    //           ),
    //           SizedBox(height: 1.h,),
    //           Text("Wed. 20:32",
    //             style: TextStyle(
    //                 fontFamily: FontUtils.avertaDemoRegular,
    //                 fontSize: 1.5.t,
    //                 color: ColorUtils.blueColor
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //
    //     SizedBox(height: 5.h,),
    //     Align(
    //       alignment: Alignment.centerRight,
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.end,
    //         children: [
    //           Container(
    //             width: MediaQuery.of(context).size.width / 1.6,
    //             decoration: BoxDecoration(
    //               color: ColorUtils.chatBackground,
    //               borderRadius: BorderRadius.only(
    //                 topLeft: Radius.circular(25),
    //                 topRight: Radius.circular(25),
    //                 //bottomRight: Radius.circular(0),
    //                 bottomLeft: Radius.circular(25),
    //               ),
    //             ),
    //             child: Padding(
    //               padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.5.h),
    //               child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin maximus ac arcu nec tristique. ",
    //                 style: TextStyle(
    //                     fontFamily: FontUtils.avertaDemoRegular,
    //                     fontSize: 1.8.t,
    //                     color: ColorUtils.darkText
    //                 ),
    //               ),
    //             ),
    //           ),
    //           SizedBox(height: 1.h,),
    //           Text("Wed. 20:32",
    //             style: TextStyle(
    //                 fontFamily: FontUtils.avertaDemoRegular,
    //                 fontSize: 1.5.t,
    //                 color: ColorUtils.blueColor
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     SizedBox(height: 2.h,),
    //     Row(
    //       mainAxisSize: MainAxisSize.min,
    //       //crossAxisAlignment: CrossAxisAlignment.end,
    //       children: [
    //         Expanded(
    //           child: Container(
    //             //width: 200.0,
    //             margin: EdgeInsets.only(
    //               //left: SizeConfig.widthMultiplier * 4.5,
    //               right: SizeConfig.widthMultiplier * 2,
    //               //top: SizeConfig.heightMultiplier * 3,
    //             ),
    //             decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.all(
    //                   Radius.circular(15.0),
    //                 ),
    //                 border: Border.all(color: ColorUtils.blueColor)
    //             ),
    //             child: Container(
    //               //color: Colors.amber,
    //               margin:
    //               EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 3,),
    //               child: Row(
    //                 children: [
    //                   ExpandTapWidget(
    //                     onTap: () {
    //                       model.emojiShowing = !model.emojiShowing;
    //                       model.emojiSelected = !model.emojiSelected;
    //                       SchedulerBinding.instance!.addPostFrameCallback((_) {
    //                         model.scrollController.jumpTo(model.scrollController.position.maxScrollExtent);
    //                       });
    //                       setState(() {
    //                       });
    //                     },
    //                     tapPadding: EdgeInsets.all(25.0),
    //                     child: SvgPicture.asset(ImageUtils.smileyIcon),
    //                   ),
    //                   // GestureDetector(
    //                   //   onTap: (){
    //                   //     emojiShowing = !emojiShowing;
    //                   //     emojiSelected = !emojiSelected;
    //                   //     SchedulerBinding.instance!.addPostFrameCallback((_) {
    //                   //       scrollController.jumpTo(scrollController.position.maxScrollExtent);
    //                   //     });
    //                   //     setState(() {
    //                   //     });
    //                   //   },
    //                   //   child: Container(
    //                   //     child: SvgPicture.asset(ImageUtils.smileyIcon),
    //                   //   ),
    //                   // ),
    //                   SizedBox(width: 1.w,),
    //                   Expanded(
    //                     child: Container(
    //                       margin: EdgeInsets.only(
    //                           left: SizeConfig.widthMultiplier * 3,
    //                           right: SizeConfig.widthMultiplier * 3),
    //                       child: TextField(
    //                         onTap: () {},
    //                         enabled: true,
    //                         //readOnly: true,
    //                         //focusNode: model.searchFocus,
    //                         controller: model.chatController,
    //                         decoration: InputDecoration(
    //                           hintText: "Type your message...",
    //                           hintStyle: TextStyle(
    //                             //fontFamily: FontUtils.proximaNovaRegular,
    //                             color: ColorUtils.silverColor,
    //                             fontSize: SizeConfig.textMultiplier * 1.9,
    //                           ),
    //                           border: InputBorder.none,
    //                           isDense: true,
    //                           contentPadding: EdgeInsets.symmetric(
    //                               vertical: SizeConfig.heightMultiplier * 2),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   Container(
    //                     decoration: BoxDecoration(
    //                       //color: ColorUtils.text_red,
    //                       borderRadius: BorderRadius.all(Radius.circular(15)),
    //                     ),
    //                     child: Row(
    //                       children: [
    //                         ExpandTapWidget(
    //                           onTap: () {
    //                             model.getImage();
    //                             setState(() {
    //                             });
    //                           },
    //                           tapPadding: EdgeInsets.all(50.0),
    //                           child: SvgPicture.asset(ImageUtils.plusIcon),
    //                         ),
    //                         // GestureDetector(
    //                         //   onTap: (){
    //                         //     model.getImage();
    //                         //   },
    //                         //     child: SvgPicture.asset(ImageUtils.plusIcon),
    //                         // ),
    //                         SizedBox(width: 4.w,),
    //                         ExpandTapWidget(
    //                             onTap: () async{
    //                               // final cameras = await availableCameras();
    //                               // final firstCamera = cameras.first;
    //                               //model.navigationService.navigateTo(to: TakePictureScreen(camera: firstCamera,));
    //                               model.openCamera();
    //                             },
    //                             tapPadding: EdgeInsets.all(25.0),
    //                             child: SvgPicture.asset(ImageUtils.photoCamera)
    //                         ),
    //                         // GestureDetector(
    //                         //   onTap: (){
    //                         //   },
    //                         //   child: SvgPicture.asset(ImageUtils.photoCamera)
    //                         // ),
    //                       ],
    //                     ),
    //                   ),
    //                   // Text(searchHere,
    //                   //   style: TextStyle(
    //                   //     fontFamily: FontUtils.gibsonRegular,
    //                   //     fontWeight: FontWeight.w400,
    //                   //     fontSize: SizeConfig.textMultiplier * 1.8,
    //                   //     color: ColorUtils.searchFieldText,
    //                   //   ),
    //                   // ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //         if(model.chatController.text.isEmpty)
    //           Container(
    //             decoration: BoxDecoration(
    //               shape: BoxShape.circle,
    //               color: ColorUtils.blueColor,
    //             ),
    //             child: Padding(
    //               padding: const EdgeInsets.all(15.0),
    //               child: SvgPicture.asset(ImageUtils.voiceRecorder,
    //                 //color: ColorUtils.blueColor,
    //               ),
    //             ),
    //           ),
    //         if(model.chatController.text.isNotEmpty)
    //           GestureDetector(
    //             onTap: () async{
    //               model.fireChat(widget.otherId!);
    //             },
    //             child: Icon(
    //               Icons.arrow_forward_ios,
    //             ),
    //           ),
    //       ],
    //     ),
    //     SizedBox(height: 2.h,),
    //     if(model.emojiSelected == true)
    //       Container(
    //         height: 30.h,
    //         child: Offstage(
    //           offstage: !model.emojiShowing,
    //           child: EmojiPicker(
    //               onEmojiSelected: (Category category, Emoji emoji) {
    //                 model.onEmojiSelected(emoji);
    //               },
    //               onBackspacePressed: model.onBackspacePressed,
    //               config: Config(
    //                   columns: 7,
    //                   // Issue: https://github.com/flutter/flutter/issues/28894
    //                   emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
    //                   verticalSpacing: 0,
    //                   horizontalSpacing: 0,
    //                   initCategory: Category.RECENT,
    //                   bgColor: const Color(0xFFF2F2F2),
    //                   indicatorColor: Colors.blue,
    //                   iconColor: Colors.grey,
    //                   iconColorSelected: Colors.blue,
    //                   progressIndicatorColor: Colors.blue,
    //                   backspaceColor: Colors.blue,
    //                   showRecentsTab: true,
    //                   recentsLimit: 28,
    //                   noRecentsText: 'No Recents',
    //                   noRecentsStyle: const TextStyle(
    //                       fontSize: 20, color: Colors.black26),
    //                   tabIndicatorAnimDuration: kTabScrollDuration,
    //                   categoryIcons: const CategoryIcons(),
    //                   buttonMode: ButtonMode.MATERIAL)),
    //         ),
    //       ),
    //   ],
    // ),
  }
}

