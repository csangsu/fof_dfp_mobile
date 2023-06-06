import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonAlertDialog extends StatelessWidget {
  const CommonAlertDialog(
      {required this.title,
      required this.content,
      required this.buttonCaption,
      super.key});

  final String title;
  final String content;
  final String buttonCaption;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      title: Text(
        title,
        style: GoogleFonts.notoSans(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        content,
        style: GoogleFonts.notoSans(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Container(
          height: 35,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 26, 183, 183),
            ),
            color: const Color.fromARGB(255, 26, 183, 183),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              buttonCaption,
              style: GoogleFonts.notoSans(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
