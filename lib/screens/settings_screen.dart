import 'package:animated_text_lerp/animated_text_lerp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:four_in_a_row/screens/privacy_policy_screen.dart';
import 'package:four_in_a_row/utils/screen_navigation_extension.dart';
import 'package:get/get.dart';
import '../../constants/color_const.dart';
import '../../constants/dimen_const.dart';
import '../../widgets/custom_text.dart';
import '../constants/image_const.dart';
import '../constants/string_const.dart';
import '../controller/game_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
final controller=Get.put(GameController());


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          iconSize: 40.sp,
          icon: Image.asset('assets/images/back_btn.webp'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: CustomText(
          text: "Settings",
          color: whiteColor,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),


      ),
      extendBodyBehindAppBar: true,

      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.webp'),
            fit: BoxFit.cover,

          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 100.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                child: CustomText(text: "Score Board (Two Players Mode)",color: whiteColor, fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
              //   padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              //   width: MediaQuery.of(context).size.width,
              //   height: 60.h,
              //   decoration: BoxDecoration(
              //     color: mainColor.withOpacity(0.3),
              //     borderRadius: BorderRadius.circular(10.r),
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       CustomText(text: "Player 1 ", color: whiteColor, fontSize: 16.sp, fontWeight: FontWeight.bold),
              //       kSizedBoxW5,
              //       Obx(()=>CustomText(text: controller.player1Wins.toString(), color: yellowColor, fontSize: 18.sp, fontWeight: FontWeight.bold)),
              //     ],
              //   ),
              //
              // ),
              //
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
              //   padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              //   width: MediaQuery.of(context).size.width,
              //   height: 60.h,
              //   decoration: BoxDecoration(
              //     color: mainColor.withOpacity(0.3),
              //     borderRadius: BorderRadius.circular(10.r),
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       CustomText(text: "Player 2 ", color: whiteColor, fontSize: 16.sp, fontWeight: FontWeight.bold),
              //       kSizedBoxW5,
              //       Obx(()=>CustomText(text: controller.player2Wins.toString(), color: yellowColor, fontSize: 18.sp, fontWeight: FontWeight.bold)),
              //     ],
              //   ),
              //
              // ),
              Container(
                height: 70.h,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/scoreBoard.webp'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 17.w,vertical: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          kSizedBoxW5,
                          kSizedBoxW5,
                          Image.asset(greenImg,width: 30.w,height: 30.h,),

                          // CustomText(
                          //   text: 'Player 1',
                          //   color: whiteColor,
                          //   fontSize: 12.sp,
                          // ),
                        ],
                      ),
                      Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AnimatedNumberText(
                            controller.player1Wins.value, // int or double
                            curve: Curves.easeIn,
                            duration: const Duration(seconds: 1),
                            style:  TextStyle(fontSize: 18.sp,color:yellowColor,fontFamily: "Audiowide"),
                            // formatter: (value) {
                            //
                            //   return formatted;
                            // },
                          ),
                          kSizedBoxW30,
                          //CustomText(text: "${controller.sgPlayer1Wins.value}", color: yellowColor, fontSize: 15.sp),
                          CustomText(text: " vs ", color: whiteColor, fontSize: 15.sp),
                          kSizedBoxW30,
                          // CustomText(text: "${controller.sgPlayer2Wins.value}", color: yellowColor, fontSize: 15.sp),
                          AnimatedNumberText(
                            controller.player2Wins.value, // int or double
                            curve: Curves.easeIn,
                            duration: const Duration(seconds: 1),
                            style:  TextStyle(fontSize: 18.sp,color:yellowColor,fontFamily: "Audiowide"),
                            // formatter: (value) {
                            //
                            //   return formatted;
                            // },
                          ),
                        ],
                      )),
                      Row(
                        children: [

                          Image.asset(yellowImg,width: 30.w,height: 30.h,),
                          kSizedBoxW5,
                          // CustomText(
                          //   text: 'Player AI',
                          //   color: whiteColor,
                          //   fontSize: 12.sp,
                          // ),


                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                child: CustomText(text: "Score Board (Single Player Mode)",color: whiteColor, fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
              //   padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              //   width: MediaQuery.of(context).size.width,
              //   height: 60.h,
              //   decoration: BoxDecoration(
              //     color: mainColor.withOpacity(0.3),
              //     borderRadius: BorderRadius.circular(10.r),
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       CustomText(text: "Player 1 ", color: whiteColor, fontSize: 16.sp, fontWeight: FontWeight.bold),
              //       kSizedBoxW5,
              //       Obx(()=>CustomText(text: controller.sgPlayer1Wins.toString(), color: yellowColor, fontSize: 18.sp, fontWeight: FontWeight.bold)),
              //     ],
              //   ),
              //
              // ),
              //
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
              //   padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              //   width: MediaQuery.of(context).size.width,
              //   height: 60.h,
              //   decoration: BoxDecoration(
              //     color: mainColor.withOpacity(0.3),
              //     borderRadius: BorderRadius.circular(10.r),
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       CustomText(text: "Player AI ", color: whiteColor, fontSize: 16.sp, fontWeight: FontWeight.bold),
              //       kSizedBoxW5,
              //       Obx(()=>CustomText(text: controller.sgPlayer2Wins.toString(), color: yellowColor, fontSize: 18.sp, fontWeight: FontWeight.bold)),
              //     ],
              //   ),
              //
              // ),
              Container(
                height: 70.h,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/scoreBoard.webp'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 17.w,vertical: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          kSizedBoxW5,
                          kSizedBoxW5,
                          Image.asset(greenImg,width: 30.w,height: 30.h,),

                          // CustomText(
                          //   text: 'Player 1',
                          //   color: whiteColor,
                          //   fontSize: 12.sp,
                          // ),
                        ],
                      ),
                      Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AnimatedNumberText(
                            controller.sgPlayer1Wins.value, // int or double
                            curve: Curves.easeIn,
                            duration: const Duration(seconds: 1),
                            style:  TextStyle(fontSize: 18.sp,color:yellowColor,fontFamily: "Audiowide"),
                            // formatter: (value) {
                            //
                            //   return formatted;
                            // },
                          ),
                          kSizedBoxW30,
                          //CustomText(text: "${controller.sgPlayer1Wins.value}", color: yellowColor, fontSize: 15.sp),
                          CustomText(text: " vs ", color: whiteColor, fontSize: 15.sp),
                          kSizedBoxW30,
                          // CustomText(text: "${controller.sgPlayer2Wins.value}", color: yellowColor, fontSize: 15.sp),
                          AnimatedNumberText(
                            controller.sgPlayer2Wins.value, // int or double
                            curve: Curves.easeIn,
                            duration: const Duration(seconds: 1),
                            style:  TextStyle(fontSize: 18.sp,color:yellowColor,fontFamily: "Audiowide"),
                            // formatter: (value) {
                            //
                            //   return formatted;
                            // },
                          ),
                        ],
                      )),
                      Row(
                        children: [

                          Image.asset(yellowImg,width: 30.w,height: 30.h,),
                          kSizedBoxW5,
                          // CustomText(
                          //   text: 'Player AI',
                          //   color: whiteColor,
                          //   fontSize: 12.sp,
                          // ),


                        ],
                      ),
                    ],
                  ),
                ),
              ),
              kSizedBoxH30,

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                child: CustomText(text: "General",color: whiteColor, fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  context.navigateAndRemoveUntil(const PrivacyPolicy(), true);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  width: MediaQuery.of(context).size.width,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: mainColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(text: "Privacy Policy", color: whiteColor, fontSize: 16.sp, fontWeight: FontWeight.bold),
                      kSizedBoxW5,
                      Image.asset('assets/images/privacy.webp', width: 40.w, height: 40.h),
                    ],
                  ),

                ),
              ),


              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                width: MediaQuery.of(context).size.width,
                height: 60.h,
                decoration: BoxDecoration(
                  color: mainColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: "Version", color: whiteColor, fontSize: 16.sp, fontWeight: FontWeight.bold),
                    kSizedBoxW5,
                    CustomText(text: version, color: whiteColor, fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ],
                ),

              ),
              kSizedBoxH30,

            ],
          ),
        ),
      ),
    );
  }
}
