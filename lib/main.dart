import 'package:counter/core/network/dio_helper.dart';
import 'package:flutter/material.dart';

import 'feature/intro/splash_screen.dart';

void main() {
  DioHelper.init();
  runApp(SplashScreen());
}

