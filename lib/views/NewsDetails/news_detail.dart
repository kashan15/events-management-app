import 'package:cached_network_image/cached_network_image.dart';
import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/dimensions.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/drawer.dart';
import 'package:democratic_unity/widgets/back_arrow_with_container.dart';
import 'package:democratic_unity/widgets/loader_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class NewsDetail extends StatefulWidget {

  int index;

  NewsDetail({required this.index, Key? key}) : super(key: key);

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      onModelReady: (model) {
        //await model.gettingAttendeeDetails(model.eventsList[widget.index].id!);
      },
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return
          model.isLoading == false ?
          //model.gettingTheAttendee == false ?
          SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
              drawer: DrawerScreen(),
              backgroundColor: Colors.white,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: context.getPadding().top,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2.7,
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 3.5.h),
                          decoration: BoxDecoration(
                            color: ColorUtils.blueColor,
                            // image: DecorationImage(
                            //     image: CachedNetworkImage(
                            //         imageUrl:model.eventsList[widget.index].eventBanner!
                            //     ),
                            //     fit: BoxFit.cover)
                          ),
                          child: CachedNetworkImage(
                            width: MediaQuery.of(context).size.width / 1,
                            imageUrl:model.newsFeedList[widget.index].NewsImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          margin:
                          EdgeInsets.only(left: 4.w, right: 4.w, top: 3.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  BackArrowContainer(),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  // Text(
                                  //   "News Details",
                                  //   style: TextStyle(
                                  //       fontFamily: FontUtils.avertaBold,
                                  //       fontSize: 2.7.t,
                                  //       color: Colors.white),
                                  // ),
                                ],
                              ),
                            ],
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
                          //vertical: 3.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.newsFeedList[widget.index].NewsTitle ?? "",
                              style: TextStyle(
                                  fontFamily: FontUtils.avertaBold,
                                  fontSize: 2.7.t,
                                  color: ColorUtils.titleText),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            // Row(
                            //   children: [
                            //     Container(
                            //       width: 12.w,
                            //       height: 6.h,
                            //       decoration: BoxDecoration(
                            //           color: ColorUtils.eventIconBg,
                            //           borderRadius: BorderRadius.all(
                            //               Radius.circular(12))),
                            //       child: Center(
                            //         child: SvgPicture.asset(
                            //           ImageUtils.redCalender,
                            //         ),
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width: 4.w,
                            //     ),
                            //     Column(
                            //       crossAxisAlignment:
                            //       CrossAxisAlignment.start,
                            //       children: [
                            //         Text(
                            //           model.newsFeedList[widget.index]
                            //               .createdDtm!
                            //               .substring(8, 10) +
                            //               " " +
                            //               DateFormat('MMMM')
                            //                   .format(DateTime(
                            //                   0,
                            //                   int.parse(model
                            //                       .newsFeedList[
                            //                   widget.index]
                            //                       .createdDtm!
                            //                       .substring(5, 7))))
                            //                   .toString() +
                            //               "," +
                            //               " " +
                            //               model.newsFeedList[widget.index]
                            //                   .createdDtm!
                            //                   .substring(0, 4),
                            //           style: TextStyle(
                            //               fontFamily:
                            //               FontUtils.avertaSemiBold,
                            //               fontSize: 2.t,
                            //               color: ColorUtils.darkText),
                            //         ),
                            //         SizedBox(
                            //           height: 1.h,
                            //         ),
                            //         Text(
                            //           DateFormat('EEEE').format(
                            //               DateTime.parse(model
                            //                   .newsFeedList[
                            //               widget.index]
                            //                   .createdDtm!)) +
                            //               ","
                            //               +
                            //               " "
                            //               +
                            //               DateFormat.jm().format(DateTime.parse(model.newsFeedList[widget.index].createdDtm!))
                            //               // +
                            //               // " - "
                            //               // +
                            //               // DateFormat.jm().format(DateTime.parse(model.newsFeedList[widget.index].createdDtm!))
                            //           ,
                            //           style: TextStyle(
                            //               fontFamily:
                            //               FontUtils.avertaDemoRegular,
                            //               fontSize: 1.6.t,
                            //               color: ColorUtils.darkText),
                            //         ),
                            //       ],
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: 3.h,
                            // ),
                            // SizedBox(
                            //   height: 3.h,
                            // ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // SizedBox(
                                //   height: 5.h,
                                // ),
                                // Text(
                                //   "News Description",
                                //   style: TextStyle(
                                //       fontFamily: FontUtils.modernistBold,
                                //       fontSize: 2.2.t,
                                //       color: ColorUtils.titleText),
                                // ),
                                // SizedBox(
                                //   height: 2.h,
                                // ),
                                Text(
                                  model.newsFeedList[widget.index].NewsDescription!,
                                  style: TextStyle(
                                      fontFamily: FontUtils.modernistRegular,
                                      fontSize: 1.5.t,
                                      color: ColorUtils.darkText),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 7.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
              : Loader2();
      },
    );
  }
}
