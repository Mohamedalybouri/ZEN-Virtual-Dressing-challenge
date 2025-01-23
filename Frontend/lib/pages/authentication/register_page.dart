import 'package:flutter/material.dart';
import '../../widgets/auth_header/auth_header.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/text_fields/custom_text_field.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.white, leading: IconButton(onPressed: () {Get.back();}, icon: Icon(Icons.arrow_back_outlined, size: 30, )), forceMaterialTransparency: true,),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, right: 24, bottom: 24, left: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuthHeader(primaryText: "Let's create your account,"),
                const SizedBox(height: 20,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: CustomTextField(label: "First Name", icon: Icons.person_outline,),),
                    SizedBox(width: 10,),
                    Expanded(child: CustomTextField(label: "Last Name", icon: Icons.person_outline),)
                  ],
                ),
                const SizedBox(height: 10,),
                const CustomTextField(label: "Username", icon: Icons.person_add_alt_1_outlined,),
                const SizedBox(height: 10,),
                const CustomTextField(label: "E-Mail", icon: Icons.mail_outline_outlined,),
                const SizedBox(height: 15,),
                const CustomTextField(label: "Password", icon: Icons.lock),
                const SizedBox(height: 10,),
                const CustomTextField(label: "Confirm Password", icon: Icons.lock),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Checkbox(
                      value: true,
                      onChanged: (value) {},
                      activeColor: const Color(0xFF666AEC),
                      side: const BorderSide(color: Color(0xFF666AEC)),
                    ),
                    Expanded(
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(text: "I agree to "),
                            TextSpan(
                              text: "Privacy Policy",
                              style: TextStyle(
                                color: Color(0xFF666AEC), // Color for Privacy Policy
                                decoration: TextDecoration.underline, // Underline
                              ),
                            ),
                            TextSpan(text: " and "),
                            TextSpan(
                              text: "Terms of Use",
                              style: TextStyle(
                                color: Color(0xFF666AEC), // Color for Terms of Use
                                decoration: TextDecoration.underline, // Underline
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                const PrimaryButton(btnText: "Create Account",),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
