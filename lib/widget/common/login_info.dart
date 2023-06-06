import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginInfo extends StatelessWidget {
  const LoginInfo({super.key, required this.userid});

  final String userid;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Text(
          userid,
          style: GoogleFonts.notoSans(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
