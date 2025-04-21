import 'package:brasilcard/core/di/core_di.dart';
import 'package:brasilcard/core/router/app_router.dart';
import 'package:brasilcard/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await CoreDI.init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final designSize =
    MediaQuery
        .of(context)
        .size
        .shortestSide < 600
        ? const Size(390, 844)
        : const Size(768, 1024);

    return ScreenUtilInit(
      designSize: designSize,
      minTextAdapt: true,
      child: MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
      ),
    );
  }
}
