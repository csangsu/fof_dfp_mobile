import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fof_dfp_mobile/common/common_screen.dart';

import 'package:fof_dfp_mobile/common/constants.dart';
import 'package:fof_dfp_mobile/common/request/request_handler.dart';
import 'package:fof_dfp_mobile/common/shared_preferences.dart';
import 'package:fof_dfp_mobile/providers/getx_manager.dart';
import 'package:fof_dfp_mobile/widget/button/textbutton_large.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';

import 'package:fof_dfp_mobile/common/dialog/common_dialog.dart';
import 'package:fof_dfp_mobile/service/system/login_service.dart';

class LoginScreen extends StatefulWidget {
  static String screenName = "LoginScreen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var logger = Logger();
  var loginController = GetXManager.getLoginController();
  String _selectedItem = '+82';
  bool isAutoLogin = false;
  bool isRememberId = false;
  bool isEmailLogin = true;
  final TextEditingController _poneNumController = TextEditingController();
  final TextEditingController _userIdController =
      TextEditingController(text: 'abc@abc.abc');
  late FocusNode _userIdFocusNode;
  final TextEditingController _passwordController =
      TextEditingController(text: 'test');
  late FocusNode _passwordFocusNode;

  void initAppStat() async {
    bool isAtoLogin = await AppStatus.getBool(kAppStatusIsAutoLogin);
    bool isSaveUID = await AppStatus.getBool(kAppStatusIsSaveUserId);
    String usrid = await AppStatus.getString(kAppStatusUserId);
    String password = await AppStatus.getString(kAppStatusPassword);
    setState(() {
      isAutoLogin = isAtoLogin;
      isRememberId = isSaveUID;
      if (isRememberId || isAutoLogin) {
        _userIdController.text = usrid;
        _passwordController.text = password;
      }
      if (isRememberId) {
        _userIdController.text = usrid;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _userIdFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    initAppStat();
  }

  @override
  void dispose() {
    // 메모리 누수를 방지하기 위해 컨트롤러를 dispose 해줍니다.
    _userIdController.dispose();
    _passwordController.dispose();
    _userIdFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> doMobilePhoneLogin() async {
    await ExceptionHandler.showCustomDialog(
      title: '정보',
      message: '개발 중입니다.',
      btnCaption: '확인',
    );
  }

  Future<void> doEmailLogin() async {
    if (_userIdController.text.trim() == '') {
      ExceptionHandler.showCustomDialog(
          title: '정보', message: '이메일을 입력하셔요!', btnCaption: '확인');
      _userIdFocusNode.requestFocus();
      return;
    }
    if (_passwordController.text.trim() == '') {
      ExceptionHandler.showCustomDialog(
          title: '정보', message: '패스워드를 입력하셔요!', btnCaption: '확인');
      _passwordFocusNode.requestFocus();
      return;
    }
    try {
      DioRequestHandler.startOverLay("Login....");
      if (isRememberId) {
        AppStatus.setString(kAppStatusUserId, _userIdController.text.trim());
      }
      if (isAutoLogin) {
        AppStatus.setString(kAppStatusUserId, _userIdController.text.trim());
        AppStatus.setString(
            kAppStatusPassword, _passwordController.text.trim());
      }

      bool isLogin = await LoginRequestHandler.login(
        userId: _userIdController.text.trim(),
        pwd: _passwordController.text.trim(),
        langType: 'zh',
      );
      DioRequestHandler.stopOverlay();
      if (isLogin) {
        await ExceptionHandler.showCustomDialog(
            title: '정보', message: '로그인에 성공하였습니다.', btnCaption: '확인');
        close();
      } else {
        await ExceptionHandler.showCustomDialog(
            title: '정보', message: '로그인ID나 패스워드가 틀렸습니다.', btnCaption: '확인');
      }
    } catch (e) {
      ExceptionHandler.showCustomDialog(
        title: '에러',
        message: 'POST 요청 중 오류 발생: ${e.toString()}',
        btnCaption: '확인',
      );
      logger.i('POST 요청 중 오류 발생: $e');
      DioRequestHandler.stopOverlay();
    }
  }

  void close() {
    ScreenHandler.closeScreen(context);
  }

  Widget buildMobilePhone() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 100,
              height: 63,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: DropdownButton<String>(
                value: _selectedItem,
                elevation: 16,
                style: GoogleFonts.notoSans(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                // underline: Container(
                //   height: 2,
                //   color: Colors.deepPurpleAccent,
                // ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    _selectedItem = value!;
                  });
                },
                items:
                    phoneNations.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: TextField(
                controller: _poneNumController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.0),
                    borderSide: const BorderSide(
                      color: Colors.black, // 테두리 색상
                      width: 1.0, // 테두리 두께
                    ),
                  ),
                  hintText: '번호입력',
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 7,
        ),
        TextField(
          controller: _passwordController,
          focusNode: _passwordFocusNode,
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.0),
              borderSide: const BorderSide(
                color: Colors.black, // 테두리 색상
                width: 1.0, // 테두리 두께
              ),
            ),
            hintText: '패스워드 입력',
          ),
        ),
      ],
    );
  }

  Widget buildEmailPassword() {
    return Column(
      children: [
        TextField(
          controller: _userIdController,
          focusNode: _userIdFocusNode,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.0),
              borderSide: const BorderSide(
                color: Colors.black, // 테두리 색상
                width: 1.0, // 테두리 두께
              ),
            ),
            hintText: '이메일 입력',
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        TextField(
          controller: _passwordController,
          focusNode: _passwordFocusNode,
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.0),
              borderSide: const BorderSide(
                color: Colors.black, // 테두리 색상
                width: 1.0, // 테두리 두께
              ),
            ),
            hintText: '패스워드 입력',
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: kAppTheme,
      home: Scaffold(
        // key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // 왼쪽 화살표(Back 버튼)를 눌렀을 때 수행할 동작을 정의합니다.
              Navigator.pop(context);
            },
          ),
          title: const Center(child: Text('로그인')),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '스마트한 물류를 시작해 볼까요?',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.notoSans(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 26, 183, 183),
                          ),
                          color: const Color.fromARGB(255, 26, 183, 183),
                        ),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              isEmailLogin = true;
                            });
                          },
                          child: Text(
                            '이메일로 로그인',
                            style: GoogleFonts.notoSans(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 26, 183, 183),
                          ),
                          color: Colors.white,
                        ),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              isEmailLogin = false;
                            });
                          },
                          child: Text(
                            '휴대폰 번호로 로그인',
                            style: GoogleFonts.notoSans(
                              color: const Color.fromARGB(255, 26, 183, 183),
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                isEmailLogin ? buildEmailPassword() : buildMobilePhone(),
                const SizedBox(
                  height: 28,
                ),
                Row(
                  children: [
                    Checkbox(
                        value: isAutoLogin,
                        onChanged: (bool? value) async {
                          setState(() {
                            isAutoLogin = value!;
                            if (isAutoLogin == true) {
                              isRememberId = true;
                            }
                          });
                          AppStatus.setBool(kAppStatusIsAutoLogin, isAutoLogin);
                          AppStatus.setBool(
                              kAppStatusIsSaveUserId, isRememberId);
                        }),
                    Text(
                      '자동 로그인',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.notoSans(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Checkbox(
                        value: isRememberId,
                        onChanged: (bool? value) async {
                          setState(() {
                            isRememberId = value!;
                          });
                          AppStatus.setBool(
                              kAppStatusIsSaveUserId, isRememberId);
                        }),
                    Text(
                      '아이디 기억',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.notoSans(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                FTextButtonLarge(
                  doProcess: isEmailLogin ? doEmailLogin : doMobilePhoneLogin,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          '이메일로 찾기',
                          style: GoogleFonts.notoSans(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                      child: VerticalDivider(
                        width: 1,
                        thickness: 1,
                        color: Color.fromARGB(255, 208, 208, 208),
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          '비밀번호 찾기',
                          style: GoogleFonts.notoSans(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                      child: VerticalDivider(
                        width: 1,
                        thickness: 1,
                        color: Color.fromARGB(255, 208, 208, 208),
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          '회원가입',
                          style: GoogleFonts.notoSans(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    '또는',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSans(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      iconSize: 70,
                      icon: SvgPicture.asset(
                        'assets/images/kakao_logo.svg',
                        width: 70,
                        height: 70,
                      ),
                      onPressed: () {
                        // 아이콘 버튼이 클릭되었을 때 동작할 코드 작성
                        logger.i('kakao_logo Clicked');
                      },
                    ),
                    IconButton(
                      iconSize: 70,
                      icon: SvgPicture.asset(
                        'assets/images/line_logo.svg',
                        width: 70,
                        height: 70,
                      ),
                      onPressed: () {
                        // 아이콘 버튼이 클릭되었을 때 동작할 코드 작성
                        logger.i('line Clicked');
                      },
                    ),
                    IconButton(
                      iconSize: 70,
                      icon: SvgPicture.asset(
                        'assets/images/google_logo.svg',
                        width: 70,
                        height: 70,
                      ),
                      onPressed: () {
                        // 아이콘 버튼이 클릭되었을 때 동작할 코드 작성
                        logger.i('google Clicked');
                      },
                    ),
                    IconButton(
                      iconSize: 70,
                      icon: SvgPicture.asset(
                        'assets/images/wchat_logo.svg',
                        width: 70,
                        height: 70,
                      ),
                      onPressed: () {
                        // 아이콘 버튼이 클릭되었을 때 동작할 코드 작성
                        logger.i('wchat_logo Clicked');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
