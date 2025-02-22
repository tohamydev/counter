import 'package:counter/core/db/cache/cache_helper.dart';
import 'package:counter/core/db/local_db/local_db_helper.dart';
import 'package:counter/core/network/dio_helper.dart';
import 'package:flutter/material.dart';

import 'feature/intro/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await SQLHelper.initDb();
  await CacheHelper.init();
  runApp(SplashScreen());
}

