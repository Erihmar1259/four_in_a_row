import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:four_in_a_row/constants/color_const.dart';
import 'package:four_in_a_row/constants/dimen_const.dart';
import 'package:four_in_a_row/screens/game_screen.dart';
import 'package:four_in_a_row/screens/play_with_ai_screen.dart';
import 'package:four_in_a_row/screens/settings_screen.dart';
import 'package:four_in_a_row/utils/screen_navigation_extension.dart';
import 'package:four_in_a_row/widgets/custom_image_button.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constants/image_const.dart';
import '../controller/game_controller.dart';
import '../languages/enum.dart';
import '../utils/global.dart';
import '../widgets/custom_text.dart';
import 'how_to_play_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool isAccepted = false;
  bool isChecked = false;
  String first = '';
  @override
  void initState() {
    super.initState();
    final box = GetStorage();
    first = box.read('first') ?? '';

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {

        if (first == '') {
          if (context.mounted) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) => Builder(builder: (context) {
                return StatefulBuilder(
                  builder: (context, StateSetter setState) {
                    return AlertDialog(
                      content: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SingleChildScrollView(
                              child: SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height * 0.65,
                                  width: double.infinity,
                                  //width: MediaQuery.of(context).size.width * 0.90,
                                  child: WebViewWidget(
                                      controller: WebViewController()
                                        ..loadHtmlString( Global.language == Language.zh.name
                                            ? Global.policyZh:Global.policyEn))
                              ),
                            ),
                            // Text(Global.policy, style: TextStyle(fontSize: 12)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  activeColor: Colors.green,
                                  side: BorderSide(
                                    width: 1.5,
                                    color:
                                    isChecked ? Colors.green : Colors.black,
                                  ),
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                      if (isChecked) {
                                        isAccepted = true;
                                      } else {
                                        isAccepted = false;
                                      }
                                    });
                                  },
                                ),
                                CustomText(text:"agree".tr,
                                  fontSize: 11.sp,)
                              ],
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateColor.resolveWith((states) =>
                                  isAccepted
                                      ? secondaryColor
                                      : greyColor)),
                              onPressed: isAccepted
                                  ? () async {
                               var box = GetStorage();
                                box.write('first', 'done');
                                if(context.mounted) Navigator.pop(context);
                              }
                                  : null,
                              child: Text(
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                ),
                                "accept".tr,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            );
          }
        }
      } catch (e) {
        print("Error fetching SharedPreferences: $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(GameController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                  onTap: () {
                    context.navigateAndRemoveUntil(
                        const SettingsScreen(), true);
                  },
                  child: Image.asset(settingImg)),
            ),
          ],
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.webp"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageButton(
                btnLabel: "how_to_play".tr,
                onTapFun: () {
                  Get.to(const HowToPlayScreen());
                },
              ),
              kSizedBoxH20,
              CustomImageButton(
                btnLabel: "single_player".tr,
                onTapFun: () {
                  controller.isSinglePlayer.value = true;
                  context.navigateAndRemoveUntil(const AiGameScreen(), true);
                },
              ),
              kSizedBoxH20,
              CustomImageButton(
                  btnLabel: "multi_player".tr,
                  onTapFun: () {
                    controller.isSinglePlayer.value = false;
                    context.navigateAndRemoveUntil(const GameScreen(), true);
                  }),
              kSizedBoxH20,
              CustomImageButton(
                  btnLabel: "exit".tr,
                  onTapFun: () {
                    exit(0);
                  }),
            ],
          ),
        ));
  }
}
