import 'dart:io';

import 'package:dio/dio.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:logger/logger.dart';

import 'package:fof_dfp_mobile/common/constants.dart';
import 'package:fof_dfp_mobile/models/comon/response_result.dart';
import 'package:fof_dfp_mobile/widget/circular_overlay.dart';
import '../dialog/common_dialog.dart';
import 'dio_singleton.dart';

class DioRequestHandler {
  static void startOverLay(String message) {
    kContext.loaderOverlay.show(widget: MessageOverlay(message: message));
  }

  static void stopOverlay() {
    kContext.loaderOverlay.hide();
  }

  Future<ResponseResult> post(
      String urlAddress, Map<String, dynamic> requestData) async {
    final logger = Logger();
    var dio = DioSingleton().dio;

    Options options = Options(
      contentType: 'application/json',
      headers: {
        'Cache-Control': 'no-cache     ', // Cache-Control 헤더에 no-cache 설정
        'Pragma': 'no-cache', // cdn에서 캐시된 실패응답을 주는 문제 때문에 추가
      },
      extra: {'withCredentials': true},
    );
    Response response =
        await dio.post(urlAddress, data: requestData, options: options);

    if (response.statusCode != 200) {
      ExceptionHandler.showCustomDialog(
          title: '에러',
          message: '에러가 발생하였습니다. HTTP Code[${response.statusCode}]',
          btnCaption: '확인');
    }

    logger.i(response.data);
    return ResponseResult.fromMap(response.data);
  }

  Future<ResponseResult> get(
      String urlAddress, Map<String, dynamic> requestData) async {
    final logger = Logger();
    var dio = DioSingleton().dio;

    Options options = Options(
      contentType: 'application/json',
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36',
        'Accept-Encoding': 'gzip, deflate, br',
        'Accept-Language': 'ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7',
        'Accept': 'application/json, text/plain, */*',
        'Cache-Control': 'no-store', // Cache-Control 헤더에 no-cache 설정
        'Pragma': 'no-cache', // cdn에서 캐시된 실패응답을 주는 문제 때문에 추가
        'Sec-Fetch-Mode': 'cors',
      },
      extra: {'withCredentials': true},
    );
    Response response =
        await dio.get(urlAddress, data: requestData, options: options);

    if (response.statusCode != 200) {
      ExceptionHandler.showCustomDialog(
          title: '에러',
          message: '에러가 발생하였습니다. HTTP Code[${response.statusCode}]',
          btnCaption: '확인');
    }

    logger.i(response.data);
    return ResponseResult.fromMap(response.data);
  }

  static Future<ResponseResult> upload(
      String urlAddress, List<File> files, Map<String, dynamic> param) async {
    final logger = Logger();
    var dio = DioSingleton().dio;

    final formData = FormData();
    for (int i = 0; i < files.length; i++) {
      final file = files[i];
      formData.files.add(
        MapEntry('file$i', await MultipartFile.fromFile(file.path)),
      );
    }
    for (String key in param.keys) {
      formData.fields.add(MapEntry(key, param[key]));
    }

    final response = await dio.post(
      urlAddress,
      data: formData,
    );

    if (response.statusCode != 200) {
      ExceptionHandler.showCustomDialog(
          title: '에러',
          message: '에러가 발생하였습니다. HTTP Code[${response.statusCode}]',
          btnCaption: '확인');
    }

    logger.i(response.data);
    return ResponseResult.fromMap(response.data);
  }

  Future<void> downloadFileToDownloadFolder(String url) async {
    var logger = Logger();
    final dio = Dio();
    final downloadFolder = await syspaths.getDownloadsDirectory();
    String savePath = downloadFolder!.path;
    try {
      final response = await dio.download(url, savePath);
      logger.i('Download response: $response');
    } catch (e) {
      throw Exception('Failed to download file: $e');
    }
  }
}
