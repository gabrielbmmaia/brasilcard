import 'package:brasilcard/core/router/routes.dart';
import 'package:brasilcard/features/coin_list/presentation/pages/favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CoinListRouters {
  CoinListRouters._();

  static final coinListRoutes = <GoRoute>[
    GoRoute(
      path: AppRoutes.favorite,
      builder: (context, state) => const FavoritePage(),
    ),
  ];

  static Future<void> navigateToFavoritePage(BuildContext context) async {
    context.push(AppRoutes.favorite);
  }
}
