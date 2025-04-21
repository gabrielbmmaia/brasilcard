import 'package:brasilcard/core/router/routes.dart';
import 'package:brasilcard/features/home/presentation/pages/home_page.dart';
import 'package:go_router/go_router.dart';

class HomeRouters {
  HomeRouters._();

  static final homeRoutes = <GoRoute>[
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
  ];
}
