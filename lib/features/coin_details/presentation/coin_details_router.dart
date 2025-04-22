import 'package:brasilcard/core/router/routes.dart';
import 'package:brasilcard/features/coin_details/presentation/pages/coin_details_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CoinDetailsRouter {
  CoinDetailsRouter._();

  static final coinDetailsRouters = <GoRoute>[
    GoRoute(
      path: AppRoutes.details,
      builder: (context, state) {
        final coinId = state.uri.queryParameters['coinId']!;
        final coinName = state.uri.queryParameters['coinName']!;
        return CoinDetailsPage(coinId: coinId, coinName: coinName);
      },
    ),
  ];

  static Future<void> navigateToFavoritePage(
    BuildContext context, {
    required String coinId,
    required String coinName,
  }) async {
    context.push('${AppRoutes.details}?coinId=$coinId&coinName=$coinName');
  }
}
