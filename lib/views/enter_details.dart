import 'dart:io';

import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:democratic_unity/Model/get_departments.dart';
import 'package:democratic_unity/Model/get_provinces.dart';
import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/home_screen.dart';
import 'package:democratic_unity/widgets/back_arrow.dart';
import 'package:democratic_unity/widgets/custom_button.dart';
import 'package:democratic_unity/widgets/drop_down.dart';
import 'package:democratic_unity/widgets/loader.dart';
import 'package:democratic_unity/widgets/loader_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:stacked/stacked.dart';
import 'package:democratic_unity/utils/extensions.dart';

class EnterDetails extends StatefulWidget {
  const EnterDetails({Key? key}) : super(key: key);

  @override
  _EnterDetailsState createState() => _EnterDetailsState();
}

class _EnterDetailsState extends State<EnterDetails> {
  // @override
  // void initState() {
  //   selectGender = "Male";
  //   super.initState();
  // }

  // List<String> gender = [
  //   'Male',
  //   'Female',
  // ];
  //
  // List<String> department = [
  //   'department 1',
  //   'department 2',
  // ];
  //
  // List<String> province = [
  //   'province 1',
  //   'province 2',
  // ];
  //
  // List<String> district = [
  //   'district 1',
  //   'district 2',
  // ];
  //
  //
  // String? selectGender;
  // String? selectDepart;
  // String? selectProvince;
  // String? selectDistrict;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model) async {
        model.enterDetailsNameController.clear();
        model.enterDetailsProfileFileImage = null;
        model.enterDetailsEmailController.clear();
        model.selectedDOB = DateTime.now();
        model.selectedDepart = null;
        model.selectedProv = null;
        model.selectedDist = null;
        //model.enterDetailsEmailController.clear();
        //model.enterDetailsPhoneController.clear();
        model.regionalDepartment();
        model.regionalProvinces();
        model.regionalDistricts();
        model.detailsSelectGender = "Male";
        //model.initialize();
      },
      builder: (context, model, child) {
        return model.readyingAllDepartments == true ? Center(child: Loader2()) :
          SafeArea(
          top: false,
          bottom: false,
          child: GestureDetector(
            onTap: () {
              context.unFocus();
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 6.h,
                    ),
                    // Align(alignment: Alignment.centerLeft, child: BackArrow()),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "Enter your details",
                                style: TextStyle(
                                  fontFamily: FontUtils.avertaBold,
                                  fontSize: 3.05.t,
                                  color: ColorUtils.blueColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Center(
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  // if(model.enterDetailsProfileFileImage == null)
                                  //   Container(
                                  //     //color: Colors.amber,
                                  //     width: 34.w,
                                  //     height: 17.h,
                                  //     child: Center(
                                  //       child: Container(
                                  //         decoration: BoxDecoration(
                                  //           borderRadius: BorderRadius.circular(16),
                                  //           border: Border.all(color: Colors.white,width: 1.5),
                                  //         ),
                                  //         child: ClipRRect(
                                  //           borderRadius: BorderRadius.circular(16),
                                  //           child: Image.asset(ImageUtils.userProfile,
                                  //             width: 25.i,
                                  //             height: 25.i,
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                    Container(
                                      //color: Colors.amber,
                                      width: 34.w,
                                      height: 17.h,
                                      child: Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            border: Border.all(color: Colors.white,width: 1.5),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(16),
                                            child:
                                                model.enterDetailsProfileFileImage == null ?
                                            Image.asset(
                                              ImageUtils.userProfile,
                                              //model.enterDetailsProfilePic!,
                                              //model.enterDetailsProfileFileImage ?? File(ImageUtils.userProfile),
                                              //model.enterDetailsProfileFileImage.toString(),
                                              width: 25.i,
                                              height: 25.i,
                                              fit: BoxFit.cover,
                                            ) :
                                                Image.file(
                                                  model.enterDetailsProfileFileImage!,
                                                  width: 25.i,
                                                  height: 25.i,
                                                  fit: BoxFit.cover,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  //if(model.editPressed == true)
                                    PopupMenuButton(
                                      offset: Offset(50,-5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: ColorUtils.blueColor,
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Colors.white,width: 1.5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: SvgPicture.asset(ImageUtils.profileCamera),
                                        ),
                                      ),
                                      itemBuilder: (_) => <PopupMenuItem<String>>[
                                        new PopupMenuItem<String>(
                                            child: new Text('Camera'), value: 'Camera',
                                          onTap: (){
                                              model.enterDetailsOpenCamera();
                                          },
                                        ),
                                        new PopupMenuItem<String>(
                                            child: new Text('Gallery'), value: 'Gallery',
                                        onTap: (){
                                          model.enterDetailsGetImage();
                                        },
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              "Full Name",
                              style: TextStyle(
                                fontFamily: FontUtils.avertaSemiBold,
                                fontSize: 1.6.t,
                                color: ColorUtils.blueColor,
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    // height: 6.5.h,
                                    // width: 10.w,
                                    //margin: const EdgeInsets.all(10.0),
                                    //padding: EdgeInsets.symmetric(vertical: SizeConfig.widthMultiplier * 4, horizontal: SizeConfig.heightMultiplier * 2.5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: ColorUtils.blueColor),
                                        //color: ColorUtils.searchField,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Column(children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          Container(
                                            child: SvgPicture.asset(
                                              ImageUtils.fullNameIcon,
                                              width: 6.i,
                                              height: 6.i,
                                            ),
                                            //ImageIcon(AssetImage("assets/icon_Atr.svg" ),color: ColorUtils.btn_blue,)
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Expanded(
                                            child: TextField(
                                              style: TextStyle(
                                                  fontFamily:
                                                      FontUtils.avertaSemiBold,
                                                  fontSize: 2.5.t,
                                                  color: ColorUtils.blueColor),
                                              controller: model.enterDetailsNameController,
                                              //scrollController: _countryCodeController,
                                              decoration: InputDecoration(
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  hintStyle: TextStyle(
                                                    fontSize: 2.5.t,
                                                    //color: ColorUtils.searchHintColor
                                                  )),
                                              keyboardType: TextInputType.text,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                                  ),
                                ),
                                // SizedBox(
                                //   width: 1.w,
                                // ),
                              ],
                            ),
                            SizedBox(
                              height: 2.5.h,
                            ),
                            Text(
                              "Email Address",
                              style: TextStyle(
                                fontFamily: FontUtils.avertaSemiBold,
                                fontSize: 1.6.t,
                                color: ColorUtils.blueColor,
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    // height: 6.5.h,
                                    // width: 10.w,
                                    //margin: const EdgeInsets.all(10.0),
                                    //padding: EdgeInsets.symmetric(vertical: SizeConfig.widthMultiplier * 4, horizontal: SizeConfig.heightMultiplier * 2.5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: ColorUtils.blueColor),
                                        //color: ColorUtils.searchField,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Column(children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          Container(
                                            child: SvgPicture.asset(
                                              ImageUtils.emailIcon,
                                              width: 5.5.i,
                                              height: 5.5.i,
                                            ),
                                            //ImageIcon(AssetImage("assets/icon_Atr.svg" ),color: ColorUtils.btn_blue,)
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Expanded(
                                            child: TextField(
                                              style: TextStyle(
                                                  fontFamily:
                                                      FontUtils.avertaSemiBold,
                                                  fontSize: 2.5.t,
                                                  color: ColorUtils.blueColor),
                                              controller: model
                                                  .enterDetailsEmailController,
                                              //scrollController: _countryCodeController,
                                              decoration: InputDecoration(
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  hintStyle: TextStyle(
                                                    fontSize: 2.5.t,
                                                    //color: ColorUtils.searchHintColor
                                                  )),
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                                  ),
                                ),
                                // SizedBox(
                                //   width: 1.w,
                                // ),
                              ],
                            ),
                            SizedBox(
                              height: 2.5.h,
                            ),
                            Text(
                              "Gender",
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
                              // width: double.infinity,
                              // height: 6.5.h,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6.0)),
                                  border: Border.all(
                                    //width: 2.0,
                                    color: ColorUtils.blueColor,
                                  )),
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: 2.2.w,
                                  right: 2.3.w,
                                ),
                                child: DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(
                                          ImageUtils.gender,
                                        ),
                                      ),
                                      prefixIconConstraints: BoxConstraints(
                                        minWidth: 4.i,
                                        minHeight: 4.i,
                                      ),
                                      hintText: "Gender",
                                      hintStyle: TextStyle(
                                        fontFamily: FontUtils.avertaDemoRegular,
                                        fontSize: 2.3.t,
                                        color: ColorUtils.blueColor,
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                      )),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.black,
                                    size: 6.i,
                                  ),
                                  onChanged: (newValue) {
                                    model.detailsSelectGender = newValue;
                                    setState(() {});
                                  },
                                  items: model.genderDetails.map((city) {
                                    return DropdownMenuItem(
                                      value: city,
                                      child: new Text(
                                        city,
                                        style: TextStyle(
                                          fontFamily: FontUtils.avertaSemiBold,
                                          fontSize: 2.3.t,
                                          color: ColorUtils.blueColor,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  value: model.detailsSelectGender,
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 2.5.h,
                            ),
                            Text(
                              "Date of Birth",
                              style: TextStyle(
                                fontFamily: FontUtils.avertaSemiBold,
                                fontSize: 1.6.t,
                                color: ColorUtils.blueColor,
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            InkWell(
                              onTap: () {
                                model.openAndSelectDob(context);
                                model.dateOfBirthSelected = true;
                                model.notifyListeners();
                                context.unFocus();
                              },
                              child: Container(
                                  height: 6.h,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                        6,
                                      ),
                                      border: Border.all(
                                          color: ColorUtils.blueColor)),
                                  // margin: EdgeInsets.only(
                                  //     top: 2.7.h,
                                  //     right: 3.5.w,
                                  //     left: 3.5.w),
                                  child: Stack(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 4.w, right: 4.w),
                                          child: Text(
                                            model.selectedDOB == null
                                                ? "Date of Birth"
                                                : DateFormat('yyyy-MM-dd')
                                                    .format(model.selectedDOB),
                                            style: model.selectedDOB == null
                                                ? TextStyle(
                                                    color: ColorUtils.darkBlue,
                                                    fontFamily: FontUtils
                                                        .avertaSemiBold,
                                                    fontSize: 2.5.t,
                                                  )
                                                : TextStyle(
                                                    color: ColorUtils.blueColor,
                                                    fontFamily: FontUtils
                                                        .avertaSemiBold,
                                                    fontSize: 2.2.t,
                                                  ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          margin: EdgeInsets.only(right: 4.w),
                                          child: SvgPicture.asset(
                                            ImageUtils.calender,
                                            width: 4.5.i,
                                            height: 4.5.i,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ),

                            SizedBox(
                              height: 2.5.h,
                            ),
                            // Text(
                            //   "Cellphone Number",
                            //   style: TextStyle(
                            //     fontFamily: FontUtils.avertaSemiBold,
                            //     fontSize: 1.6.t,
                            //     color: ColorUtils.blueColor,
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 1.h,
                            // ),
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: Container(
                            //         // height: 6.5.h,
                            //         // width: 10.w,
                            //         //margin: const EdgeInsets.all(10.0),
                            //         //padding: EdgeInsets.symmetric(vertical: SizeConfig.widthMultiplier * 4, horizontal: SizeConfig.heightMultiplier * 2.5),
                            //         decoration: BoxDecoration(
                            //             border: Border.all(
                            //                 color: ColorUtils.blueColor),
                            //             //color: ColorUtils.searchField,
                            //             borderRadius: BorderRadius.all(
                            //                 Radius.circular(5))),
                            //         child: Column(children: <Widget>[
                            //           Row(
                            //             mainAxisAlignment:
                            //             MainAxisAlignment.start,
                            //             children: <Widget>[
                            //               SizedBox(
                            //                 width: 4.w,
                            //               ),
                            //               Container(
                            //                 child: Icon(
                            //                   Icons.phone,
                            //                   color: ColorUtils.blueColor,
                            //                 )
                            //                 // SvgPicture.asset(
                            //                 //   ImageUtils.emailIcon,
                            //                 //   width: 5.5.i,
                            //                 //   height: 5.5.i,
                            //                 // ),
                            //                 //ImageIcon(AssetImage("assets/icon_Atr.svg" ),color: ColorUtils.btn_blue,)
                            //               ),
                            //               SizedBox(
                            //                 width: 3.w,
                            //               ),
                            //               Expanded(
                            //                 child: TextField(
                            //                   readOnly: true,
                            //                   style: TextStyle(
                            //                       fontFamily:
                            //                       FontUtils.avertaSemiBold,
                            //                       fontSize: 2.5.t,
                            //                       color: ColorUtils.blueColor),
                            //                   controller: model.completeSignupPhoneNumber,
                            //                   //scrollController: _countryCodeController,
                            //                   decoration: InputDecoration(
                            //                       focusedBorder:
                            //                       InputBorder.none,
                            //                       enabledBorder:
                            //                       InputBorder.none,
                            //                       errorBorder: InputBorder.none,
                            //                       disabledBorder:
                            //                       InputBorder.none,
                            //                       hintStyle: TextStyle(
                            //                         fontSize: 2.5.t,
                            //                         //color: ColorUtils.searchHintColor
                            //                       )),
                            //                   keyboardType:
                            //                   TextInputType.emailAddress,
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         ]),
                            //       ),
                            //     ),
                            //     // SizedBox(
                            //     //   width: 1.w,
                            //     // ),
                            //   ],
                            // ),
                            Text(
                              "Phone Number",
                              style: TextStyle(
                                fontFamily: FontUtils.avertaSemiBold,
                                fontSize: 1.6.t,
                                color: ColorUtils.blueColor,
                              ),
                            ),
                            SizedBox(
                              height: 1.2.h,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 3.w,top: 0.h,bottom: 0.h),
                              height: 6.25.h,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(
                                    6,
                                  ),
                                  border: Border.all(color: ColorUtils.blueColor)
                              ),
                              child: IntlPhoneField(
                                textAlignVertical: TextAlignVertical.center,
                                //countryCodeTextColor: ColorUtils.darkBlue,
                                //controller: model.loginPhoneController,

                                controller: model.signupPhoneController,



                                // controller: TextEditingController(text: '${model.phoneNo}'),

                                autovalidateMode: AutovalidateMode.disabled,
                                dropdownIconPosition: IconPosition.trailing,
                                //dropDownIcon: Icon(Icons.),
                                //showDropdownIcon: false,
                                style: TextStyle(
                                    fontFamily: FontUtils.avertaSemiBold,
                                    fontSize: 2.5.t,
                                    color: ColorUtils.darkBlue
                                ),
                                //autoValidate: false,
                                autofocus: false,
                                decoration: InputDecoration(
                                  suffixText: "",
                                  isDense: true,
                                  alignLabelWithHint: true,
                                  counterText: "",
                                  contentPadding: EdgeInsets.only(top: 0.h,left: 0.w,right: 0.w,bottom: 0.h),
                                  focusedBorder: InputBorder.none,
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 0.0.t,
                                  ),
                                  //alignLabelWithHint: true,
                                  //contentPadding: EdgeInsets.zero,
                                  //labelText: 'Phone Number',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                onTap: (){},
                                // initialCountryCode: 'PE',
                                // initialCountryCode: '${model.signupCountryCode}',

                                initialValue: '${model.signupCountryCode}',
                                onChanged: (phone) {

                                  // model.loginCountryCode = phone.countryCode ;
                                  // model.loginPhoneController.text = phone.number;
                                  // model.completeLoginPhoneNumber.text = phone.completeNumber;

                                  model.signupCountryCode = phone.countryCode;
                                  model.signupPhoneController.text = phone.number;
                                  model.completeSignupPhoneNumber.text = phone.completeNumber;
                                  model.notifyListeners();
                                },
                              ),
                            ),

                            SizedBox(
                              height: 2.5.h,
                            ),
                            Text(
                              "Department",
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
                                          ImageUtils.department,
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Text(
                                          "select any department",
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
                                  items: model.allDepartmentsList
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: 4.w,
                                              ),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    ImageUtils.department,
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
                                  value: model.selectedDepart,
                                  onChanged: (value) {
                                    setState(() {
                                      model.selectedDepart = value as String;
                                    });
                                    model.enterDetailsDepartSelected = true;
                                    model.notifyListeners();
                                  },
                                  // buttonHeight: 40,
                                  // buttonWidth: 140,
                                  // itemHeight: 40,
                                  // itemWidth: 140,
                                ),
                              ),
                            ),
                            // DropDownWidget(svgPicture: ImageUtils.department, places: model.allDepartmentsList, selectedValue: model.selectedDepart!),

                            SizedBox(
                              height: 2.5.h,
                            ),
                            Text(
                              "Province",
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
                                          ImageUtils.province,
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Text(
                                          "select any province",
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
                                  items: model.allProvincesList
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: 4.w,
                                              ),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    ImageUtils.province,
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
                                  value: model.selectedProv,
                                  onChanged: (value) {
                                    setState(() {
                                      model.selectedProv = value as String;
                                    });
                                    model.enterDetailsProvinceSelected = true;
                                    model.notifyListeners();
                                  },
                                  // buttonHeight: 40,
                                  // buttonWidth: 140,
                                  // itemHeight: 40,
                                  // itemWidth: 140,
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 2.5.h,
                            ),
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
                                          "select any district",
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
                                  value: model.selectedDist,
                                  onChanged: (value) {
                                    setState(() {
                                      model.selectedDist = value as String;
                                    });
                                    model.enterDetailsDistrictSelected = true;
                                    model.notifyListeners();
                                  },
                                  // buttonHeight: 40,
                                  // buttonWidth: 140,
                                  // itemHeight: 40,
                                  // itemWidth: 140,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Container(
                              height: 5.h,
                              child: Center(
                                child: model.errorMessage != null
                                    ? Text(
                                        model.errorMessage!,
                                        style: TextStyle(
                                          fontFamily: FontUtils.avertaSemiBold,
                                          color: ColorUtils.red,
                                          fontSize: 1.8.t,
                                        ),
                                        maxLines: null,
                                        textAlign: TextAlign.center,
                                      )
                                    : Container(),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                              ),
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 400),
                                width: MediaQuery.of(context).size.width / 1,
                                height: 6.5.h,
                                //margin: EdgeInsets.symmetric(horizontal: 5.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: ColorUtils.blueColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorUtils.blueColor.withOpacity(0.25),
                                      spreadRadius: 0,
                                      blurRadius: 10,
                                      offset: Offset(0, 5), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: MaterialButton(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                  onPressed: (){
                                    model.signupWithDetails();
                                  },
                                  child: model.addingDetails == false ?
                                  Text(
                                    "Continue",
                                    style: TextStyle(
                                        fontFamily: FontUtils.avertaSemiBold,
                                        fontSize: 2.2.t,
                                        color: Colors.white),
                                  ) : Loader(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.0.h,
                            ),
                          ],
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
