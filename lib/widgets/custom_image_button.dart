import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/color_const.dart';
import '../constants/image_const.dart';
import 'custom_text.dart';

class CustomImageButton extends StatelessWidget {
  const CustomImageButton({super.key, required this.btnLabel, required this.onTapFun});
final String btnLabel;
final Function() onTapFun;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTapFun,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 80.h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(gameBtn),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Center(child: CustomText(text: btnLabel,fontSize:18.sp,color: whiteColor,)),
      ),
    );
  }
}
