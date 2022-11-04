import 'package:cached_network_image/cached_network_image.dart';
import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/chat_list_screen.dart';
import 'package:democratic_unity/widgets/cupertino_back_arrow.dart';
import 'package:democratic_unity/widgets/loader_2.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class BlockedUsers extends StatefulWidget {
  const BlockedUsers({Key? key}) : super(key: key);

  @override
  _BlockedUsersState createState() => _BlockedUsersState();
}

class _BlockedUsersState extends State<BlockedUsers> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      onModelReady: (model)async{
        model.gettingAllBlockedUsers();
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
            child: Scaffold(
              body: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(height: context.getPadding().top,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: context.getPadding().top,),
                        Container(
                          child: Row(
                            children: [
                              CupertinoBackArrow(),
                              SizedBox(width: 4.w,),
                              Text("Blocked Users",
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
                    Expanded(
                      child: model.isLoading == true ? Loader2() :
                      Container(
                          padding: EdgeInsets.only(
                            left: 4.w,
                            right: 4.w,
                          ),
                          child: model.blockedUsers.length != 0 ?
                          ListView.separated(
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: model.blockedUsers.length,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 2.h,
                                        ),
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
                                                      imageUrl: model.blockedUsers[index].ProfileImage!,
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
                                            Text(
                                              model.blockedUsers[index].fname!,
                                              style: TextStyle(
                                                fontFamily: FontUtils
                                                    .modernistBold,
                                                fontSize: 1.9.t,
                                                //color: ColorUtils.text_dark
                                              ),
                                            ),
                                            // Expanded(
                                            //   child: Column(
                                            //     crossAxisAlignment:
                                            //     CrossAxisAlignment.start,
                                            //     children: [
                                            //       SizedBox(
                                            //         height: 1.h,
                                            //       ),
                                            //       Container(
                                            //         width: MediaQuery.of(context).size.width / 2,
                                            //         child: Text(
                                            //           "yo",
                                            //           //model.LastMessages[index],
                                            //           style: TextStyle(
                                            //             fontFamily: FontUtils
                                            //                 .modernistRegular,
                                            //             fontSize: 1.8.t,
                                            //             //color: ColorUtils.lightTextColor
                                            //           ),
                                            //         ),
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: ElevatedButton(onPressed: () async{
                                      model.unblockUserFbId = model.blockedUsers[index].FirebaseUserId!;
                                      model.notifyListeners();
                                      model.unblockTheUser();
                                    },
                                        child: Text("Unblock"),
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        primary: ColorUtils.blueColor,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 2.h,
                              );
                            },
                          ) :
                          Center(
                            child: Text("No Blocked User",
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
          ),
        );
      },
    );
  }
}
