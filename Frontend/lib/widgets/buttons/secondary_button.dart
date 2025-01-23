import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../pages/authentication/register_page.dart';

class SecondaryButton extends StatelessWidget {
  final String btnText;
  const SecondaryButton({
    super.key, required this.btnText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.all(10),
            side: const BorderSide(color: Color(0xFF9598A6))
        ),
        onPressed: () {
          Get.to(const RegisterPage());
        },
        child: Text(
          btnText,
          style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w700
          ),
        ),
      ),
    );
  }
}