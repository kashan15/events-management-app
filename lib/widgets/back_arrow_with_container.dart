import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BackArrowContainer extends StatelessWidget {
  const BackArrowContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandTapWidget(
        onTap: () {
          Navigator.pop(context);
        },
      tapPadding: EdgeInsets.all(25.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child: Padding(
            padding:EdgeInsets.symmetric(horizontal: 5.8.w,vertical: 2.4.h),
            child: SvgPicture.asset(ImageUtils.backCupertino),
          ),
        ),
    );
  }
}
