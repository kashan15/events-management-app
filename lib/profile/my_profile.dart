import 'package:cached_network_image/cached_network_image.dart';
import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/enter_details.dart';
import 'package:democratic_unity/widgets/back_arrow.dart';
import 'package:democratic_unity/widgets/cupertino_back_arrow.dart';
import 'package:democratic_unity/widgets/custom_button.dart';
import 'package:democratic_unity/widgets/loader_2.dart';
import 'package:democratic_unity/widgets/loader_3.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:stacked/stacked.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  void initState() {
    //selectGender = "Male";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model) {
        // model.selectDepart = model.selectedDepart;
        // model.selectProvince = model.selectedProv;
        // model.selectDistrict = model.selectedDist;
        model.regionalDepartment();
        model.regionalProvinces();
        model.regionalDistricts();
        model.editProfileSelectedDOB = DateTime.parse(model.dob!);
        //model.getUserData();
      },
      builder: (context, model, child) {
        // print(model.country_code);
        // print(model.signupCountryCode);
        // print(model.loginCountryCode);
        // print(model.countryCodePref);
        return model.isLoading == true ? Loader2() :
        SafeArea(
          top: false,
          bottom: false,
          child: GestureDetector(
            onTap: () {
              context.unFocus();
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: ColorUtils.blueColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        )),
                    child: Stack(
                      children: [
                        Align(
                            alignment: Alignment.topRight,
                            child: SvgPicture.asset(
                              ImageUtils.profileRings,
                              width: 55.i,
                              height: 55.i,
                            )),
                        Column(
                          children: [
                            SizedBox(
                              height: context.getPadding().top,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 4.w, right: 4.w, top: 5.h),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            icon: SvgPicture.asset(
                                              ImageUtils.backCupertino,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        Text(
                                          "My Profile",
                                          style: TextStyle(
                                            fontFamily:
                                            FontUtils.avertaSemiBold,
                                            fontSize: 3.t,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        model.editPressed = true;
                                        model.notifyListeners();
                                      },
                                      child: Text(
                                        "Edit",
                                        style: TextStyle(
                                          shadows: [
                                            Shadow(
                                                color: Colors.white,
                                                offset: Offset(0, -2))
                                          ],
                                          color: Colors.transparent,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.white,
                                          //decorationThickness: 4,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 3.5.h,
                            ),
                            Column(
                              children: [
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    if (model.editPressed == false)
                                      Container(
                                        //color: Colors.amber,
                                        width: 34.w,
                                        height: 17.h,
                                        child: Center(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(16),
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1.5),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(16),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                model.getUserprofilePic!,
                                                errorWidget: (context, url, error) => new Image.asset(ImageUtils.error),
                                                width: 25.i,
                                                height: 25.i,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    // if (model.editPressed == false)
                                    //   Container(
                                    //     //color: Colors.amber,
                                    //     width: 34.w,
                                    //     height: 17.h,
                                    //     child: Center(
                                    //       child: Container(
                                    //         decoration: BoxDecoration(
                                    //           borderRadius:
                                    //               BorderRadius.circular(16),
                                    //           border: Border.all(
                                    //               color: Colors.white,
                                    //               width: 1.5),
                                    //         ),
                                    //         child: ClipRRect(
                                    //           borderRadius:
                                    //               BorderRadius.circular(16),
                                    //           child: Image.file(
                                    //             model.myProfileImage!,
                                    //             width: 25.i,
                                    //             height: 25.i,
                                    //             fit: BoxFit.cover,
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    if (model.editPressed == true)
                                      Center(
                                        child: Stack(
                                          alignment: Alignment.bottomRight,
                                          children: [
                                            // if(model.getUserprofilePic == null)
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
                                                      model.editProfileFileImage != null ?
                                                      Image.file(
                                                        model.editProfileFileImage!,
                                                        fit: BoxFit.cover,
                                                        width: 25.i,
                                                        height: 25.i,
                                                      ) :
                                                      CachedNetworkImage(
                                                        imageUrl: model.getUserprofilePic!,
                                                        fit: BoxFit.cover,
                                                        width: 25.i,
                                                        height: 25.i,
                                                        placeholder: (context, url) => Image.asset(ImageUtils.avatar,fit: BoxFit.cover,height: 37.i),
                                                      )
                                                    // Image.file(
                                                    //   model.enterDetailsProfileFileImage!,
                                                    //   width: 25.i,
                                                    //   height: 25.i,
                                                    //   fit: BoxFit.cover,
                                                    // ),
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
                                  ],
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                Text(
                                  //model.enterDetailsNameController.text,
                                  model.editProfileNameController.text,
                                  style: TextStyle(
                                    fontFamily: FontUtils.avertaBold,
                                    fontSize: 2.3.t,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 4.w, right: 4.w, top: 3.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(
                          //   height: 6.h,
                          // ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //SizedBox(height: 6.h,),
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
                                  if (model.editPressed == false)
                                    Container(
                                      height: 6.5.h,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: ColorUtils.blueColor),
                                          //color: ColorUtils.searchField,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          Container(
                                            child: SvgPicture.asset(
                                              ImageUtils.fullNameIcon,
                                              width: 6.i,
                                              height: 6.i,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Expanded(
                                            child: Text(
                                              model.fName!,
                                              style: TextStyle(
                                                  fontFamily:
                                                  FontUtils.avertaSemiBold,
                                                  fontSize: 2.5.t,
                                                  color: ColorUtils.blueColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (model.editPressed == true)
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
                                                      controller: model
                                                          .editProfileNameController,
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
                                    height: 2.h,
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
                                  IgnorePointer(
                                    ignoring: model.editPressed == true
                                        ? false
                                        : true,
                                    child: Container(
                                      // width: double.infinity,
                                      // height: 6.5.h,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6.0)),
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
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: SvgPicture.asset(
                                                  ImageUtils.gender,
                                                ),
                                              ),
                                              prefixIconConstraints:
                                              BoxConstraints(
                                                minWidth: 4.i,
                                                minHeight: 4.i,
                                              ),
                                              hintText: "Gender",
                                              hintStyle: TextStyle(
                                                fontFamily:
                                                FontUtils.avertaDemoRegular,
                                                fontSize: 2.3.t,
                                                color: ColorUtils.blueColor,
                                              ),
                                              enabledBorder:
                                              UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                              )),
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.black,
                                            size: 6.i,
                                          ),
                                          onChanged: (newValue) {
                                            model.editProfileGender = newValue;
                                            setState(() {});
                                          },
                                          items: model.genderDetails.map((city) {
                                            return DropdownMenuItem(
                                              value: city,
                                              child: new Text(
                                                city,
                                                style: TextStyle(
                                                  fontFamily:
                                                  FontUtils.avertaSemiBold,
                                                  fontSize: 2.3.t,
                                                  color: ColorUtils.blueColor,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          value: model.editProfileGender,
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 2.h,
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
                                  IgnorePointer(
                                    ignoring: model.editPressed == true
                                        ? false
                                        : true,
                                    child: InkWell(
                                      onTap: () {
                                        model.openAndSelectDob(context);
                                        context.unFocus();
                                      },
                                      child: Container(
                                          height: 7.h,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius.circular(
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
                                                      left: 5.w, right: 5.w),
                                                  child:
                                                  Text(
                                                    model.editProfileSelectedDOB == null
                                                        ? "Date of Birth"
                                                        : DateFormat(
                                                        'yyyy-MM-dd')
                                                        .format(model
                                                        .editProfileSelectedDOB),
                                                    style: model.editProfileSelectedDOB ==
                                                        null
                                                        ? TextStyle(
                                                      color: ColorUtils
                                                          .darkBlue,
                                                      fontFamily: FontUtils
                                                          .avertaSemiBold,
                                                      fontSize: 2.5.t,
                                                    )
                                                        : TextStyle(
                                                      color: ColorUtils
                                                          .blueColor,
                                                      fontFamily: FontUtils
                                                          .avertaSemiBold,
                                                      fontSize: 2.2.t,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                Alignment.centerRight,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      right: 6.w),
                                                  child: SvgPicture.asset(
                                                    ImageUtils.calender,
                                                    width: 6.i,
                                                    height: 6.i,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 2.h,
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
                                  // Container(
                                  //   height: 6.5.h,
                                  //   decoration: BoxDecoration(
                                  //       border: Border.all(
                                  //           color: ColorUtils.blueColor),
                                  //       //color: ColorUtils.searchField,
                                  //       borderRadius: BorderRadius.all(
                                  //           Radius.circular(5))),
                                  //   child: Row(
                                  //     children: [
                                  //       SizedBox(
                                  //         width: 4.w,
                                  //       ),
                                  //       Container(
                                  //           child: Icon(
                                  //             Icons.phone,
                                  //             color: ColorUtils.blueColor,
                                  //           )),
                                  //       SizedBox(
                                  //         width: 3.w,
                                  //       ),
                                  //       Expanded(
                                  //         child: Text(
                                  //           model.country_code! + model.phoneNo!,
                                  //           style: TextStyle(
                                  //               fontFamily:
                                  //               FontUtils.avertaSemiBold,
                                  //               fontSize: 2.5.t,
                                  //               color: ColorUtils.blueColor),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  Text(
                                    "Cellphone Number",
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
                                    child:
                                    IntlPhoneField(
                                      textAlignVertical: TextAlignVertical.center,

                                      //countryCodeTextColor: ColorUtils.darkBlue,
                                    //  controller: model.loginPhoneController,
                                      controller: TextEditingController(text: '${model.phoneNo!}'),
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

                                      //initialCountryCode: '${model.loginCountryCode}',
                                      initialValue: '${model.country_code}',
                                      onChanged: (phone) {

                                        // model.country_code! + model.phoneNo!;
                                        model.loginCountryCode = phone.countryCode ;
                                        model.loginPhoneController.text = phone.number;
                                        model.completeLoginPhoneNumber.text = phone.completeNumber;
                                        model.notifyListeners();
                                      },
                                    ),
                                  ),


                                  SizedBox(
                                    height: 2.h,
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
                                  if(model.editPressed == false)
                                    Container(
                                      height: 6.5.h,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: ColorUtils.blueColor),
                                          //color: ColorUtils.searchField,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          Container(
                                            child: SvgPicture.asset(
                                              ImageUtils.department,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Expanded(
                                            child: Text(
                                              model.getUserDepartment!,
                                              style: TextStyle(
                                                  fontFamily:
                                                  FontUtils.avertaSemiBold,
                                                  fontSize: 2.5.t,
                                                  color: ColorUtils.blueColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if(model.editPressed == true)
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
                                                  model.getUserDepartment!,
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
                                          value: model.editProfileSelectedDepart,
                                          onChanged: (value) {
                                            setState(() {
                                              model.editProfileSelectedDepart = value as String;
                                              model.getUserDepartment = model.editProfileSelectedDepart!;
                                              model.notifyListeners();
                                            });
                                            // model.enterDetailsDepartSelected = true;
                                            model.notifyListeners();
                                          },
                                        ),
                                      ),
                                    ),
                                  SizedBox(
                                    height: 2.h,
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
                                  if(model.editPressed == false)
                                    Container(
                                      height: 6.5.h,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: ColorUtils.blueColor),
                                          //color: ColorUtils.searchField,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          Container(
                                            child: SvgPicture.asset(
                                              ImageUtils.province,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Expanded(
                                            child: Text(
                                              model.getUserProvince!,
                                              style: TextStyle(
                                                  fontFamily:
                                                  FontUtils.avertaSemiBold,
                                                  fontSize: 2.5.t,
                                                  color: ColorUtils.blueColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if(model.editPressed == true)
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
                                                  model.getUserProvince!,
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
                                          value: model.editProfileSelectedProv,
                                          onChanged: (value) {
                                            setState(() {
                                              model.editProfileSelectedProv = value as String;
                                              model.getUserProvince = model.editProfileSelectedProv!;
                                              model.notifyListeners();
                                            });
                                            // model.enterDetailsProvinceSelected = true;
                                            // model.notifyListeners();
                                          },
                                          // buttonHeight: 40,
                                          // buttonWidth: 140,
                                          // itemHeight: 40,
                                          // itemWidth: 140,
                                        ),
                                      ),
                                    ),
                                  SizedBox(
                                    height: 2.h,
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
                                  if(model.editPressed == false)
                                    Container(
                                      height: 6.5.h,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: ColorUtils.blueColor),
                                          //color: ColorUtils.searchField,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          Container(
                                            child: SvgPicture.asset(
                                              ImageUtils.district,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Expanded(
                                            child: Text(
                                              model.getUserDistrict!,
                                              style: TextStyle(
                                                  fontFamily:
                                                  FontUtils.avertaSemiBold,
                                                  fontSize: 2.5.t,
                                                  color: ColorUtils.blueColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if(model.editPressed == true)
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
                                                  model.getUserDistrict!,
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
                                          value: model.editProfileSelectedDist,
                                          onChanged: (value) {
                                            setState(() {
                                              model.editProfileSelectedDist = value as String;
                                              model.getUserDistrict = model.editProfileSelectedDist!;
                                            });
                                            // model.enterDetailsDistrictSelected = true;
                                            // model.notifyListeners();
                                          },
                                          // buttonHeight: 40,
                                          // buttonWidth: 140,
                                          // itemHeight: 40,
                                          // itemWidth: 140,
                                        ),
                                      ),
                                    ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Container(
                                    height: 5.h,
                                    child: Center(
                                      child:  model.errorMessage != null
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
                                  if (model.editPressed == true)
                                    CustomButton(
                                      onButtonPressed: () {
                                        model.updatingTheUserDetails(context);
                                        model.editPressed = false;
                                        model.notifyListeners();
                                      },
                                      textValue: "Apply Changes",
                                      height: 6.5,
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
