import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:flutter/material.dart';

class Loader3 extends StatelessWidget {
  const Loader3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SizedBox(
          height: 8.i,width: 8.i,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(ColorUtils.blueColor),
          ),
        ),
      ),
    );
  }
}
