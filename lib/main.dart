import 'package:brasilcard/core/di/core_di.dart';
import 'package:brasilcard/features/home/presentation/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CoreDI.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final designSize =
        MediaQuery.of(context).size.shortestSide < 600
            ? const Size(390, 844)
            : const Size(768, 1024);

    return ScreenUtilInit(
      designSize: designSize,
      minTextAdapt: true,
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const HomePage(),
      ),
    );
  }
}
