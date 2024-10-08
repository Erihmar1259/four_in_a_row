import 'package:animated_text_lerp/animated_text_lerp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:four_in_a_row/constants/dimen_const.dart';
import 'package:four_in_a_row/screens/settings_screen.dart';
import 'package:four_in_a_row/utils/screen_navigation_extension.dart';
import 'package:get/get.dart';
import '../constants/color_const.dart';
import '../constants/image_const.dart';
import '../controller/game_controller.dart';
import '../widgets/custom_image_button.dart';
import '../widgets/custom_text.dart';
import 'intro_screen.dart';

class AiGameScreen extends StatelessWidget {
  const AiGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GameController controller = Get.put(GameController());

    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            controller.resetGame();
            context.navigateAndRemoveUntil(const IntroScreen(), false);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              backImg,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(text: 'ai_difficulty'.tr, color: whiteColor, fontSize: 14.sp, fontWeight: FontWeight.bold),
            kSizedBoxW10,
            Obx(() => DropdownButton<String>(
              dropdownColor: mainColor.withOpacity(0.5),
              value: controller.aiDifficulty.value,
              style: TextStyle(color: whiteColor, fontSize: 16.sp),
              borderRadius: BorderRadius.circular(10.r),
              icon: Icon(Icons.arrow_drop_down_circle_outlined,size: 20.h, color: yellowColor),
              underline: Container(

              ),
              items: <String>['Easy', 'Medium', 'Hard'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: CustomText(text: value, color: yellowColor, fontSize: 16.sp),
                );
              }).toList(),
              onChanged: (String? newValue) {
                controller.aiDifficulty.value = newValue!;
              },
            )),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: (){
              context.navigateAndRemoveUntil(const SettingsScreen(), true);

            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(settingImg),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        padding: EdgeInsets.only(top: 50.h),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kSizedBoxH30,
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
                          style: TextStyle(fontSize: 18.sp,color:yellowColor,fontFamily: "Audiowide"),
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
                          style: TextStyle(fontSize: 18.sp,color:yellowColor,fontFamily: "Audiowide"),
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
            kSizedBoxH10,

            Obx(()=> Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(text: "${'its'.tr} ${'player'.tr} ",color: whiteColor, fontSize: 14.sp, fontWeight: FontWeight.bold),
                Image.asset(controller.currentPlayer.value == 1 ? greenImg : yellowImg,width: 20.w,height: 20.h,),
                CustomText(text: "turn".tr,color: whiteColor, fontSize: 14.sp, fontWeight: FontWeight.bold),
              ],
            )),
            Expanded(
              flex: 1,
              child: GridView.builder(

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                ),
                itemCount: 42,
                itemBuilder: (context, index) {
                  int row = index ~/ 7;
                  int col = index % 7;
                  return Obx(() =>
                      GestureDetector(
                        onTap: controller.isGameOver.value || controller.isAiThinking.value ? null : () => controller.dropDisc(col),
                        child: Container(
                          margin: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            image: controller.board[row][col] == 0
                                ? const DecorationImage(
                              image: AssetImage('assets/images/white.webp'),
                            )
                                : DecorationImage(
                              image: AssetImage(
                                controller.board[row][col] == 1
                                    ? 'assets/images/green.webp'
                                    : 'assets/images/yellow.webp',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                  );
                },
              ),
            ),

            CustomImageButton(
              btnLabel: "restart".tr,
              onTapFun: () {
                controller.resetGame();
              },
            ),
            kSizedBoxH10,

          ],
        ),
      ),
    );
  }
}