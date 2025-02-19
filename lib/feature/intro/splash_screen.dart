import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';

import '../auth/presentation/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: FlutterSplashScreen.fadeIn(
          nextScreen:  LoginScreen(),
          backgroundColor: Colors.white,
          duration: const Duration(milliseconds: 3515),
          onInit: () async {
            debugPrint("onInit");
          },
          onEnd: () async {
            debugPrint("onEnd 1");
          },
          childWidget: SizedBox(
            height: 200,
            width: 200,
            child: Image.network(
                "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Amazon_logo.svg/1280px-Amazon_logo.svg.png"),
          ),
        ),
      ),
    );

  }
}
