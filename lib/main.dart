import 'dart:developer';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:greeting_app/extensions/extensions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:greeting_app/screens/home_screen.dart';
import 'package:greeting_app/services/remote_config_service.dart';

import 'constants/remote_config_keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await RemoteConfigsService.create();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  FirebaseRemoteConfig firebaseRemoteConfig = FirebaseRemoteConfig.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Greeting App',
      theme: ThemeData(
        primaryColor: HexColor.fromHex(
            firebaseRemoteConfig.getString(RemoteConfigKeys.primaryColor)),
      ),
      home: const HomeScreen(),
    );
  }
}
