import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/utils/size_config.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/widgets/custom_button.dart';
import 'package:democratic_unity/widgets/custom_switch.dart';
import 'package:democratic_unity/widgets/loader.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {

  ScrollController controller = ScrollController();

  // DateTime _dateTime = DateTime.now();
  // String? openingTimeFrom;
  // String? openingTimeTo;

  // @override
  // void didChangeDependencies() {
  //   openingTimeFrom = TimeOfDay.now().format(context);
  //   openingTimeTo = TimeOfDay.now().format(context);
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  // }

  // @override
  // void initState() {
  //   selectedEventType = "Gathering";
  //   super.initState();
  // }

  // List<String> eventTypes = [
  //   "Gathering",
  //   "Fundraising",
  //   "Conferences",
  //   "Sponsorships",
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
  // String? selectedEventType;
  // String? selectDepart;
  // String? selectProvince;
  // String? selectDistrict;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model){
        model.selectedEventType =
        "Gathering";
        model.didChangeDependencies(context);
        model.selectedDepart = null;
        model.selectedProv = null;
        model.selectedDist = null;
        model.createEventLocation.clear();
        model.regionalDepartment();
        model.regionalProvinces();
        model.regionalDistricts();
      },
      builder: (context, model, child) {
        //_scrollController.scrollTo(index: 2, duration: Duration(seconds: 1));
        return SafeArea(
          top: false,
          bottom: false,
          child: GestureDetector(
            onTap:(){
              context.unFocus();
              model.placeSelected = false;
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  SizedBox(height: context.getPadding().top,),
                  Container(
                    padding: EdgeInsets.only(
                        left: 2.5.w,
                        right: 4.w,
                        top: 5.h
                    ),
                    child: Row(
                      children: [
                        IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            icon: SvgPicture.asset(ImageUtils.backCupertino,
                              color: ColorUtils.darkText,
                            ),
                            onPressed: (){
                              Navigator.pop(context);
                            }
                        ),
                        SizedBox(width: 4.w,),
                        Text("Create Event",
                          style: TextStyle(
                            fontFamily: FontUtils.avertaBold,
                            fontSize: 3.t,
                            color: ColorUtils.darkText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: controller,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 4.w,
                            right: 4.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 3.3.h,),
                            Text(
                              "Event Type",
                              style: TextStyle(
                                fontFamily: FontUtils.avertaSemiBold,
                                fontSize: 1.5.t,
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
                                    child: Text(
                                      "Choose Event",
                                      style: TextStyle(
                                          fontFamily:
                                          FontUtils.avertaSemiBold,
                                          fontSize: 2.5.t,
                                          color: ColorUtils.blueColor),
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.black,
                                    size: 6.i,
                                  ),
                                  items: model.eventTypes
                                      .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: 4.w,
                                      ),
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                            fontFamily: FontUtils
                                                .avertaSemiBold,
                                            fontSize: 2.5.t,
                                            color: ColorUtils
                                                .blueColor),
                                      ),
                                    ),
                                  ))
                                      .toList(),
                                  value: model.selectedEvent,
                                  onChanged: (value) {
                                    setState(() {
                                      model.selectedEvent = value as String;
                                    });
                                    model.eventTypeSelected = true;
                                    model.notifyListeners();
                                  },
                                  // buttonHeight: 40,
                                  // buttonWidth: 140,
                                  // itemHeight: 40,
                                  // itemWidth: 140,
                                ),
                              ),
                            ),
                            SizedBox(height: 2.5.h,),
                            Text(
                              "Event Name",
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
                              // height: 6.5.h,
                              // width: 10.w,
                              //margin: const EdgeInsets.all(10.0),
                              padding: EdgeInsets.only(left: 3.w),
                              decoration: BoxDecoration(
                                  border: Border.all(color: ColorUtils.blueColor),
                                  //color: ColorUtils.searchField,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5))),
                              child: TextField(
                                //maxLines: 1,
                                style: TextStyle(
                                    fontFamily: FontUtils.avertaSemiBold,
                                    fontSize: 2.5.t,
                                    color: ColorUtils.blueColor
                                ),
                                controller: model.createEventName,
                                //scrollController: _countryCodeController,
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintStyle: TextStyle(
                                      fontSize: 2.5.t,
                                      //color: ColorUtils.searchHintColor
                                    )),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            SizedBox(height: 2.5.h,),
                            Text(
                              "Event Description",
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
                              // height: 6.5.h,
                              // width: 10.w,
                              //margin: const EdgeInsets.all(10.0),
                              padding: EdgeInsets.only(left: 3.w),
                              decoration: BoxDecoration(
                                  border: Border.all(color: ColorUtils.blueColor),
                                  //color: ColorUtils.searchField,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5))),
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                //maxLines: 1,
                                style: TextStyle(
                                    fontFamily: FontUtils.avertaSemiBold,
                                    fontSize: 2.5.t,
                                    color: ColorUtils.blueColor
                                ),
                                controller: model.createEventDescription,
                                //scrollController: _countryCodeController,
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintStyle: TextStyle(
                                      fontSize: 2.5.t,
                                      //color: ColorUtils.searchHintColor
                                    )),
                              ),
                            ),

                            SizedBox(height: 2.5.h,),
                            Text(
                              "Event Banner",
                              style: TextStyle(
                                fontFamily: FontUtils.avertaSemiBold,
                                fontSize: 1.6.t,
                                color: ColorUtils.blueColor,
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            GestureDetector(
                              onTap: (){
                                model.createEventGetImage();
                              },
                              child: Container(
                                width: double.infinity,
                                height: 15.h,
                                decoration: BoxDecoration(
                                    border: Border.all(color: ColorUtils.icon_color),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5))),
                                child: model.bannerImageSelected == false ?
                                  Icon(Icons.add,
                                    color: ColorUtils.icon_color,
                                  ) :
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.file(model.createEventImage!,
                                        fit: BoxFit.cover,
                                    ),
                                    ),
                              ),
                            ),
                            // Row(
                            //   mainAxisSize: MainAxisSize.min,
                            //   children: [
                            //     GestureDetector(
                            //       onTap: (){
                            //         model.createEventGetImage();
                            //       },
                            //       child: Container(
                            //         width: 22.w,
                            //         height: 10.h,
                            //         decoration: BoxDecoration(
                            //             border: Border.all(color: ColorUtils.icon_color),
                            //             borderRadius: BorderRadius.all(
                            //                 Radius.circular(5))),
                            //         child: Padding(
                            //           padding: const EdgeInsets.all(16.0),
                            //           child: Icon(Icons.add,
                            //             color: ColorUtils.icon_color,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     SizedBox(width: 3.w,),
                            //     Expanded(
                            //       child: Container(
                            //         height: 12.h,
                            //         child: ListView.separated(
                            //             physics: BouncingScrollPhysics(),
                            //             scrollDirection: Axis.horizontal,
                            //             padding: EdgeInsets.zero,
                            //             shrinkWrap: true,
                            //             itemBuilder: (context, index) {
                            //               return Container(
                            //                 child: Stack(
                            //                   alignment: Alignment.center,
                            //                   children: [
                            //                     Container(
                            //                       //color: Colors.amber,
                            //                       width: 22.w,
                            //                       height: 10.h,
                            //                       //padding: EdgeInsets.all(12.0),
                            //                       child: ClipRRect(
                            //                         borderRadius: BorderRadius.circular(6),
                            //                         child: Image.file(model.createEventImages[index],
                            //                           fit: BoxFit.cover,
                            //                         ),
                            //                       ),
                            //                     ),
                            //                     Positioned(
                            //                       right: 0.w,
                            //                       bottom: 0.h,
                            //                       child: GestureDetector(
                            //                         onTap: (){
                            //                           model.createEventImages.removeAt(index);
                            //                           model.notifyListeners();
                            //                         },
                            //                         child: SvgPicture.asset(ImageUtils.imageCross,
                            //                           //size: 5.5.i,
                            //                           //color: ColorUtils.greenColor,
                            //                         ),
                            //                       ),
                            //                     )
                            //                   ],
                            //                 ),
                            //               );
                            //             },
                            //             separatorBuilder: (context, index) {
                            //               return SizedBox(width: 1.w,);
                            //             },
                            //             itemCount: model.createEventImages.length
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),

                            //if(model.selectedEventType == "Fundraising")
                            //   Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       SizedBox(height: 2.5.h,),
                            //       Text(
                            //         "Enter Amount",
                            //         style: TextStyle(
                            //           fontFamily: FontUtils.avertaSemiBold,
                            //           fontSize: 1.6.t,
                            //           color: ColorUtils.blueColor,
                            //         ),
                            //       ),
                            //       SizedBox(
                            //         height: 1.h,
                            //       ),
                            //       Row(
                            //         children: [
                            //           Expanded(
                            //             child: Container(
                            //               // height: 6.5.h,
                            //               // width: 10.w,
                            //               //margin: const EdgeInsets.all(10.0),
                            //               //padding: EdgeInsets.symmetric(vertical: SizeConfig.widthMultiplier * 4, horizontal: SizeConfig.heightMultiplier * 2.5),
                            //               decoration: BoxDecoration(
                            //                   border: Border.all(color: ColorUtils.blueColor),
                            //                   //color: ColorUtils.searchField,
                            //                   borderRadius: BorderRadius.all(
                            //                       Radius.circular(5))),
                            //               child: Column(children: <Widget>[
                            //                 Row(
                            //                   mainAxisAlignment:
                            //                   MainAxisAlignment.start,
                            //                   children: <Widget>[
                            //                     SizedBox(
                            //                       width: 4.w,
                            //                     ),
                            //                     Container(
                            //                       child: SvgPicture.asset(ImageUtils.cashIcon,
                            //                         width: 6.i,
                            //                         height: 6.i,
                            //                       ),
                            //                       //ImageIcon(AssetImage("assets/icon_Atr.svg" ),color: ColorUtils.btn_blue,)
                            //                     ),
                            //                     SizedBox(width: 3.w,),
                            //                     Expanded(
                            //                       child: TextField(
                            //                         style: TextStyle(
                            //                             fontFamily: FontUtils.avertaSemiBold,
                            //                             fontSize: 2.5.t,
                            //                             color: ColorUtils.blueColor
                            //                         ),
                            //                         controller: model.createEventCashController,
                            //                         //scrollController: _countryCodeController,
                            //                         decoration: InputDecoration(
                            //                             focusedBorder: InputBorder.none,
                            //                             enabledBorder: InputBorder.none,
                            //                             errorBorder: InputBorder.none,
                            //                             disabledBorder: InputBorder.none,
                            //                             hintStyle: TextStyle(
                            //                               fontSize: 2.5.t,
                            //                               //color: ColorUtils.searchHintColor
                            //                             )),
                            //                         keyboardType: TextInputType.number,
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ]),
                            //             ),
                            //           ),
                            //           // SizedBox(
                            //           //   width: 1.w,
                            //           // ),
                            //         ],
                            //       ),
                            //     ],
                            //   ),

                            //if(model.selectedEventType != "Fundraising")
                            SizedBox(height: 2.5.h,),
                            Text(
                              "Volunteer",
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
                              // height: 6.5.h,
                              // width: 10.w,
                              //margin: const EdgeInsets.all(10.0),
                              //padding: EdgeInsets.symmetric(vertical: SizeConfig.widthMultiplier * 4, horizontal: SizeConfig.heightMultiplier * 2.5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: ColorUtils.blueColor),
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
                                    Expanded(
                                      child: Text(
                                        "Allowed",
                                        style: TextStyle(
                                          fontFamily: FontUtils.avertaSemiBold,
                                          fontSize: 1.6.t,
                                          color: ColorUtils.blueColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 3.w,),
                                    CustomSwitch(
                                      activeTrackColor: ColorUtils.blueColor,
                                      activeColor: ColorUtils.thumbColor,
                                      value: model.volunteerEvent,
                                      onChanged: (value) {
                                        setState(() {
                                          model.volunteerEvent = value;
                                        });
                                        if(model.volunteerEvent == false){
                                          model.volunteerValue = 0;
                                          model.notifyListeners();
                                        }
                                        else if(model.volunteerEvent == true){
                                          model.volunteerValue = 1;
                                          model.notifyListeners();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ]),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 2.5.h,),
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
                                              "any department",
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
                                      value: model.eventSelectedDepart,
                                      onChanged: (value) {
                                        setState(() {
                                          model.eventSelectedDepart = value as String;
                                        });
                                        model.eventDepartSelected = true;
                                        model.notifyListeners();
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


                            //if(model.selectedEventType != "Fundraising")
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 2.5.h,),
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
                                              "any province",
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
                                      value: model.eventSelectedProv,
                                      onChanged: (value) {
                                        setState(() {
                                          model.eventSelectedProv = value as String;
                                        });
                                        model.eventProvinceSelected = true;
                                        model.notifyListeners();
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
                                          "any district",
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
                                  value: model.eventSelectedDist,
                                  onChanged: (value) {
                                    setState(() {
                                      model.eventSelectedDist = value as String;
                                    });
                                    model.eventDistrictSelected = true;
                                    model.notifyListeners();
                                  },
                                  // buttonHeight: 40,
                                  // buttonWidth: 140,
                                  // itemHeight: 40,
                                  // itemWidth: 140,
                                ),
                              ),
                            ),
                            // if(model.selectedEventType != "Fundraising")
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     SizedBox(height: 2.5.h,),
                            //     Text(
                            //       "District",
                            //       style: TextStyle(
                            //         fontFamily: FontUtils.avertaSemiBold,
                            //         fontSize: 1.6.t,
                            //         color: ColorUtils.blueColor,
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       height: 1.h,
                            //     ),
                            //     Container(
                            //       // width: double.infinity,
                            //       // height: 6.5.h,
                            //       decoration: BoxDecoration(
                            //           shape: BoxShape.rectangle,
                            //           borderRadius:
                            //           BorderRadius.all(Radius.circular(6.0)),
                            //           border: Border.all(
                            //             //width: 2.0,
                            //             color: ColorUtils.blueColor,
                            //           )),
                            //       child: Container(
                            //         margin: EdgeInsets.only(
                            //           left: 3.w,
                            //           right: 3.w,
                            //         ),
                            //         child: DropdownButtonFormField<String>(
                            //           isExpanded: true,
                            //           decoration: InputDecoration(
                            //               hintText: "any district",
                            //               hintStyle: TextStyle(
                            //                 fontFamily: FontUtils.avertaSemiBold,
                            //                 fontSize: 2.3.t,
                            //                 color: ColorUtils.blueColor,
                            //               ),
                            //               enabledBorder: UnderlineInputBorder(
                            //                 borderSide:
                            //                 BorderSide(color: Colors.transparent),
                            //               )),
                            //           icon: Icon(
                            //             Icons.keyboard_arrow_down,
                            //             color: Colors.black,
                            //             size: 6.i,
                            //           ),
                            //           onChanged: (newValue) {
                            //             model.selectDistrict = newValue;
                            //             model.eventDistrictSelected = true;
                            //             model.notifyListeners();
                            //           },
                            //           items: model.district.map((district) {
                            //             return DropdownMenuItem(
                            //               value: district,
                            //               child: new Text(
                            //                 district,
                            //                 style: TextStyle(
                            //                   fontFamily: FontUtils.avertaSemiBold,
                            //                   fontSize: 2.3.t,
                            //                   color: ColorUtils.blueColor,
                            //                 ),
                            //               ),
                            //             );
                            //           }).toList(),
                            //           value: model.selectDistrict,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),

                            SizedBox(height: 2.5.h,),
                            Text(
                              "Event Location",
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
                                        border: Border.all(color: ColorUtils.blueColor),
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
                                            child: SvgPicture.asset(ImageUtils.eventLocation,
                                              width: 6.i,
                                              height: 6.i,
                                            ),
                                            //ImageIcon(AssetImage("assets/icon_Atr.svg" ),color: ColorUtils.btn_blue,)
                                          ),
                                          SizedBox(width: 3.w,),
                                          Expanded(
                                            child: TextField(
                                              onChanged: (value) {
                                                model.eventLocation();
                                                model.placeSelected = true;
                                                controller.jumpTo(600.0);
                                                //_scrollController.scrollTo(index: 2, duration: Duration(seconds: 1));
                                                model.notifyListeners();
                                              },
                                              style: TextStyle(
                                                  fontFamily: FontUtils.avertaSemiBold,
                                                  fontSize: 2.5.t,
                                                  color: ColorUtils.blueColor
                                              ),
                                              controller: model.createEventLocation,
                                              //scrollController: _countryCodeController,
                                              decoration: InputDecoration(
                                                  focusedBorder: InputBorder.none,
                                                  enabledBorder: InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder: InputBorder.none,
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

                            if(model.placeSelected == true && model.createEventLocation.text.length != 0)
                            Container(
                              margin: EdgeInsets.only(top: 1.5.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5)),
                                  border: Border.all(color: ColorUtils.blueColor),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.black.withOpacity(0.05),
                                //     spreadRadius: 0,
                                //     blurRadius: 0,
                                //     offset: Offset(0, 3), // changes position of shadow
                                //   ),
                                // ],
                              ),
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: model.places.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: (){
                                      model.createEventLocation.text = model.places[index];
                                      model.placeSelected = false;
                                      context.unFocus();
                                      model.notifyListeners();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 2.h),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            // height: 6.5.h,
                                            // width: 10.w,
                                            //margin: const EdgeInsets.all(10.0),
                                            padding: EdgeInsets.only(left: 3.w),
                                            decoration: BoxDecoration(
                                                //border: Border.all(color: ColorUtils.blueColor),
                                                //color: ColorUtils.searchField,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                model.places[index],
                                                style: TextStyle(
                                                    fontFamily: FontUtils.avertaDemoRegular,
                                                    fontSize: 1.8.t,
                                                    color: Colors.black
                                                ),
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            color: Colors.grey,
                                            height: 2.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                  //   ListTile(
                                  //   title: Text(model.places[index]),
                                  // );
                                },
                              ),
                            ),

                            SizedBox(height: 2.5.h,),
                            Text(
                              "Event Date",
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
                              onTap: (){
                                model.selectDate(context);
                                model.eventDateSelected = true;
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
                                      border: Border.all(color: ColorUtils.blueColor)
                                  ),
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
                                              left: 4.w,
                                              right: 4.w
                                          ),
                                          child:
                                          Text(
                                            model.selectedDate == null
                                                ? "Date of Birth"
                                                : DateFormat('yyyy-MM-dd')
                                                .format(model.selectedDate),
                                            style: model.selectedDate == null ? TextStyle(
                                              color: ColorUtils.darkBlue,
                                              fontFamily: FontUtils.avertaSemiBold,
                                              fontSize: 2.5.t,
                                            )
                                                :
                                            TextStyle(
                                              color: ColorUtils.blueColor,
                                              fontFamily: FontUtils.avertaSemiBold,
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
                                  )
                              ),
                            ),

                            SizedBox(height: 2.5.h,),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "From",
                                        style: TextStyle(
                                          fontFamily: FontUtils.avertaSemiBold,
                                          fontSize: 1.6.t,
                                          color: ColorUtils.blueColor,
                                        ),
                                      ),
                                      SizedBox(height: 1.h,),
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.all(Radius.circular(6)),
                                          border: Border.all(color: ColorUtils.blueColor),
                                        ),
                                        child: GestureDetector(
                                          onTap: (){
                                            showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                                initialEntryMode: TimePickerEntryMode.dial,
                                                confirmText: "CONFIRM",
                                                cancelText: "NOT NOW",
                                                helpText: "BOOKING TIME"
                                            ).then((value){
                                              model.openingTimeFrom = value!.format(context);
                                              model.notifyListeners();
                                            });
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(vertical: 1.2.h,),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(ImageUtils.timeClock),
                                                SizedBox(width: 4.w,),
                                                Text(
                                                  model.openingTimeFrom!,
                                                    //DateFormat("HH:mm:ss").parse(model.openingTimeFrom!).toString(),
                                                style: TextStyle(
                                                  fontFamily: FontUtils.avertaSemiBold,
                                                  fontSize: 2.t,
                                                  color: ColorUtils.darkBlue,
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
                                SizedBox(width: 2.h,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "To",
                                        style: TextStyle(
                                          fontFamily: FontUtils.avertaSemiBold,
                                          fontSize: 1.6.t,
                                          color: ColorUtils.blueColor,
                                        ),
                                      ),
                                      SizedBox(height: 1.h,),
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.all(Radius.circular(6)),
                                          border: Border.all(color: ColorUtils.blueColor),
                                        ),
                                        child: GestureDetector(
                                          onTap: (){
                                            showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                                initialEntryMode: TimePickerEntryMode.dial,
                                                confirmText: "CONFIRM",
                                                cancelText: "NOT NOW",
                                                helpText: "BOOKING TIME"
                                            ).then((value){
                                              model.openingTimeTo = value!.format(context);
                                              model.notifyListeners();
                                            });
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(vertical: 1.2.h,),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(ImageUtils.timeClock),
                                                SizedBox(width: 4.w,),
                                                Text(
                                                  model.openingTimeTo!,
                                                  //DateFormat("HH:mm:ss").parse(model.openingTimeTo!).toString(),
                                                  style: TextStyle(
                                                    fontFamily: FontUtils.avertaSemiBold,
                                                    fontSize: 2.t,
                                                    color: ColorUtils.darkBlue,
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
                              ],
                            ),
                            //SizedBox(height: 5.h,),
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
                                  onPressed: () async{
                                     // model.showCreateEventDialog = false;
                                     model.createEvent(context);
                                    // if(model.showCreateEventDialog == true){
                                    // showAlertDialog(context);
                                    // }
                                  },

                                  child: model.creatingEvent ?Loader():
                                  Text(
                                    "Continue",
                                    style: TextStyle(
                                        fontFamily: FontUtils.avertaSemiBold,
                                        fontSize: 2.2.t,
                                        color: Colors.white),
                                  ) ,
                                ),
                              ),
                            ),
                            // CustomButton(
                            //   onButtonPressed: () async{
                            //     //model.showCreateEventDialog = false;
                            //     model.createEvent(context);
                            //     // if(model.showCreateEventDialog == true){
                            //     //   showAlertDialog(context);
                            //     // }
                            //   },
                            //   textValue: "Create Event",
                            //   height: 6.5,
                            // ),
                            SizedBox(height: 2.h,),
                          ],
                        ),
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
// showAlertDialog(BuildContext context){
//     'set up the AlertDialog';
//     AlertDialog alert = AlertDialog(
//       contentPadding: EdgeInsets.only(bottom: 3.h, top: 2.h),
//       insetPadding: EdgeInsets.symmetric(horizontal: 4.w),
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(3.i))),
//       title: Container(
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: ColorUtils.blueColor,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black,
//                 blurRadius: 4.0,
//                 spreadRadius: 0.0,
//                 offset: Offset(0, 4),
//               ),
//           ],
//         ),
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: SvgPicture.asset(ImageUtils.alertDialogCheck),
//           )
//       ),
//       content: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit sed do eiusmod tempor. ",
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           fontFamily: FontUtils.avertaSemiBold,
//           fontSize: 2.2.t,
//           color: ColorUtils.darkText,
//           height: 0.16.h,
//         ),
//       ),
//     );
//
//    'show the dialog';
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
}
