import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:four_in_a_row/constants/dimen_const.dart';
import 'package:four_in_a_row/constants/image_const.dart';
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
          "How to Play ?",
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
                 text: "Welcome to the Four in a Row game. ",
                  fontSize: 14.sp,               ),
                kSizedBoxH10,
                CustomText(text: "Two Players Mode", color: yellowColor,fontWeight: FontWeight.bold,fontSize: 16.sp,),
                kSizedBoxH5,
                Text(
                    " The game is played on a grid of 7 columns and 6 rows. The two players take turns dropping their colored discs from the top into a column. The pieces fall straight down, occupying the next available space within the column. The objective of the game is to connect four of one's own discs of the same color next to each other vertically, horizontally, or diagonally before your opponent. The game ends in a draw if the board is filled completely without any player connecting four discs. The player who connects four discs wins the game. Enjoy the game!",
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 14.sp,
                      fontFamily: "Audiowide",
                    )),
                kSizedBoxH10,
                CustomText(text: "AI Mode ", color: yellowColor,fontWeight: FontWeight.bold,fontSize: 16.sp,),
                kSizedBoxH5,
                Text(" Play against the computer. The computer will make its move after you make yours. The computer will try to connect four discs before you do. Good luck!",
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
