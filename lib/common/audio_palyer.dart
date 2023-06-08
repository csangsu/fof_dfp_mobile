import 'package:fof_dfp_mobile/main.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logger/logger.dart';

class AssertsPalyer {
  static void playAssert({required String audioFileName}) async {
    var logger = Logger();
    await player!.stop();
    await player!.setAsset('assets/audio/beep.mp3').then(
      (state) {
        return {
          player!.playerStateStream.listen((state) {
            if (state.playing) {
              logger.i('Audio Palying');
            } else {
              switch (state.processingState) {
                case ProcessingState.idle:
                  logger.i('Audio idle');
                  break;
                case ProcessingState.loading:
                  logger.i('Audio loading');
                  break;
                case ProcessingState.buffering:
                  logger.i('Audio buffering');
                  break;
                case ProcessingState.ready:
                  logger.i('Audio ready');
                  break;
                case ProcessingState.completed:
                  logger.i('Audio completed');
                  break;
              }
            }
          }),
          player!.play(),
        };
      },
    );
  }
}
