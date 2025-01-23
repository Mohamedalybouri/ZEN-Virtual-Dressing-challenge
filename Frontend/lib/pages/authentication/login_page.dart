import 'package:flutter/material.dart';
import 'package:zen_virtual_dressing/widgets/auth_header/auth_header.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/buttons/secondary_button.dart';
import '../../widgets/text_fields/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 70, right: 24, bottom: 24, left: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuthHeader(primaryText: "Welcome Back,", secondaryText: "Log in to try on any clothes you want within the application."),
                const SizedBox(height: 30,),
                const CustomTextField(label: "E-Mail", icon: Icons.mail_outline_outlined,),
                const SizedBox(height: 15,),
                const CustomTextField(label: "Password", icon: Icons.lock),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(value: true, onChanged: (value) {}, activeColor: const Color(0xFF666AEC), side: const BorderSide(color: Color(0xFF666AEC)),),
                        const Text("Remember Me", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forget Password?",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          color: Color(0xFF9598A6),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                const PrimaryButton(btnText: "Sign In",),
                const SizedBox(height: 20,),
                const SecondaryButton(btnText: "Create Account",),
              ],
            ),
          ),
        ),
      ),
    );
  }
}