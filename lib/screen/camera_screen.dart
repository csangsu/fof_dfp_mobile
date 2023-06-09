import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fof_dfp_mobile/common/constants.dart';
import 'package:logger/logger.dart';

import '../main.dart';

class CameraScreen extends StatefulWidget {
  static String screenName = "CameraScreen";
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;
  late Future<void> _initializeControllerFuture;
  var logger = Logger();

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
    _initializeControllerFuture = controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
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
          title: const Center(child: Text('카메라 테스트')),
        ),
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(controller);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.camera),
          onPressed: () async {
            try {
              await _initializeControllerFuture;
              final image = await controller.takePicture();
              // 이미지를 처리하거나 저장할 수 있습니다.
              logger.i('Captured image path: ${image.path}');
            } catch (e) {
              logger.i('Error capturing image: $e');
            }
          },
        ),
      ),
    );
  }
}
