import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:flutter/material.dart';

class ButtonWithoutBg extends StatelessWidget {
  final VoidCallback? onButtonPressed;
  final String? textValue;
  final double? height;

  const ButtonWithoutBg({this.onButtonPressed, this.textValue, this.height, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        width: MediaQuery.of(context).size.width / 1,
        height: height!.h,
        //margin: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: ColorUtils.blueColor),
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
          elevation: 0.0,
          color: Colors.white,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          onPressed: onButtonPressed,
          child: Text(
            textValue!,
            style: TextStyle(
                fontFamily: FontUtils.avertaSemiBold,
                fontSize: 2.2.t,
                color: ColorUtils.blueColor),
          ),
        ),
      ),

      // MaterialButton(
      //     onPressed: onButtonPressed,
      //   color: ColorUtils.greenColor,
      //   minWidth: MediaQuery.of(context).size.width /1,
      //   height: 7.h,
      //   textColor: Colors.white,
      //   shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(6.0),
      //   ),
      //   // style: ElevatedButton.styleFrom(
      //   //     primary: ColorUtils.greenColor,
      //   //     shadowColor: ColorUtils.greenColor.withOpacity(0.25),
      //   //     shape: RoundedRectangleBorder(
      //   //         borderRadius: BorderRadius.circular(10.0)),
      //   //     minimumSize: Size(MediaQuery.of(context).size.width /1, 7.h),
      //   //   ),
      //     child: Text(
      //       textValue!,
      //       textAlign: TextAlign.center,
      //       style: TextStyle(
      //         fontFamily: FontUtils.avertaSemiBold,
      //         fontSize: 2.2.t,
      //         color: Colors.white,
      //       ),
      //     ),
      // ),
    );
  }
}