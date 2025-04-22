import 'package:brasilcard/features/coin_details/presentation/coin_details_router.dart';
import 'package:brasilcard/features/coin_list/presentation/coin_list_router.dart';
import 'package:brasilcard/features/home/presentation/home_router.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    ...HomeRouter.homeRoutes,
    ...CoinListRouter.coinListRoutes,
    ...CoinDetailsRouter.coinDetailsRouters,
  ],
);
