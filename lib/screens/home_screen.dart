import 'dart:async';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:greeting_app/constants/remote_config_keys.dart';
import 'package:greeting_app/widgets/greeting_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _greeting = '';
  FirebaseRemoteConfig firebaseRemoteConfig = FirebaseRemoteConfig.instance;

  @override
  void initState() {
    super.initState();

    _updateGreeting();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _updateGreeting();
      });
    });
  }

  void _updateGreeting() {
    var now = DateTime.now();
    if (now.hour < 12) {
      _greeting = 'Hello Good morning';
    } else if (now.hour < 17) {
      _greeting = ' Hello Good afternoon';
    } else {
      _greeting = 'Good evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Greeting App'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Hello \nWelcome to the greeting App',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Click on the button below to show greeting'),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    firebaseRemoteConfig.getBool(RemoteConfigKeys.showDialog)
                        ? showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                shape: const RoundedRectangleBorder(),
                                child: SizedBox(
                                  height: 200,
                                  child: GreetingWidget(
                                    greeting: _greeting,
                                  ),
                                )),
                          )
                        : showModalBottomSheet(
                            context: context,
                            constraints: const BoxConstraints(maxHeight: 200),
                            builder: (context) =>
                                GreetingWidget(greeting: _greeting));
                  },
                  child: const Text('Show greeting'))
            ],
          ),
        ),
      ),
    );
  }



}
