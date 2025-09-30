import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final String imageAssets;
  final String text;
  final VoidCallback onTapCon;
  const SocialLoginButton({
    super.key,
    required this.imageAssets,
    required this.text,
    required this.onTapCon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCon,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 10),
            SizedBox(
              height: 30,
              width: 32,
              child: Image.asset(
                imageAssets,
              ), //Image.asset("assets/images/google.png"),
            ),
            //Spacer(),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                // "Continue With Google",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,

                  overflow: TextOverflow.ellipsis, // Prevents overflow warning
                ),
              ),
            ),
            // Spacer(),
          ],
        ),
      ),
    );
  }
}
