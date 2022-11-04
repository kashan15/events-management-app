import 'package:cached_network_image/cached_network_image.dart';
import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

class UserProfile extends StatefulWidget {
  String? profilePic;
  String? name;
  String? province;
  String? district;
  String? state;
  String? createdAt;
  UserProfile({this.profilePic, this.name, this.province, this.district,this.state,this.createdAt,Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model){
      },
      builder: (context, model, child) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              //margin: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: context.getPadding().top,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 2.5.w, right: 4.w),
                    child: Row(
                      children: [
                        IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            icon: SvgPicture.asset(
                              ImageUtils.backCupertino,
                              color: ColorUtils.darkText,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          "Profile",
                          style: TextStyle(
                            fontFamily: FontUtils.avertaBold,
                            fontSize: 3.t,
                            color: ColorUtils.darkText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Container(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CachedNetworkImage(
                            imageUrl:widget.profilePic!,
                            width: 20.i,
                            height: 20.i,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 2.h,),
                        Text(
                          widget.name!,
                        style: TextStyle(
                          fontFamily: FontUtils.avertaBold,
                          fontSize: 3.0.t,
                          color: ColorUtils.darkText,
                        ),
                        ),
                        SizedBox(height: 1.h,),
                        Text("(Member since ${widget.createdAt!.substring(0,4)})",
                          style: TextStyle(
                            fontFamily: FontUtils.avertaBold,
                            fontSize: 1.8.t,
                            color: ColorUtils.blueColor,
                          ),
                        ),
                        SizedBox(height: 5.h,),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 22.h,
                                  decoration: BoxDecoration(
                                    color: ColorUtils.provinceColor,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Padding(
                                    padding:EdgeInsets.symmetric(vertical: 2.h),
                                    child: Column(
                                      children: [
                                        Text("Province",
                                          style: TextStyle(
                                            fontFamily: FontUtils.avertaBold,
                                            fontSize: 1.8.t,
                                            color: ColorUtils.darkText,
                                          ),
                                        ),
                                        SizedBox(height: 2.h,),
                                        SvgPicture.asset(ImageUtils.userProvince,
                                        width: 15.i,
                                          height: 15.i,
                                        ),
                                        SizedBox(height: 2.h,),
                                        Text(widget.province!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: FontUtils.avertaDemoRegular,
                                            fontSize: 1.8.t,
                                            color: ColorUtils.darkText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w,),
                              Expanded(
                                child: Container(
                                  height: 22.h,
                                  decoration: BoxDecoration(
                                    color: ColorUtils.districtColor,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Padding(
                                    padding:EdgeInsets.symmetric(vertical: 2.h),
                                    child: Column(
                                      children: [
                                        Text("District",
                                          style: TextStyle(
                                            fontFamily: FontUtils.avertaBold,
                                            fontSize: 1.8.t,
                                            color: ColorUtils.darkText,
                                          ),
                                        ),
                                        SizedBox(height: 2.h,),
                                        SvgPicture.asset(ImageUtils.userDistrict,
                                        width: 15.i,
                                        height: 15.i,
                                        ),
                                        SizedBox(height: 2.h,),
                                        Text(widget.district!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: FontUtils.avertaDemoRegular,
                                            fontSize: 1.8.t,
                                            color: ColorUtils.darkText,
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
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            color: ColorUtils.stateColor,
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 3.h,),
                              Text("State",
                                style: TextStyle(
                                  fontFamily: FontUtils.avertaBold,
                                  fontSize: 2.t,
                                  color: ColorUtils.darkText,
                                ),
                              ),
                              SizedBox(height: 2.h,),
                              SvgPicture.asset(ImageUtils.state),
                              SizedBox(height: 2.h,),
                              Text(widget.state!,
                                style: TextStyle(
                                  fontFamily: FontUtils.avertaDemoRegular,
                                  fontSize: 2.t,
                                  color: ColorUtils.darkText,
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                            ],
                          ),
                        ),
                      ],
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
