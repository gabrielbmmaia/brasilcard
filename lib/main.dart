import 'package:brasilcard/core/di/core_di.dart';
import 'package:brasilcard/core/router/app_router.dart';
import 'package:brasilcard/core/theme/app_theme.dart';
import 'package:brasilcard/core/theme/viewmodel/theme_viewmodel.dart';
import 'package:brasilcard/features/coin_list/data/datasources/local/favorite_coins_local_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  CoreDI.init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await FavoriteCoinsLocalDatasource.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = injection<IThemeViewModel>();
    final designSize =
        MediaQuery.of(context).size.shortestSide < 600
            ? const Size(390, 844)
            : const Size(768, 1024);

    return Observer(
      builder:
          (context) => ScreenUtilInit(
            designSize: designSize,
            minTextAdapt: true,
            child: MaterialApp.router(
              routerDelegate: appRouter.routerDelegate,
              routeInformationProvider: appRouter.routeInformationProvider,
              routeInformationParser: appRouter.routeInformationParser,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: theme.themeMode,
            ),
          ),
    );
  }
}
