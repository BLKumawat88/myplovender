import 'dart:async';

import 'package:flutter/material.dart';

import '../../theme/media_query.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5),
        () => Navigator.of(context).pushNamed('/login_screen'));
  }

  @override
  Widget build(BuildContext context) {
    var size = Sizess();
    return Scaffold(
      body: Container(
        height: size.height(context),
        width: size.width(context),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/Splash screen.png"),
                fit: BoxFit.cover)),
        child: Center(
          child: Image.asset(
            "assets/images/myplonewlogo.png",
            // width: 170,
          ),
        ),
      ),
    );
  }
}
