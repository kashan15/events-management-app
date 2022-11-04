import 'package:cached_network_image/cached_network_image.dart';
import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/utils/size_config.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/NewsDetails/news_detail.dart';
import 'package:democratic_unity/views/drawer.dart';
import 'package:democratic_unity/widgets/cupertino_back_arrow.dart';
import 'package:democratic_unity/widgets/loader_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class AllNews extends StatefulWidget {
  const AllNews({Key? key}) : super(key: key);

  @override
  _AllNewsState createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      onModelReady: (model){
        model.gettingTheNewsFeed();
      },
      disposeViewModel: false,
      builder: (context, model, child) {
        return
          model.isLoading == true ? Loader2() :
          GestureDetector(
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
                            Text("All News",
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
                          itemCount: model.newsFeedList.length,
                          //padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: (){
                                // model.gettingAttendeeDetails(
                                //   model.newsFeedList[index].id!,index,
                                // );
                                //model.navigationService.navigateTo(to: EventDetails(index: index,));
                                model.navigationService.navigateTo(to: NewsDetail(index: index,));
                              },
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
                                              child: CachedNetworkImage(imageUrl: model.newsFeedList[index].NewsImage!,
                                                errorWidget: (context, url, error) => new Image.asset(ImageUtils.error),
                                                fit: BoxFit.cover,
                                                width: 20.i,
                                                height: 20.i,
                                                //width: MediaQuery.of(context).size.width / 1,
                                              )
                                          ),
                                          SizedBox(width: 3.w,),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  model.newsFeedList[index]
                                                      .createdDtm!
                                                      .substring(8, 10) +
                                                      " " +
                                                      DateFormat('MMMM')
                                                          .format(DateTime(
                                                          0,
                                                          int.parse(model
                                                              .newsFeedList[
                                                          index]
                                                              .createdDtm!
                                                              .substring(5, 7))))
                                                          .toString() +
                                                      "," +
                                                      " " +
                                                      model.newsFeedList[index]
                                                          .createdDtm!
                                                          .substring(0, 4),
                                                  style: TextStyle(
                                                      fontFamily:
                                                      FontUtils.avertaSemiBold,
                                                      fontSize: 2.t,
                                                      color: ColorUtils.darkText),
                                                ),
                                                SizedBox(height: 1.h,),
                                                Text(model.newsFeedList[index].NewsTitle ?? "",
                                                  style: TextStyle(
                                                    fontFamily: FontUtils.modernistBold,
                                                    fontSize: 2.2.t,
                                                    //color: ColorUtils.blackText
                                                  ),
                                                ),
                                                SizedBox(height: 1.h,),
                                                // Row(
                                                //   children: [
                                                //     SvgPicture.asset(ImageUtils.locationEvent),
                                                //     SizedBox(width: 1.5.w,),
                                                //     Expanded(
                                                //       child: Text(model.upComingeventsList[index].location!,
                                                //         style: TextStyle(
                                                //           overflow: TextOverflow.ellipsis,
                                                //           fontFamily: FontUtils.modernistRegular,
                                                //           fontSize: 1.7.t,
                                                //           //color: ColorUtils.text_dark
                                                //         ),
                                                //       ),
                                                //     ),
                                                //   ],
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height:  SizeConfig.heightMultiplier * 2.5,);
                          },
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
