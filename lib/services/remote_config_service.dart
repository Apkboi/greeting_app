import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigsService {
  RemoteConfigsService._();

  /// [RemoteConfigsService] factory constructor.
  static Future<RemoteConfigsService> create() async {
    final RemoteConfigsService remoteConfigsService = RemoteConfigsService._();
    await remoteConfigsService._init();
    return remoteConfigsService;
  }

  _init() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig
        .setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(microseconds: 1),
      minimumFetchInterval: const Duration(milliseconds: 100),
    ))
        .then((value) async {
      await remoteConfig.fetchAndActivate();

      log('Initialized');
    });
  }
}
