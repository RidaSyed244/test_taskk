import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_taskk/screens/events/views/events_view.dart';
import 'package:test_taskk/screens/registration/views/registration_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.email});
  final email;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    print("Email: ${widget.email}");

    splash();
    super.initState();
  }

  splash() {
    Timer(Duration(seconds: 5), () {
      if (widget.email == null) {
        Get.off(() => RegistrationScreen());
      } else {
        Get.off(() => EventsScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/Splash.png",
            ),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
      ),
    );
  }
}
