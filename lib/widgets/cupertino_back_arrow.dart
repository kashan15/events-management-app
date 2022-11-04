import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CupertinoBackArrow extends StatelessWidget {
  const CupertinoBackArrow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // child: SvgPicture.asset(ImageUtils.backArrow,
      // ),
      child: IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          icon: SvgPicture.asset(ImageUtils.backCupertino,),
          color: ColorUtils.blueColor,
          onPressed: (){
            Navigator.pop(context);
          }
      ),
    );
  }
}
