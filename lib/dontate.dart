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

class Donate extends StatefulWidget {
  const Donate({Key? key}) : super(key: key);

  @override
  _DonateState createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  @override
  Widget build(BuildContext context) {
    return
      ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model) {
        model.enterAmount.clear();
        // model.donateCardController.clear();
        // model.donateCardExpiryController.clear();
        // model.donateCardCvvController.clear();
        // model.enterHolderName.clear();
        //model.donation();
      },
      builder: (context, model, child) {
        return
          SafeArea(
          top: false,
          bottom: false,
          child: GestureDetector(
            onTap: () {
              model.onEnterCardNumberFocus();
              model.onEnterCardExpiryFocus();
              model.onEnterCardCvvFocus();
              model.onEnterCardHoldNameFocus();
              context.unFocus();
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 2.5.w, right: 4.w, top: 5.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: context.getPadding().top,
                        ),
                        Row(
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
                              "Donate",
                              style: TextStyle(
                                fontFamily: FontUtils.avertaBold,
                                fontSize: 3.t,
                                color: ColorUtils.darkText,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 4.w, right: 4.w,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          "Credit/Debit Card",
                          style: TextStyle(
                            fontFamily: FontUtils.avertaSemiBold,
                            fontSize: 2.5.t,
                            color: ColorUtils.darkText,
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Image.asset(ImageUtils.card,),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(left: 4.w, right: 4.w,),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enter Card Number",
                              style: TextStyle(
                                  fontFamily: FontUtils.avertaSemiBold,
                                  fontSize: 1.6.t,
                                  color: model.enterCardNumberFocus.hasFocus || model.donateCardController.text.length != 0 ? ColorUtils.blueColor : ColorUtils.icon_color
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
                                  border: Border.all(
                                    color: model.enterCardNumberFocus.hasFocus || model.donateCardController.text.length != 0 ? ColorUtils.blueColor : ColorUtils.icon_color,
                                  ),
                                  //color: ColorUtils.searchField,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5))),
                              child: TextField(
                                focusNode: model.enterCardNumberFocus,
                                //maxLines: 1,
                                style: TextStyle(
                                    fontFamily: FontUtils.avertaSemiBold,
                                    fontSize: 2.5.t,
                                    color: ColorUtils.blueColor
                                ),
                                controller: model.donateCardController,
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
                                keyboardType: TextInputType.number,
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
                                        "MM/YYYY",
                                        style: TextStyle(
                                            fontFamily: FontUtils.avertaSemiBold,
                                            fontSize: 1.6.t,
                                            color: model.enterCardExpiryFocus.hasFocus || model.donateCardExpiryController.text.length != 0 ? ColorUtils.blueColor : ColorUtils.icon_color
                                        ),
                                      ),
                                      SizedBox(height: 1.h,),
                                      Container(
                                        padding: EdgeInsets.only(left: 3.w),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.all(Radius.circular(6)),
                                          border: Border.all(
                                            color: model.enterCardExpiryFocus.hasFocus || model.donateCardExpiryController.text.length != 0 ? ColorUtils.blueColor : ColorUtils.icon_color,
                                          ),
                                        ),
                                        child: TextField(
                                          focusNode: model.enterCardExpiryFocus,
                                          //maxLines: 1,
                                          style: TextStyle(
                                              fontFamily: FontUtils.avertaSemiBold,
                                              fontSize: 2.5.t,
                                              color: ColorUtils.blueColor
                                          ),
                                          controller: model.donateCardExpiryController,
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
                                          keyboardType: TextInputType.number,
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
                                        "CVV",
                                        style: TextStyle(
                                            fontFamily: FontUtils.avertaSemiBold,
                                            fontSize: 1.6.t,
                                            color: model.enterCardCvvFocus.hasFocus || model.donateCardCvvController.text.length != 0 ? ColorUtils.blueColor : ColorUtils.icon_color
                                        ),
                                      ),
                                      SizedBox(height: 1.h,),
                                      Container(
                                        padding: EdgeInsets.only(left: 3.w),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.all(Radius.circular(6)),
                                          border: Border.all(
                                            color: model.enterCardCvvFocus.hasFocus || model.donateCardCvvController.text.length != 0 ? ColorUtils.blueColor : ColorUtils.icon_color,
                                          ),
                                        ),
                                        child: TextField(
                                          focusNode: model.enterCardCvvFocus,
                                          //maxLines: 1,
                                          style: TextStyle(
                                              fontFamily: FontUtils.avertaSemiBold,
                                              fontSize: 2.5.t,
                                              color: ColorUtils.blueColor
                                          ),
                                          controller: model.donateCardCvvController,
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
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 2.5.h,),
                            Text(
                              "Enter The Amount",
                              // "Card Holder Name",
                              style: TextStyle(
                                  fontFamily: FontUtils.avertaSemiBold,
                                  fontSize: 1.6.t,
                                  color: model.enterCardHolderFocus.hasFocus || model.enterAmount.text.length != 0 ? ColorUtils.blueColor : ColorUtils.icon_color
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
                                  border: Border.all(
                                    color: model.enterCardHolderFocus.hasFocus || model.enterAmount.text.length != 0 ? ColorUtils.blueColor : ColorUtils.icon_color,
                                  ),
                                  //color: ColorUtils.searchField,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5))),
                              child: TextField(
                                focusNode: model.enterCardHolderFocus,
                                //maxLines: 1,
                                style: TextStyle(

                                    fontFamily: FontUtils.avertaSemiBold,
                                    fontSize: 2.5.t,
                                    color: ColorUtils.blueColor
                                ),
                                controller: model.enterAmount,


                                // scrollController: _countryCodeController,

                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintStyle: TextStyle(
                                      fontSize: 2.5.t,
                                      //color: ColorUtils.searchHintColor
                                    )),
                                keyboardType: TextInputType.number,
                              ),
                            ),

                            SizedBox(height: 2.5.h,),
                            Text(
                              "Enter The Amount",

                              style: TextStyle(
                                  fontFamily: FontUtils.avertaSemiBold,
                                  fontSize: 1.6.t,
                                  color: model.enterCardHolderFocus.hasFocus || model.enterAmount.text.length != 0 ? ColorUtils.blueColor : ColorUtils.icon_color
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
                                  border: Border.all(
                                    color: model.enterCardHolderFocus.hasFocus || model.enterAmount.text.length != 0 ? ColorUtils.blueColor : ColorUtils.icon_color,
                                  ),
                                  //color: ColorUtils.searchField,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5))),
                              child: TextField(
                                focusNode: model.enterCardHolderFocus,
                                //maxLines: 1,
                                style: TextStyle(
                                    fontFamily: FontUtils.avertaSemiBold,
                                    fontSize: 2.5.t,
                                    color: ColorUtils.blueColor
                                ),
                                controller: model.enterAmount,
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
                                keyboardType: TextInputType.number,
                              ),
                            ),


                            SizedBox(height: 2.5.h,),
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
                            CustomButton(
                              onButtonPressed: () async{
                                // model.showCreateEventDialog = false;

                                model.donate(context);
                                // model.donation();

                                // model.createEvent(context);
                                // if(model.showCreateEventDialog == true){
                                //   showAlertDialog(context);
                                // }
                              },
                              textValue: "Donate",
                              height: 6.5,
                            ),
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
}
