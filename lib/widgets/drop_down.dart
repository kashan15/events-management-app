import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

class DropDownWidget extends StatefulWidget {
  String svgPicture;
  List places;
  String selectedValue;

  DropDownWidget(
      {required this.svgPicture,
      required this.places,
      required this.selectedValue,
      Key? key})
      : super(key: key);

  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.nonReactive(
        viewModelBuilder: () => locator<MainViewModel>(),
        disposeViewModel: false,
        builder: (context, model, child) {
          return Container(
            padding: EdgeInsets.only(right: 2.3.w),
            width: double.infinity,
            height: 6.5.h,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
                border: Border.all(
                  //width: 2.0,
                  color: ColorUtils.blueColor,
                )),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                itemPadding: EdgeInsets.zero,
                dropdownMaxHeight: 20.h,
                isExpanded: true,
                hint: Padding(
                  padding: EdgeInsets.only(
                    left: 4.w,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(widget.svgPicture),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        "any department",
                        style: TextStyle(
                          fontFamily: FontUtils.avertaDemoRegular,
                          fontSize: 2.3.t,
                          color: ColorUtils.blueColor,
                        ),
                      ),
                    ],
                  ),
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black,
                  size: 6.i,
                ),
                items: widget.places
                    .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 4.w,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(widget.svgPicture),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          item,
                          style: TextStyle(
                            fontFamily: FontUtils.avertaDemoRegular,
                            fontSize: 2.3.t,
                            color: ColorUtils.blueColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
                    .toList(),
                value: widget.selectedValue,
                onChanged: (value) {
                  setState(() {
                    widget.selectedValue = value as String;
                    model.notifyListeners();
                  });
                },
                // buttonHeight: 40,
                // buttonWidth: 140,
                // itemHeight: 40,
                // itemWidth: 140,
              ),
            ),
          );
        },
    );
  }
}
