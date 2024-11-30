import 'dart:io';
import 'package:flutter/material.dart';
import 'package:zen_virtual_dressing/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:zen_virtual_dressing/pages/home/home_page.dart';

class PictureChoice extends StatelessWidget {
  PictureChoice({super.key}) {
    Get.lazyPut(() => HomeController(), tag: 'HomeController');
  }

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find(tag: "HomeController");
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Please select a clear photo of yourself to try on outfits within the app.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
                const SizedBox(height: 20),
                Obx(
                      () => controller.selectedImagePath.value != ""
                      ? Container(
                    child: Image.file(
                      File(controller.selectedImagePath.value),
                      height: 250,
                    ),
                        decoration: BoxDecoration(border: Border.all(width: 2, color: Color(0xFF666AEC)), borderRadius: BorderRadius.circular(10)),
                  )
                      : const SizedBox.shrink(),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    controller.getImage();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Color(0xFF666AEC)),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Pick Picture",
                    style: TextStyle(
                      color: Color(0xFF666AEC),
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Positioned widget for the Next button
          Positioned(
            bottom: 20,  // Distance from the bottom of the screen
            right: 20,   // Distance from the right of the screen
            child: ElevatedButton(
              onPressed: () {
                 controller.selectedImagePath.value == "" ? Get.snackbar("Error", "Please pick a picture", backgroundColor: Colors.red, colorText: Colors.white, icon: const Icon(Icons.error_outline, color: Colors.white,)) : Get.offAll(() => HomePage());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF666AEC),
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Next",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}