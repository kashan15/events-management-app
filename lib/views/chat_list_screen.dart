import 'package:cached_network_image/cached_network_image.dart';
import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/EventDetails/chat_screen.dart';
import 'package:democratic_unity/views/Notifications/notifications.dart';
import 'package:democratic_unity/views/blocked_users.dart';
import 'package:democratic_unity/views/drawer.dart';
import 'package:democratic_unity/widgets/app_localization.dart';
import 'package:democratic_unity/widgets/cupertino_back_arrow.dart';
import 'package:democratic_unity/widgets/loader_2.dart';
import 'package:democratic_unity/widgets/loader_3.dart';
import 'package:democratic_unity/widgets/loader_4.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stacked/stacked.dart';

class FriendsChatList extends StatefulWidget {
  const FriendsChatList({Key? key}) : super(key: key);

  @override
  _FriendsChatListState createState() => _FriendsChatListState();
}

class _FriendsChatListState extends State<FriendsChatList> {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      onModelReady: (model)async{
        await model.gettingFriendsIds();
        await model.gettingAllChatUsers();
      },
      disposeViewModel: false,
      builder: (context, model, child) {
        return GestureDetector(
          onTap: (){
            context.unFocus();
          },
          child:
          SafeArea(
            top: false,
            bottom: false,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: context.getPadding().top,),
                  Container(
                    //color: Colors.amber,
                    padding: EdgeInsets.only(
                        left: 4.w,
                        right: 4.w,
                        top: 3.h
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: context.getPadding().top,),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.translate("chat") ?? "",
                                style: TextStyle(
                                    fontFamily: FontUtils.avertaSemiBold,
                                    fontSize: 3.t,
                                    color: ColorUtils.darkText
                                ),
                              ),
                              SizedBox(width: 4.w,),
                              Row(
                                children: [
                                  // ExpandTapWidget(
                                  //   onTap: (){
                                  //     Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:AllNotifications()));
                                  //   },
                                  //   tapPadding: EdgeInsets.all(4.i),
                                  //   child: SvgPicture.asset(ImageUtils.notificationBell),
                                  // ),
                                  // SizedBox(width: 5.w,),
                                  // Container(
                                  //   width: 5.w,
                                  //   child: PopupMenuButton(
                                  //     child: Icon(Icons.more_vert),
                                  //     itemBuilder: (_) => <PopupMenuItem<String>>[
                                  //       new PopupMenuItem<String>(
                                  //         child: new Text('Blocked Users'), value: 'Blocked Users',
                                  //         onTap: (){
                                  //           Navigator.pop(context);
                                  //           Navigator.push(context, PageTransition(child: BlockedUsers(), type: PageTransitionType.fade));
                                  //           model.navigationService.navigateTo(to: BlockedUsers());//
                                  //           //model.blockingUsers(widget.otherFirebaseId!, widget.otherUserId!);
                                  //         },
                                  //       ),
                                  //       // new PopupMenuItem<String>(
                                  //       //     child: new Text('Report'), value: 'Report'),
                                  //     ],
                                  //     //onSelected: (onSelected){},
                                  //   ),
                                  // ),

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

                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: model.isLoading == true ? Loader2() :

                    // child: model.isLoading1 == true ? Loader4() :
                    Container(
                      padding: EdgeInsets.only(
                        left: 4.w,
                        right: 4.w,
                      ),
                      child: model.friendsList.length != 0 ?
                      ListView.separated(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: model.chatUsers.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child: ChatScreen(
                                          otherFirebaseId: model.chatUsers[index].FirebaseUserId!,
                                          userName: model.chatUsers[index].fname!,
                                          profilePicture: model.chatUsers[index].ProfileImage!,
                                          otherUserId: model.chatUsers[index].UserId!,
                                          province: model.chatUsers[index].province!,
                                          district: model.chatUsers[index].district!,
                                          state: model.chatUsers[index].department!,
                                          createdAt: model.chatUsers[index].createdDtm!,
                                          //state: model.chatUsers[index].S!,
                                        )));
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
                                          Stack(
                                            alignment: Alignment.bottomRight,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child:
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(16),
                                                  child:
                                                  CachedNetworkImage(
                                                    imageUrl: model.chatUsers[index].ProfileImage!,
                                                    width: 16.i,
                                                    height: 16.i,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              // if (friendsList[index]
                                              // ["online"] ==
                                              //     true)
                                              //   Container(
                                              //     decoration:
                                              //     BoxDecoration(
                                              //       shape: BoxShape.circle,
                                              //       color: Colors.white,
                                              //     ),
                                              //     child: Padding(
                                              //       padding: const EdgeInsets.all(4.0),
                                              //       child: Container(
                                              //         decoration:
                                              //         BoxDecoration(
                                              //           shape:
                                              //           BoxShape.circle,
                                              //           color: ColorUtils.redColor,
                                              //         ),
                                              //         width: 2.5.i,
                                              //         height: 2.5.i,
                                              //       ),
                                              //     ),
                                              //   ),
                                              // CircleAvatar(
                                              //   radius: 30.0,
                                              //   backgroundImage: AssetImage(
                                              //       friendsList[index]
                                              //       ["image"]),
                                              //   backgroundColor:
                                              //   Colors.transparent,
                                              // ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                model.chatUsers[index].fname!,
                                                style: TextStyle(
                                                  fontFamily: FontUtils
                                                      .modernistBold,
                                                  fontSize: 1.9.t,
                                                  //color: ColorUtils.text_dark
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              /*Container(
                                                width: MediaQuery.of(context).size.width / 2,
                                                child: Text(
                                                  model.LastMessages[index],
                                                  style: TextStyle(
                                                    fontFamily: FontUtils
                                                        .modernistRegular,
                                                    fontSize: 1.8.t,
                                                    //color: ColorUtils.lightTextColor
                                                  ),
                                                ),
                                              ),*/
                                            ],
                                          ),
                                        ],
                                      ),
                                      // Column(
                                      //   crossAxisAlignment: CrossAxisAlignment.end,
                                      //   children: [
                                      //     Text(
                                      //       friendsList[index]["time"],
                                      //       style: TextStyle(
                                      //         fontFamily: FontUtils
                                      //             .modernistRegular,
                                      //         fontSize: 1.6.t,
                                      //         //color: ColorUtils.chatTime,
                                      //       ),
                                      //     ),
                                      //     SizedBox(
                                      //       height: 1.h,
                                      //     ),
                                      //     if (friendsList[index]["name"] == "Theresa Webb"
                                      //         ||
                                      //         friendsList[index]["name"] == "Calven Flores"
                                      //     )
                                      //       Container(
                                      //         decoration: BoxDecoration(
                                      //           shape: BoxShape.circle,
                                      //           color: ColorUtils.blueColor,
                                      //         ),
                                      //         child: Center(
                                      //           child: Padding(
                                      //             padding:
                                      //             const EdgeInsets.all(
                                      //                 8.0),
                                      //             child: Text(
                                      //               "2",
                                      //               style: TextStyle(
                                      //                   fontFamily: FontUtils
                                      //                       .modernistBold,
                                      //                   fontSize: 1.5.t,
                                      //                   color:
                                      //                   Colors.white),
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     if (friendsList[index]["name"] == "Gregory Bell"
                                      //         ||
                                      //         friendsList[index]["name"] == "Soham Henry"
                                      //         ||
                                      //         friendsList[index]["name"] == "Mother"
                                      //         ||
                                      //         friendsList[index]["name"] == "Brother"
                                      //     )
                                      //       Image.asset(ImageUtils.doubleCheck,
                                      //         width: 5.i,
                                      //         height: 5.i,
                                      //       ),
                                      //   ],
                                      // ),
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
                      ) :
                      Center(
                        child: Text("No Chat Found",
                          style: TextStyle(
                            fontFamily: FontUtils.avertaSemiBold,
                            fontSize: 2.5.t,
                            color: ColorUtils.darkText,
                          ),
                        ),
                      )
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
