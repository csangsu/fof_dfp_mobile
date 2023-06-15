import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class BarcodeReader extends StatefulWidget {
  const BarcodeReader({super.key});

  @override
  State<BarcodeReader> createState() => _BarcodeReaderState();
}

class _BarcodeReaderState extends State<BarcodeReader> {
  var logger = Logger();
  final _formKey = GlobalKey<FormState>();
  String barcode = '';
  FocusNode myFocusNode = FocusNode();
  final _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 22, right: 22),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                if (myFocusNode.hasFocus) {
                  myFocusNode.unfocus(); // 포커스 해제
                } else {
                  myFocusNode.requestFocus(); // 포커스 설정
                }
              },
              child: TextFormField(
                focusNode: myFocusNode,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.0),
                    borderSide: const BorderSide(
                      color: Colors.black, // 테두리 색상
                      width: 1.0, // 테두리 두께
                    ),
                  ),
                  hintText: 'barcode input',
                ),
                readOnly: true, // 입력 불가능한 상태로 설정
                controller: _inputController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RawKeyboardListener(
              focusNode: myFocusNode, // 포커스 노드 설정
              onKey: (RawKeyEvent event) {
                logger.i(event.character);
                if (event is RawKeyDownEvent) {
                  // 하드웨어 키의 RawKeyUpEvent를 처리
                  if (event.data.logicalKey == LogicalKeyboardKey.enter) {
                    // 바코드 입력이 완료된 경우
                    barcode = ''; // 입력 초기화
                  }
                  if (event.data.logicalKey == LogicalKeyboardKey.backspace) {
                    if (barcode.isNotEmpty) {
                      barcode = barcode.substring(0, barcode.length - 1);
                    }
                  } else {
                    // 다른 키 입력의 경우
                    barcode += event.character ?? ''; // 입력 추가
                    logger.i(barcode);
                  }
                  _inputController.text = barcode;
                }
              },
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
