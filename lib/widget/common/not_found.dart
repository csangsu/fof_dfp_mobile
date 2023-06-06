import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 50,
        ),
        SvgPicture.asset('assets/images/not_found.svg'),
        const SizedBox(
          height: 50,
        ),
        Text(
          'NOT FOUND',
          style: GoogleFonts.lato(
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          '고객님 이용에 불편을 드려 죄송합니다.\n요청하신 페이지를 찾을 수 없습니다.',
          style: GoogleFonts.notoSans(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 182,
        )
      ],
    );
  }
}
