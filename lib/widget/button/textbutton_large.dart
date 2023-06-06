import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FTextButtonLarge extends StatelessWidget {
  const FTextButtonLarge({super.key, required this.doProcess});

  final Function() doProcess;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 26, 183, 183),
        ),
        color: const Color.fromARGB(255, 26, 183, 183),
      ),
      child: TextButton(
        onPressed: () async {
          await doProcess();
        },
        child: Text(
          'Login',
          style: GoogleFonts.notoSans(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
