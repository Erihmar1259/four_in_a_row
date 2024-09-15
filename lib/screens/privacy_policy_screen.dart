import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:four_in_a_row/languages/enum.dart';
import 'package:get/get.dart';

import '../../constants/color_const.dart';
import '../utils/global.dart';
import '../widgets/custom_text.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: "policy".tr,
          color: whiteColor,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          iconSize: 40,
          icon: Image.asset('assets/images/back_btn.webp'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,

      body: Container(

        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.webp'),
            fit: BoxFit.cover,

          ),
        ),
        child: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.only(top: 90.h,left: 10.w,right: 10.w),
              child: Text(
              Global.language==Language.zh.name? Global.policyCn:  Global.policy,
                style:  TextStyle(
                  color: whiteColor,
                  fontSize: 14.sp,
                  fontFamily: "Audiowide"
                ),
              ),
            )
        ),
      ),
    );
  }
}
