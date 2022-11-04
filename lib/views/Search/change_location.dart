import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/dimensions.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/utils/size_config.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/widgets/cupertino_back_arrow.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

class ChangeLocation extends StatefulWidget {
  const ChangeLocation({Key? key}) : super(key: key);

  @override
  _ChangeLocationState createState() => _ChangeLocationState();
}

class _ChangeLocationState extends State<ChangeLocation> {

  final changeLocationController = TextEditingController();

  void dispose() {
    changeLocationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model){
        model.regionalDistricts();
      },
      builder: (context, model, child) {
        return GestureDetector(
          onTap: (){
            context.unFocus();
          },
          child: SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Container(
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
                          Text("Change Location",
                            style: TextStyle(
                                fontFamily: FontUtils.avertaSemiBold,
                                fontSize: 3.t,
                                color: ColorUtils.darkText
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 3.h,),
                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       //color: ColorUtils.textFieldBg,
                    //       borderRadius: BorderRadius.all(
                    //         Radius.circular(6.0),
                    //       ),
                    //       border: Border.all(
                    //           color: ColorUtils.blueColor)),
                    //   child: Container(
                    //     margin: EdgeInsets.symmetric(
                    //       horizontal: SizeConfig.widthMultiplier * 3,
                    //     ),
                    //     child: Row(
                    //       children: [
                    //         Container(
                    //           child: SvgPicture.asset(
                    //             ImageUtils.textFieldSearchIcon,
                    //             color: ColorUtils.blueColor,
                    //           ),
                    //         ),
                    //         Expanded(
                    //           child: Container(
                    //             margin: EdgeInsets.only(
                    //                 left: SizeConfig.widthMultiplier *
                    //                     3,
                    //                 right:
                    //                 SizeConfig.widthMultiplier *
                    //                     3),
                    //             child: TextField(
                    //               onTap: () {},
                    //               enabled: true,
                    //               style: TextStyle(
                    //                 fontFamily: FontUtils.avertaDemoRegular,
                    //                 color: ColorUtils.blueColor,
                    //                 fontSize: SizeConfig.textMultiplier * 1.9,
                    //               ),
                    //               //readOnly: true,
                    //               //focusNode: model.searchFocus,
                    //               controller: changeLocationController,
                    //               decoration: InputDecoration(
                    //                 hintText:
                    //                 "Cusco",
                    //                 hintStyle: TextStyle(
                    //                   fontFamily:
                    //                   FontUtils.avertaDemoRegular,
                    //                   color: ColorUtils.blueColor,
                    //                   fontSize:
                    //                   SizeConfig.textMultiplier *
                    //                       1.9,
                    //                 ),
                    //                 border: InputBorder.none,
                    //                 isDense: true,
                    //                 contentPadding:
                    //                 EdgeInsets.symmetric(
                    //                     vertical: SizeConfig
                    //                         .heightMultiplier *
                    //                         2),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //         //SvgPicture.asset(ImageUtils.targetIcon),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Text(
                      "District",
                      style: TextStyle(
                        fontFamily: FontUtils.avertaSemiBold,
                        fontSize: 1.6.t,
                        color: ColorUtils.blueColor,
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 2.3.w),
                      width: double.infinity,
                      height: 6.5.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius:
                          BorderRadius.all(Radius.circular(6.0)),
                          border: Border.all(
                            //width: 2.0,
                            color: ColorUtils.blueColor,
                          )),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          itemPadding: EdgeInsets.zero,
                          dropdownMaxHeight: 20.h,
                          isExpanded: true,
                          hint: Padding(
                            padding: EdgeInsets.only(
                              left: 4.w,
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  ImageUtils.district,
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(
                                  model.changeLocationDist == null ?
                                  model.getUserDistrict! : model.changeLocationDist!,
                                  style: TextStyle(
                                      fontFamily:
                                      FontUtils.avertaSemiBold,
                                      fontSize: 2.5.t,
                                      color: ColorUtils.blueColor),
                                ),
                              ],
                            ),
                          ),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                            size: 6.i,
                          ),
                          items: model.allDistrictsList
                              .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 4.w,
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    ImageUtils.district,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                    item,
                                    style: TextStyle(
                                        fontFamily: FontUtils
                                            .avertaSemiBold,
                                        fontSize: 2.5.t,
                                        color: ColorUtils
                                            .blueColor),
                                  ),
                                ],
                              ),
                            ),
                          ))
                              .toList(),
                          value: model.changeLocationDist,
                          onChanged: (value) {
                            setState(() {
                              model.changeLocationDist = value as String;
                              model.getUserDistrict = model.changeLocationDist;
                              model.notifyListeners();
                            });
                            //model.enterDetailsDistrictSelected = true;
                            //model.notifyListeners();
                          },
                          // buttonHeight: 40,
                          // buttonWidth: 140,
                          // itemHeight: 40,
                          // itemWidth: 140,
                        ),
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
