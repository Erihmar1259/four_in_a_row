import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:four_in_a_row/constants/color_const.dart';
import 'package:four_in_a_row/screens/intro_screen.dart';
import 'package:four_in_a_row/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/image_const.dart';
import 'cpu.dart';

class GameController extends GetxController {
  var board = List.generate(6, (_) => List.filled(7, 0)).obs;
  var currentPlayer = 1.obs;
  var isGameOver = false.obs;
  var isSinglePlayer = false.obs;
  var aiDifficulty = 'Easy'.obs;
  RxInt player1Wins = 0.obs;
  RxInt player2Wins = 0.obs;
  RxInt sgPlayer1Wins = 0.obs;
  RxInt sgPlayer2Wins = 0.obs;
  var isAiThinking = false.obs;
  late Cpu cpuPlayer;
  final player1 = AudioPlayer();
  final player = AudioPlayer();
  RxBool isMuted = true.obs;

  @override
  void onInit() {
    final box = GetStorage();
    player1Wins.value = box.read("p1") ?? 0;
    player2Wins.value = box.read("p2") ?? 0;
    sgPlayer1Wins.value = box.read("sgP1") ?? 0;
    sgPlayer2Wins.value = box.read("sgP2") ?? 0;
    isMuted.value = box.read("isMuted") ?? true;
    playSound();
    super.onInit();
  }
  void playSound() async {
    await player.setReleaseMode(ReleaseMode.loop);
    await player.play(
      AssetSource('audio/MainTheme.mp3'),
    );

    if (isMuted.value) {
      player.setVolume(0.0);
    } else {
      player.setVolume(1.0);
    }

  }

  void setSoundOnOff() async {
   final box = GetStorage();
    isMuted.value = !isMuted.value;
    if (isMuted.value) {
      player.setVolume(0.0);
    } else {
      player.setVolume(1.0);
    }
    box.write("isMuted", isMuted.value);
  }
  void dropDisc(int col) {
    var box = GetStorage();
    if (isGameOver.value) return;

    for (int row = 5; row >= 0; row--) {
      if (board[row][col] == 0) {
        board[row][col] = currentPlayer.value;
        board.refresh(); // Ensure the board is refreshed
        if (checkWin(row, col)) {
          isGameOver.value = true;
          if (currentPlayer.value == 1) {
            if (isSinglePlayer.value) {
              sgPlayer1Wins.value++;
              playWinSound();
              var sP1 = box.read("sgP1") ?? 0;
              if (sP1 < sgPlayer1Wins.value) {
                box.write("sgP1", sgPlayer1Wins.value);
              }

            } else {
              player1Wins.value++;
              playWinSound();
              var p1 = box.read("p1") ?? 0;
              if (p1 < player1Wins.value) {
                box.write("p1", player1Wins.value);
              }

            }

          } else {
            if (isSinglePlayer.value) {
              sgPlayer2Wins.value++;
              playWinSound();
              var sP2 = box.read("sgP2") ?? 0;
              if (sP2 < sgPlayer2Wins.value) {
                box.write("sgP2", sgPlayer2Wins.value);
              }
            } else {
              player2Wins.value++;
              playWinSound();
              var p2 = box.read("p2") ?? 0;
              if (p2 < player2Wins.value) {
                box.write("p2", player2Wins.value);
              }
            }

          }
          Get.defaultDialog(
              barrierDismissible: false,
              contentPadding: EdgeInsets.all(20.w),
              backgroundColor: mainColor.withOpacity(0.5),
              title: "Congratulations",
              titleStyle: TextStyle(color: whiteColor, fontSize: 20.sp),
              middleText: "Player ${currentPlayer.value} wins!",
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text: "Player ", fontSize: 16.sp, color: yellowColor),
                  Image.asset(
                    currentPlayer.value == 1 ? greenImg : yellowImg,
                    width: 30.w,
                    height: 30.h,
                  ),
                  CustomText(text: " wins!", fontSize: 16.sp, color: yellowColor),
                ],
              ),
              middleTextStyle: TextStyle(color: whiteColor, fontSize: 16.sp),
              confirm: TextButton(
                  onPressed: () {
                    resetGame();
                    Get.back();
                  },
                  child: Image.asset(
                    restartImg,
                    width: 30.w,
                    height: 30.h,
                  )),
              cancel: TextButton(
                  onPressed: () {
                    resetGame();
                    Get.offAll(const IntroScreen());
                  },
                  child: Image.asset(
                    homeImg,
                    width: 30.w,
                    height: 30.h,
                  )));
          //Get.snackbar('Game Over', 'Player ${currentPlayer.value} wins!',snackPosition: SnackPosition.BOTTOM,colorText: whiteColor,backgroundColor: mainColor);
        } else {
          currentPlayer.value = 3 - currentPlayer.value; // Switch player
          if (isSinglePlayer.value && currentPlayer.value == 2) {
            isAiThinking.value = true;
            Future.delayed(const Duration(milliseconds: 700), () {
              aiMove();
            });
          }
        }
        break;
      }
    }
  }
  void playWinSound() async {
    player1.play(
      AssetSource('audio/yay.mp3'),
    );
    player1.setVolume(1.0);
    Future.delayed(const Duration(seconds: 5)).then((value) => player1.stop());
  }
  void aiMove() async {
    switch (aiDifficulty.value) {
      case 'Easy':
        cpuPlayer = DumbCpu(yellowImg);
        break;
      case 'Medium':
        cpuPlayer = HarderCpu(yellowImg);
        break;
      case 'Hard':
        cpuPlayer = HardestCpu(yellowImg);
        break;
    }
    int col = await cpuPlayer.chooseCol(board);
    // Ensure the column index is valid before dropping the disc
    if (col >= 0 && col < 7) {
      dropDisc(col);
    } else {
      // Handle invalid column index (optional)
      print('Invalid column index: $col');
    }
    isAiThinking.value = false;
  }

  bool checkWin(int row, int col) {
    return checkDirection(row, col, 1, 0) || // Horizontal
        checkDirection(row, col, 0, 1) || // Vertical
        checkDirection(row, col, 1, 1) || // Diagonal /
        checkDirection(row, col, 1, -1); // Diagonal \
  }

  bool checkDirection(int row, int col, int dRow, int dCol) {
    int count = 0;
    for (int i = -3; i <= 3; i++) {
      int r = row + i * dRow;
      int c = col + i * dCol;
      if (r >= 0 &&
          r < 6 &&
          c >= 0 &&
          c < 7 &&
          board[r][c] == currentPlayer.value) {
        count++;
        if (count == 4) return true;
      } else {
        count = 0;
      }
    }
    return false;
  }

  void resetGame() {
    board.value = List.generate(6, (_) => List.filled(7, 0));
    currentPlayer.value = 1;
    isGameOver.value = false;
  }
  @override
  void onClose() {
   resetGame();
    super.onClose();
  }
  @override
  void dispose() {
    resetGame();
    super.dispose();
  }
}
