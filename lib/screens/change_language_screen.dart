import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constants/color_const.dart';
import '../../constants/dimen_const.dart';
import '../../languages/enum.dart';
import '../../widgets/custom_text.dart';
import '../controller/language_controller.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.put(LanguageController());
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(

        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: CustomText(
          color: whiteColor,
          text: 'change_language'.tr,
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Container(
       decoration: BoxDecoration(
         image: DecorationImage(
           image: AssetImage('assets/images/bg.webp'),
           fit: BoxFit.cover,

         ),
       ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left:10.w,right: 10.w,top:kToolbarHeight+ 50.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(
                        () => GestureDetector(
                      onTap: () {
                        languageController.changeLanguage("en", "US");
                      },
                      child:  Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/usa.webp",
                                  width: 20.w,
                                  height: 20.h,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                CustomText(
                                  text: "English",
                                  color: whiteColor,
                                )
                              ],
                            ),
                            Icon(
                              languageController.language.value ==
                                  Language.en.name
                                  ? Icons.check_circle
                                  : Icons.check_circle_outline,
                              color: languageController.language.value ==
                                  Language.en.name
                                  ? Colors.green
                                  : whiteColor,
                            ),
                          ],
                        ),
                      ),
                    ),

                  ),
                  kSizedBoxH20,
                  Obx(
                        () => GestureDetector(
                      onTap: () {
                        languageController.changeLanguage("zh", "CN");
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/china.webp",
                                  width: 20.w,
                                  height: 20.h,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                CustomText(
                                  text: "chinese".tr,
                                  color: whiteColor,
                                )
                              ],
                            ),
                            Icon(
                              languageController.language.value ==
                                  Language.zh.name
                                  ? Icons.check_circle
                                  : Icons.check_circle_outline,
                              color: languageController.language.value ==
                                  Language.zh.name
                                  ? Colors.green
                                  : whiteColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
