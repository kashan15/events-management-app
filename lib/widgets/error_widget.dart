import 'package:democratic_unity/modules/navigation_service.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/widgets/dialog_button.dart';
import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  final String error;
  const MyErrorWidget({Key? key,required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3.i),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 3.h,),
          Icon(Icons.error_outlined,color: Colors.black,size : 10.i),
          SizedBox(height: 1.5.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Text(error,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black
              ),
            ),
          ),
          SizedBox(height: 3.h,),
          DialogButton(
            buttonText: "OK",
            buttonBackground: ColorUtils.blueColor,
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            buttonPress: () {
              NavigationService().back();
            },
          ),
          SizedBox(height:3.h,)
        ],
      ),
    );
  }
}