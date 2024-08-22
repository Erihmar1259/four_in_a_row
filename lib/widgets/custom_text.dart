import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/color_const.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
        required this.text,
        this.color,
        this.fontSize,
        this.fontWeight,
        this.textAlign,
        this.textOverflow,
        this.maxLines,
        this.fontFamily, this.letterSpace});
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final String? fontFamily;
  final double? letterSpace;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign ?? TextAlign.left,
        maxLines: maxLines ?? 1,
        style: TextStyle(
          fontStyle: FontStyle.italic,
          //textStyle: Theme.of(context).textTheme.displaySmall,
          // letterSpacing:letterSpace ,
           fontSize: fontSize ?? 12.sp,
           color: color ?? secondaryColor,
           fontWeight: fontWeight ?? FontWeight.normal,
          fontFamily: fontFamily ?? 'Audiowide',
          // overflow: textOverflow ?? TextOverflow.ellipsis,
        ));
  }
}
