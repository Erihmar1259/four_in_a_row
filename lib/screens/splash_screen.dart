import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:four_in_a_row/utils/screen_navigation_extension.dart';
import 'package:get/get.dart';

import '../constants/color_const.dart';
import '../constants/dimen_const.dart';
import '../widgets/custom_circle_loading.dart';
import '../widgets/custom_text.dart';
import 'intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2),(){
      context.navigateAndRemoveUntil(const IntroScreen(),false);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: whiteColor,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/bg.webp"),fit: BoxFit.cover)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text: "please_wait".tr,fontSize: 20.sp,color: whiteColor,),
                  kSizedBoxW10,
                  const CustomCircleLoading()
                ],
              ),
              kSizedBoxH30,
            ],
          ),
        )
    );
  }
}