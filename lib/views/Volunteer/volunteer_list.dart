import 'package:cached_network_image/cached_network_image.dart';
import 'package:democratic_unity/Model/attendee.dart';
import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/dimensions.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/EventDetails/chat_screen.dart';
import 'package:democratic_unity/views/drawer.dart';
import 'package:democratic_unity/widgets/cupertino_back_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

class VolunteerList extends StatefulWidget {

  List<AttendeeModel>? attendeesLength;

  VolunteerList({this.attendeesLength, Key? key}) : super(key: key);

  @override
  _VolunteerListState createState() => _VolunteerListState();
}

class _VolunteerListState extends State<VolunteerList> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      onModelReady: (model){
      },
      disposeViewModel: false,
      builder: (context, model, child) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            drawer: DrawerScreen(),
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
                    children: [
                      CupertinoBackArrow(),
                      SizedBox(width: 4.w,),
                      Text("Volunteer List",
                        style: TextStyle(
                            fontFamily: FontUtils.avertaSemiBold,
                            fontSize: 3.t,
                            color: ColorUtils.darkText
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.horizontalPadding,
                      //vertical: Dimensions.verticalPadding,
                    ),
                    child:
                    model.voluntreeLength != 0 ?
                    ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: ()async{
                            // model.otherPubNubUserId = widget.attendeesLength![index].UserId;
                            // //model.fireChat(widget.attendeesLength![index].FirebaseUserId!);
                            // //model.loadingAllChat(widget.attendeesLength![index].FirebaseUserId!);
                            // //model.subscribeChannel();
                            // bool channelFound = false;
                            // model.channelID = model.userId!+model.otherPubNubUserId!;
                            // model.myChannel = model.pubnub!.channel(model.channelID);
                            // //await model.myChannel!.messages().fetch();
                            // await model.pubnub!.hereNow(
                            //     channels: {model.channelID}
                            // ).then((value){
                            //   print(value);
                            //   if (value.channels[model.channelID]!.uuids.length>0){
                            //     channelFound = true;
                            //   }
                            //   //if (value.channels)
                            // })
                            //     .catchError((error){
                            //   print(error);
                            // });
                            // if (!channelFound){
                            //   model.channelID = model.otherPubNubUserId!+model.userId!;
                            //   model.myChannel = model.pubnub!.channel(model.channelID);
                            //   await model.pubnub!.hereNow(
                            //       channels: {model.channelID}
                            //   ).then((value){
                            //     print(value);
                            //     if (value.channels[model.channelID]!.uuids.length>0){
                            //       channelFound = true;
                            //     }
                            //     //if (value.channels)
                            //   })
                            //       .catchError((error){
                            //     print(error);
                            //   });
                            // }

                            // if (model.channels.where((element)=>element.contains(model.otherPubNubUserId!)).isNotEmpty){
                            //   model.channelID = model.channels.where((element)=>element.contains(model.otherPubNubUserId!)).first;
                            // }
                            // else {
                            //   await model.pubnub!.objects.setChannelMembers(model.userId!+model.otherPubNubUserId!, [
                            //     ChannelMemberMetadataInput(model.otherPubNubUserId!)
                            //   ]);
                            //   model.channelID = model.userId!+model.otherPubNubUserId!;
                            // }
                            model.navigationService.navigateTo(to: ChatScreen(
                              otherFirebaseId: widget.attendeesLength![index].FirebaseUserId!,
                              userName: widget.attendeesLength![index].fname!,
                              profilePicture: widget.attendeesLength![index].ProfileImage!,
                              otherUserId: widget.attendeesLength![index].UserId,
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
                                          imageUrl:widget.attendeesLength![index].ProfileImage!,
                                          width: 17.i,
                                          height: 17.i,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 2.w,),
                                      Text(widget.attendeesLength![index].fname!,
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
                      itemCount: model.voluntreeLength!,
                    ) :
                    Center(
                      child: Text("No Volunteer Found",
                        style: TextStyle(
                          fontFamily: FontUtils.avertaSemiBold,
                          fontSize: 2.5.t,
                          color: ColorUtils.darkText,
                        ),
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
