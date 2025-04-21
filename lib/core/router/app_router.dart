import 'package:brasilcard/features/coin_list/presentation/coin_list_router.dart';
import 'package:brasilcard/features/home/presentation/home_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    ...HomeRouters.homeRoutes,
    ...CoinListRouters.coinListRoutes,
    // TODO Criar tela de detalhes
    GoRoute(
      path: AppRoutes.details,
      name: 'profile',
      builder: (context, state) => Container(),
    ),
  ],
);
