import 'package:another_xlider/another_xlider.dart';
import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/dimensions.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/utils/size_config.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:democratic_unity/views/drawer.dart';
import 'package:democratic_unity/views/search/change_location.dart';
import 'package:democratic_unity/views/search/search_events.dart';
import 'package:democratic_unity/views/search/search_user_chat_screen.dart';
import 'package:democratic_unity/widgets/cupertino_back_arrow.dart';
import 'package:democratic_unity/widgets/custom_button.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stacked/stacked.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({Key? key}) : super(key: key);

  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {

  List searchedUsers = [
    {
      "image" : ImageUtils.searchedUser1,
      "name" : "John Milton",
    },
    {
      "image" : ImageUtils.searchedUser2,
      "name" : "John Cena",
    },
    {
      "image" : ImageUtils.searchedUser3,
      "name" : "John Andrew",
    },
    {
      "image" : ImageUtils.searchedUser4,
      "name" : "John Randolph",
    },
    {
      "image" : ImageUtils.searchedUser5,
      "name" : "John Kane",
    },
    {
      "image" : ImageUtils.searchedUser6,
      "name" : "John James",
    },
  ];

  List<String> location = [
    'Karachi, Pakistan',
    'Lahore, Pakistan',
    'Islamabad, Pakistan',
  ];

  String? selectedLocation;

  @override
  void initState() {
    // TODO: implement initState
    selectedLocation = 'Karachi, Pakistan';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model){
        //model.onSearchUserFocus();
        model.userSelected = true;
        model.eventSelected = false;
      },
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            context.unFocus();
          },
          child: SafeArea(
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

                    margin: EdgeInsets.only(top: 5.h,left: 4.w,right: 4.w),
                    child: Row(
                      children: [
                        CupertinoBackArrow(),
                        SizedBox(width: 4.w,),
                        Text("Search",
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
                  Padding(
                    padding: EdgeInsets.only(
                        left: 4.w, right: 4.w,),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          //color: ColorUtils.textFieldBg,
                          borderRadius: BorderRadius.all(
                            Radius.circular(6.0),
                          ),
                          border: Border.all(
                            color: model.searchUserFocus.hasFocus || model.searchUserController.text.length != 0 ? ColorUtils.blueColor : ColorUtils.icon_color,
                          )
                      ),
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 3,
                        ),
                        child: Row(
                          children: [
                            Container(
                              child: SvgPicture.asset(
                                ImageUtils.textFieldSearchIcon,
                                color: model.searchUserFocus.hasFocus || model.searchUserController.text.length != 0 ? ColorUtils.blueColor : ColorUtils.icon_color,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: SizeConfig.widthMultiplier *
                                        3,
                                    right:
                                    SizeConfig.widthMultiplier *
                                        3),
                                child: TextField(
                                  autofocus: true,
                                  onTap: () {},
                                  enabled: true,
                                  //readOnly: true,
                                  focusNode: model.searchUserFocus,
                                  controller: model.searchUserController,
                                  style: TextStyle(
                                    fontFamily: FontUtils.avertaDemoRegular,
                                    fontSize: 2.t,
                                    color: ColorUtils.blueColor,
                                  ),
                                  decoration: InputDecoration(
                                    // hintText:
                                    // "Search events, people etc",
                                    // hintStyle: TextStyle(
                                    //   fontFamily:
                                    //   FontUtils.avertaDemoRegular,
                                    //   color: ColorUtils.silverColor,
                                    //   fontSize:
                                    //   SizeConfig.textMultiplier *
                                    //       1.9,
                                    // ),
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding:
                                    EdgeInsets.symmetric(
                                        vertical: SizeConfig
                                            .heightMultiplier *
                                            2),
                                    // enabledBorder: OutlineInputBorder(
                                    //   borderSide: BorderSide(color:model.searchUserController.text.length !=0 ? ColorUtils.blueColor : ColorUtils.icon_color),
                                    //   borderRadius: BorderRadius.circular(6),
                                    // ),
                                    // focusedBorder: OutlineInputBorder(
                                    //   borderSide: BorderSide(color: ColorUtils.blueColor),
                                    //   borderRadius: BorderRadius.circular(
                                    //     6,
                                    //   ),
                                    // ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                filter(context, model);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorUtils.blueColor,
                                  borderRadius: BorderRadius.all(Radius.circular(6)),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(ImageUtils.filterIcon),
                                      ),
                                    ),
                                    Text("Filters",
                                      style: TextStyle(
                                        //fontFamily: FontUtils.avertaDemo,
                                          fontSize: 1.8.t,
                                          color: ColorUtils.filterTextColor
                                      ),
                                    ),
                                    SizedBox(width: 2.w,),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  Container(
                    height: 7.h,
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: ColorUtils.blueColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              //margin: EdgeInsets.symmetric(horizontal: 4.w),
                              child: Container(
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
                                    color: model.eventSelected == true ?  ColorUtils.blueColor : Colors.white,
                                    boxShadow: [
                                      if(model.eventSelected == true)
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
                                      // model.eventSelected = true;
                                      // model.userSelected = false;
                                      // model.notifyListeners();
                                      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:SearchEvents()));
                                    },
                                    child: Text(
                                      "Event",
                                      style: TextStyle(
                                        fontFamily: FontUtils.avertaSemiBold,
                                        fontSize: 1.8.t,
                                        color: model.eventSelected == true ?  Colors.white : ColorUtils.icon_color,
                                      ),
                                    ),
                                  ),
                                ),

                              ),
                            ),
                          ),
                          SizedBox(width: 2.w,),
                          Expanded(
                            child: Container(
                              //margin: EdgeInsets.symmetric(horizontal: 4.w),
                              child: Container(
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
                                    color: model.userSelected == true ?  ColorUtils.blueColor : Colors.white,
                                    boxShadow:[
                                      if(model.userSelected == true)
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
                                      //model.userSelected = true;
                                      //model.eventSelected = false;
                                      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:SearchEvents()));
                                      //model.notifyListeners();
                                    },
                                    child: Text(
                                      "User",
                                      style: TextStyle(
                                        fontFamily: FontUtils.avertaSemiBold,
                                        fontSize: 1.8.t,
                                        color: model.userSelected == true ?  Colors.white : ColorUtils.icon_color,
                                      ),
                                    ),
                                  ),
                                ),

                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding),
                      child: Container(
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:SearchUserChatScreen()));
                                },
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.asset(searchedUsers[index]["image"],
                                        width: 14.i,
                                        height: 14.i,
                                      ),
                                    ),
                                    SizedBox(width: 2.5.w,),
                                    Text(searchedUsers[index]["name"],
                                    style: TextStyle(
                                      fontFamily: FontUtils.avertaSemiBold,
                                      fontSize: 1.8.t,
                                      color: ColorUtils.darkText,
                                    ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 3.h,);
                            },
                            itemCount: searchedUsers.length
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
  void filter(context, MainViewModel mainModel) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(38),topRight: Radius.circular(38)),

        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return ViewModelBuilder.reactive(
            disposeViewModel: false,
            viewModelBuilder: () => locator<MainViewModel>(),
            builder: (context, model, child) {
              return Container(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: BouncingScrollPhysics(),
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 3.h, left: 4.w, right: 4.w),
                      child: Text(
                        "Filter",
                        style: TextStyle(
                          fontFamily: FontUtils.avertaBold,
                          fontSize: 2.5.t,
                          color: ColorUtils.darkText,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 4.w, right: 4.w),
                      child: Text(
                        "Location",
                        style: TextStyle(
                          fontFamily: FontUtils.avertaDemoRegular,
                          fontSize: 2.0.t,
                          color: ColorUtils.darkText,
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      // width: double.infinity,
                      // height: 6.5.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          border: Border.all(
                            //width: 2.0,
                            color: ColorUtils.blueColor,
                          )),
                      child: Container(
                        margin: EdgeInsets.only(
                          // left: 2.2.w,
                          // right: 2.3.w,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 10.w,
                                    height: 5.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(11.89)),
                                      //color: ColorUtils.blueColor,
                                    ),
                                  ),
                                  Container(
                                    width: 8.w,
                                    height: 4.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        ImageUtils.circularLocationPin,
                                        width: 10.i,
                                        height: 10.i,
                                        //fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                //isExpanded: true,
                                decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: ColorUtils.blueColor,
                                      //size: 6.i,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.transparent),
                                    )),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black,
                                  size: 0.0,
                                ),
                                onChanged: (newValue) {
                                  selectedLocation = newValue;
                                  setState(() {});
                                },
                                items: location.map((city) {
                                  return DropdownMenuItem(
                                    value: city,
                                    child: new Text(
                                      city,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: FontUtils.modernistRegular,
                                        fontSize: 2.3.t,
                                        color: ColorUtils.locationText,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                value: selectedLocation,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h,),
                    Container(
                      margin: EdgeInsets.only(left: 4.w, right: 4.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Select Range",
                            style: TextStyle(
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 2.0.t,
                              color: ColorUtils.darkText,
                            ),
                          ),
                          Text(
                            mainModel.lowValue! +"mi" + "-" + mainModel.highValue!+"mi",
                            style: TextStyle(
                                fontFamily: FontUtils.modernistRegular,
                                fontSize: 2.0.t,
                                color: ColorUtils.blueColor
                            ),
                          ),
                        ],
                      ),
                    ),
                    FlutterSlider(
                      onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                        handlerIndex = 0;
                        mainModel.lowerValue = lowerValue;
                        mainModel.upperValue = upperValue;
                        // print(_upperValue);
                        // print(_lowerValue);
                        setState(() {

                        });
                      },
                      trackBar: FlutterSliderTrackBar(
                        activeTrackBar: BoxDecoration(
                          color: ColorUtils.blueColor,
                        ),
                        inactiveTrackBar: BoxDecoration(
                          color: ColorUtils.blueColor.withOpacity(0.2),
                        ),
                      ),
                      // handlerHeight: 0.0,
                      // handlerWidth: 0.0,
                      handler: FlutterSliderHandler(
                        decoration: BoxDecoration(
                          // image: DecorationImage(
                          //   image:AssetImage(ImageUtils.doubleArrow),
                          // ),
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(9)),
                            border: Border.all(color: ColorUtils.blueColor)),
                        child: SvgPicture.asset(
                          ImageUtils.doubleArrow,
                          height: 2.5.i,
                          width: 2.5.i,
                        ),
                      ),
                      rightHandler: FlutterSliderHandler(
                        decoration: BoxDecoration(
                          // image: DecorationImage(
                          //   image:AssetImage(ImageUtils.doubleArrow),
                          // ),
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(9)),
                            border: Border.all(color: ColorUtils.blueColor)),
                        child: SvgPicture.asset(
                          ImageUtils.doubleArrow,
                          height: 2.5.i,
                          width: 2.5.i,
                        ),
                      ),
                      values: [mainModel.lowerValue, mainModel.upperValue],
                      rangeSlider: true,
                      max: 500,
                      min: 0,
                      onDragging: (handlerIndex, lowerValue, upperValue) {
                        mainModel.lowerValue = lowerValue;
                        mainModel.upperValue = upperValue;
                        mainModel.lowValue = mainModel.lowerValue.toStringAsFixed(0);
                        mainModel.highValue =  mainModel.upperValue.toStringAsFixed(0);
                        mainModel.notifyListeners();
                      },
                    ),
                    SizedBox(height: 4.h,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 12.w),
                      child: CustomButton(
                        textValue: "Apply",
                        onButtonPressed: (){
                          Navigator.pop(context);
                        },
                        height: 6.5,
                      ),
                    ),
                    SizedBox(height: 4.h,),
                  ],
                ),
              );
            },
          );
        });
  }
}
