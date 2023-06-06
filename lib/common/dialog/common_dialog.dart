import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class ExceptionHandler {
  static Future<void> showCustomDialog({
    required String title,
    required String message,
    required String btnCaption,
  }) async {
    await showDialog(
      context: kScaffoldKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text(
            title,
            style: GoogleFonts.notoSans(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            message,
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
                  btnCaption,
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
      },
    );
  }
}
