import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fof_dfp_mobile/common/environment.dart';

var kNatoSansFont20 = GoogleFonts.notoSans(fontStyle: FontStyle.italic);

GlobalKey<ScaffoldState> kScaffoldKey = GlobalKey<ScaffoldState>();

final kContext = kScaffoldKey.currentContext!;

const kDfpFofSes = 'DFP_FOF_SES';
const kJsessionId = 'JSESSIONID';
const kAppStatusIsAutoLogin = 'APP_STATUS_AUTO_LOGIN';
const kAppStatusIsSaveUserId = 'APP_STATUS_SAVE_USER_ID';
const kAppStatusUserId = 'APP_STATUS_USER_ID';
const kAppStatusPassword = 'APP_STATUS_PASSWORD';

const List<String> phoneNations = [
  '+82',
  '+1',
  '+2',
];

var kBaseUrl = Environment.apiUrl;

ThemeData kAppTheme = ThemeData(
  appBarTheme: AppBarTheme(
    color: Colors.white, // AppBar 배경색
    iconTheme:
        const IconThemeData(color: Color.fromARGB(255, 31, 53, 77)), // 아이콘 색상
    titleTextStyle: GoogleFonts.notoSans(
      color: const Color.fromARGB(255, 0, 0, 0),
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
);
