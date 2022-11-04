import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:flutter/material.dart';

class ErrorCheck extends StatefulWidget {
  const ErrorCheck({Key? key}) : super(key: key);

  @override
  _ErrorCheckState createState() => _ErrorCheckState();
}

class _ErrorCheckState extends State<ErrorCheck> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 0.w,right: 1.w),
        //height: MediaQuery.of(context).size.height / 2.3,
        height: 38.5.h,
        //width: 70.w,
        child: Image.asset(ImageUtils.error,
        )

    );
  }
}
