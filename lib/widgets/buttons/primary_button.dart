import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_virtual_dressing/pages/picture_choice/picture_choice.dart';

class PrimaryButton extends StatelessWidget {
  final String btnText;
  const PrimaryButton({
    super.key, required this.btnText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF666AEC),
          padding: const EdgeInsets.all(10),
        ),
        onPressed: () {
          Get.to(PictureChoice());
        },
        child: Text(
          btnText,
          style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w700
          ),
        ),
      ),
    );
  }
}