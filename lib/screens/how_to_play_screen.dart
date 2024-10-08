import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:four_in_a_row/constants/dimen_const.dart';
import 'package:four_in_a_row/constants/image_const.dart';
import 'package:get/get.dart';
import '../constants/color_const.dart';
import '../widgets/custom_text.dart';

class HowToPlayScreen extends StatelessWidget {
  const HowToPlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "how_to_play".tr,
          style: TextStyle(
            color: whiteColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            iconSize: 40,
            icon: Image.asset(closeImg),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: secondaryColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding:  EdgeInsets.only(top: 90.h, left: 10.w, right: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                 text: "welcome".tr,
                  fontSize: 14.sp,   color: yellowColor,            ),
                kSizedBoxH10,
                CustomText(text: "multi_player".tr, color: yellowColor,fontWeight: FontWeight.bold,fontSize: 16.sp,),
                kSizedBoxH5,
                Text(
                    "multiplayer_note".tr,
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 14.sp,
                      fontFamily: "Audiowide",
                    )),
                kSizedBoxH10,
                CustomText(text: "single_player".tr, color: yellowColor,fontWeight: FontWeight.bold,fontSize: 16.sp,),
                kSizedBoxH5,
                Text("singleplayer_note".tr,
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 14.sp,
                      fontFamily: "Audiowide",
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
