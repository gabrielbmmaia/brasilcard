import 'package:brasilcard/core/utils/extensions/context_extension.dart';
import 'package:brasilcard/core/utils/extensions/text_style_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/text_style.dart';
import '../../../../core/widgets/ds_text.dart';
import '../../data/models/coin_model.dart';

class UnfavoriteDialog {
  UnfavoriteDialog._();

  static void show(
    BuildContext context, {
    required CoinModel model,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: context.colorTheme.secondary,
          title: Text.rich(
            style: AppTextStyle.h6.regular.copyWith(
              color: context.colorTheme.onSecondary,
            ),
            textAlign: TextAlign.center,
            TextSpan(
              text: 'Tem certeza que deseja apagar ',
              children: [
                TextSpan(text: model.name, style: AppTextStyle.h6.bold),
                TextSpan(text: ' dos favoritos?'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: DSText(
                'Cancelar',
                style: AppTextStyle.h6,
                color: context.colorTheme.onPrimary,
              ),
            ),
            TextButton(
              onPressed: () {
                onConfirm();
                context.pop();
              },
              child: DSText(
                'Confirmar',
                style: AppTextStyle.h6.semiBold,
                color: context.colorTheme.onPrimary,
              ),
            ),
          ],
        );
      },
    );
  }
}
