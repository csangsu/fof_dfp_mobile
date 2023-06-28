import 'package:fof_dfp_mobile/common/location_manager.dart';
import 'package:fof_dfp_mobile/providers/getx_manager.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:workmanager/workmanager.dart';

import 'package:fof_dfp_mobile/common/constants.dart';

@pragma('vm:entry-point')
Future<void> callbackDispatcher() async {
  var logger = Logger();
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case kFetchGeoLocation:
        Position pos = await LocationManager.getCurrentLocation();

        final loc = GetXManager.getLocationController();
        loc.setPosition(pos);
        logger.i("$kFetchGeoLocation is running!!!!");
        break;
      case Workmanager.iOSBackgroundTask:
        logger.i("${Workmanager.iOSBackgroundTask} is running!!!!");
        break;
    }
    return Future.value(true);
  });
}

class WorkManagerService {
  static void initWorkManager() {
    Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  }

  static void registerOneOffTask(
      {required String uniqueName, required String taskName}) {
    Workmanager().registerOneOffTask(uniqueName, taskName);
  }

  static void registerPeriodicTask(
    String uniqueName,
    String taskName, {
    final Duration? frequency,
    final String? tag,
    final ExistingWorkPolicy? existingWorkPolicy,
    final Duration initialDelay = Duration.zero,
    final Constraints? constraints,
    final BackoffPolicy? backoffPolicy,
    final Duration backoffPolicyDelay = Duration.zero,
    final OutOfQuotaPolicy? outOfQuotaPolicy,
    final Map<String, dynamic>? inputData,
  }) {
    Workmanager().registerPeriodicTask(
      uniqueName,
      taskName,
      frequency: frequency,
      tag: tag,
      existingWorkPolicy: existingWorkPolicy,
      initialDelay: initialDelay,
      constraints: constraints,
      backoffPolicy: backoffPolicy,
      backoffPolicyDelay: backoffPolicyDelay,
      outOfQuotaPolicy: outOfQuotaPolicy,
      inputData: inputData,
    );
  }
}
