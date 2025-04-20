import 'package:brasilcard/features/home/presentation/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    // Criar tela de favoritos
    GoRoute(
      path: AppRoutes.favorite,
      name: 'favorite',
      builder: (context, state) => Container(),
    ),
    // Criar tela de detalhes
    GoRoute(
      path: AppRoutes.details,
      name: 'profile',
      builder: (context, state) => Container(),
    ),
  ],
);
