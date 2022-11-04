import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SizedBox(
          height: 5.i,width: 5.i,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white.withOpacity(.6)),
          ),
        ),
      ),
    );
  }
}
