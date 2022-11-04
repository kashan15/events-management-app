import 'dart:io';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/widgets/back_arrow_with_container.dart';
import 'package:democratic_unity/widgets/cupertino_back_arrow.dart';
import 'package:flutter/material.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1,
              child: Image.file(File(imagePath)),
          ),
          Container(
            margin: EdgeInsets.only(left: 4.w,top: 6.h),
            child: CupertinoBackArrow(),
          ),
        ],
      ),
    );
  }
}