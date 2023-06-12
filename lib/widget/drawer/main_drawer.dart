import 'package:flutter/material.dart';
import 'package:fof_dfp_mobile/service/system/login_service.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';

import 'package:fof_dfp_mobile/common/constants.dart';
import 'package:fof_dfp_mobile/providers/getx_manager.dart';
import 'package:fof_dfp_mobile/screen/login/login_screen.dart';
import 'package:fof_dfp_mobile/common/dialog/common_dialog.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({required this.onChangeScreen, super.key});

  final Function(String, bool) onChangeScreen;

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  bool isExpanded = false;
  var loginController = GetXManager.getLoginController();
  var logger = Logger();

  Future<void> changeLoginScreen(bool isMessage) async {
    if (isMessage) {
      await ExceptionHandler.showCustomDialog(
        title: '정보',
        message: '로그인 하십시오.',
        btnCaption: '확인',
      );
    }
    widget.onChangeScreen(LoginScreen.screenName, true);
    kScaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              // margin: const EdgeInsets.only(top: 60),
              height: 40, // 픽셀 단위로 높이 설정
              color: Colors.white,
              child: Row(
                children: [
                  GetBuilder(
                    init: GetXManager.getLoginController(),
                    builder: (controller) {
                      return TextButton(
                        onPressed: () {
                          if (!controller.isLogin.value) {
                            changeLoginScreen(false);
                          }
                          LoginRequestHandler.logOut();
                          return;
                        },
                        child: Text(
                          !controller.isLogin.value ? '로그인' : '로그아웃',
                          style: GoogleFonts.notoSans(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 16,
                  ), // Add spacing between the buttons
                  TextButton(
                    onPressed: () async {
                      if (!loginController.isLogin.value) {
                        await changeLoginScreen(true);
                        return;
                      }
                      await ExceptionHandler.showCustomDialog(
                        title: '정보',
                        message: '개발 중입니다.',
                        btnCaption: '확인',
                      );
                    },
                    child: Text(
                      '회원관리',
                      style: GoogleFonts.notoSans(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Spacer(), // Expands to fill the remaining space
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      logger.i('icon button proessed');
                      kScaffoldKey.currentState?.openDrawer();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 26, 183, 183),
                        ),
                        color: const Color.fromARGB(255, 26, 183, 183),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          if (!loginController.isLogin.value) {
                            await changeLoginScreen(true);
                            return;
                          }
                          await ExceptionHandler.showCustomDialog(
                            title: '정보',
                            message: '개발 중입니다.',
                            btnCaption: '확인',
                          );
                        },
                        child: Text(
                          '회원관리',
                          style: GoogleFonts.notoSans(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 26, 183, 183),
                        ),
                        color: Colors.white,
                      ),
                      child: TextButton(
                        onPressed: () async {
                          if (!loginController.isLogin.value) {
                            await changeLoginScreen(true);
                            return;
                          }
                          await ExceptionHandler.showCustomDialog(
                            title: '정보',
                            message: '개발 중입니다.',
                            btnCaption: '확인',
                          );
                        },
                        child: Text(
                          'WORKPLACE',
                          style: GoogleFonts.lato(
                            color: const Color.fromARGB(255, 26, 183, 183),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                size: 30,
              ),
              title: Text(
                'OVERVIEW',
                style: GoogleFonts.lato(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              onTap: () async {
                if (!loginController.isLogin.value) {
                  await changeLoginScreen(true);
                  return;
                }
                await ExceptionHandler.showCustomDialog(
                  title: '정보',
                  message: '개발 중입니다.',
                  btnCaption: '확인',
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.grid_view,
                size: 30,
              ),
              title: Text(
                '서비스',
                style: GoogleFonts.notoSans(
                  fontSize: 20,
                  color: const Color.fromARGB(255, 26, 183, 183),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () async {
                setState(() {
                  isExpanded = !isExpanded;
                  logger.i(isExpanded);
                });
              },
            ),
            if (isExpanded)
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                      child: ListTile(
                        title: Text(
                          '해상운송',
                          style: GoogleFonts.notoSans(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () async {
                          if (!loginController.isLogin.value) {
                            await changeLoginScreen(true);
                            return;
                          }
                          await ExceptionHandler.showCustomDialog(
                            title: '정보',
                            message: '개발 중입니다.',
                            btnCaption: '확인',
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: ListTile(
                        title: Text(
                          '내륙운송',
                          style: GoogleFonts.notoSans(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () async {
                          if (!loginController.isLogin.value) {
                            await changeLoginScreen(true);
                            return;
                          }
                          await ExceptionHandler.showCustomDialog(
                            title: '정보',
                            message: '개발 중입니다.',
                            btnCaption: '확인',
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: ListTile(
                        title: Text(
                          '적화보험',
                          style: GoogleFonts.notoSans(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () async {
                          if (!loginController.isLogin.value) {
                            await changeLoginScreen(true);
                            return;
                          }
                          await ExceptionHandler.showCustomDialog(
                            title: '정보',
                            message: '개발 중입니다.',
                            btnCaption: '확인',
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: ListTile(
                        title: Text(
                          '통관서비스',
                          style: GoogleFonts.notoSans(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () async {
                          if (!loginController.isLogin.value) {
                            await changeLoginScreen(true);
                            return;
                          }
                          await ExceptionHandler.showCustomDialog(
                            title: '정보',
                            message: '개발 중입니다.',
                            btnCaption: '확인',
                          );
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'FBA 전용서비스',
                        style: GoogleFonts.notoSans(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () async {
                        if (!loginController.isLogin.value) {
                          await changeLoginScreen(true);
                          return;
                        }
                        await ExceptionHandler.showCustomDialog(
                          title: '정보',
                          message: '개발 중입니다.',
                          btnCaption: '확인',
                        );
                      },
                    ),
                  ],
                ),
              ),
            ListTile(
              leading: const Icon(
                Icons.headset,
                size: 30,
              ),
              title: Text(
                '고객센터',
                style: GoogleFonts.notoSans(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () async {
                if (!loginController.isLogin.value) {
                  await changeLoginScreen(true);
                  return;
                }
                await ExceptionHandler.showCustomDialog(
                  title: '정보',
                  message: '개발 중입니다.',
                  btnCaption: '확인',
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.aspect_ratio,
                size: 30,
              ),
              title: Text(
                '인사이트',
                style: GoogleFonts.notoSans(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () async {
                if (!loginController.isLogin.value) {
                  await changeLoginScreen(true);
                  return;
                }
                await ExceptionHandler.showCustomDialog(
                  title: '정보',
                  message: '개발 중입니다.',
                  btnCaption: '확인',
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.business,
                size: 30,
              ),
              title: Text(
                '회사소개',
                style: GoogleFonts.notoSans(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () async {
                await ExceptionHandler.showCustomDialog(
                  title: '정보',
                  message: '개발 중입니다.',
                  btnCaption: '확인',
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.people,
                size: 30,
              ),
              title: Text(
                'MEMBER',
                style: GoogleFonts.notoSans(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () async {
                if (!loginController.isLogin.value) {
                  await changeLoginScreen(true);
                  return;
                }
                await ExceptionHandler.showCustomDialog(
                  title: '정보',
                  message: '개발 중입니다.',
                  btnCaption: '확인',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
