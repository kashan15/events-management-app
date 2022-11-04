import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:flutter/material.dart';

class Loader5 extends StatelessWidget {
  const Loader5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SizedBox(
          height: 10.i,width: 10.i,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(ColorUtils.blueColor),
          ),
        ),
      ),
    );
  }
}
