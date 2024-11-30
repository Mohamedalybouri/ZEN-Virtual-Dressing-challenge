import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final String primaryText;
  final String secondaryText;
  const AuthHeader({super.key, required this.primaryText, this.secondaryText=""});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset("assets/logos/zen_logo.png"),
        const SizedBox(height: 30,),
        Text(
          primaryText,
          style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 28
          ),
        ),
        const SizedBox(height: 5,),
        if(secondaryText.isNotEmpty)
          Text(
            secondaryText,
            style: const TextStyle(
                color: Color(0xFF9598A6),
                fontWeight: FontWeight.w500,
                fontSize: 16
            ),
          ),
      ],
    );
  }
}
