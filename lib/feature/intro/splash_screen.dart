import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:counter/core/db/cache/cache_helper.dart';
import 'package:counter/feature/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';

import '../auth/presentation/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

 bool isLogin = false;
  String? token;

@override
  void initState() {
    CacheHelper.init();
    token = CacheHelper.getData(key: "token");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: FlutterSplashScreen.fadeIn(
          nextScreen: token != null ? HomeScreen() : LoginScreen(),
          backgroundColor: Colors.white,
          duration: const Duration(milliseconds: 3515),
          onInit: () async {
            
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
