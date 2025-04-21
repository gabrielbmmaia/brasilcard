import 'dart:math';

import 'package:brasilcard/core/theme/text_style.dart';
import 'package:brasilcard/core/utils/extensions/context_extension.dart';
import 'package:brasilcard/core/utils/extensions/size_extensions.dart';
import 'package:brasilcard/core/utils/extensions/text_style_extension.dart';
import 'package:brasilcard/core/utils/formatters.dart';
import 'package:brasilcard/core/widgets/ds_text.dart';
import 'package:brasilcard/features/coin_list/data/models/coin_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoinCard extends StatelessWidget {
  const CoinCard({required this.coinModel, super.key});

  final CoinModel coinModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: context.colorTheme.secondary),
      padding: EdgeInsets.all(16.r),
      child: Column(
        children: [
          Row(
            children: [
              DSText(
                coinModel.rank,
                style: AppTextStyle.h7,
                color: context.colorTheme.onSecondary,
              ),
              16.wt,
              CachedNetworkImage(
                maxHeightDiskCache: 500,
                maxWidthDiskCache: 500,
                imageUrl: url(coinModel.symbol),
                fit: BoxFit.fill,
                height: 34.h,
                width: 34.w,
                errorWidget:
                    (context, _, error) => Container(color: Colors.grey),
                placeholder: (context, url) => Container(color: Colors.grey),
              ),
              16.wt,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DSText(
                      coinModel.name,
                      style: AppTextStyle.h7.semiBold,
                      color: context.colorTheme.onSecondary,
                    ),
                    DSText(
                      coinModel.symbol,
                      style: AppTextStyle.h8.regular,
                      color: context.colorTheme.onSecondary,
                    ),
                  ],
                ),
              ),
              16.wt,
              Column(
                children: [
                  Transform.rotate(
                    angle: depreciating ? (pi / 2) : (-pi / 2),
                    child: Icon(
                      Icons.double_arrow_rounded,
                      size: 26.r,
                      color: depreciating ? Colors.red : Colors.green,
                    ),
                  ),
                  DSText(
                    '${coinModel.changePercent24Hr.toStringAsFixed(2)}% (24h)',
                    style: AppTextStyle.h8.semiBold,
                    color: depreciating ? Colors.red : Colors.green,
                  ),
                ],
              ),
            ],
          ),
          16.hg,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  children: [
                    DSText(
                      'Preço',
                      style: AppTextStyle.h9.regular,
                      color: context.colorTheme.onSecondary,
                    ),
                    DSText(
                      DSFormatter.doubleToDollar(coinModel.priceUsd),
                      style: AppTextStyle.h8.semiBold,
                      color: context.colorTheme.onSecondary,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    DSText(
                      'Volume (24 h)',
                      style: AppTextStyle.h9.regular,
                      color: context.colorTheme.onSecondary,
                    ),
                    DSText(
                      DSFormatter.doubleToDollar(coinModel.volumeUsd24Hr),
                      style: AppTextStyle.h8.semiBold,
                      color: context.colorTheme.onSecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool get depreciating => coinModel.changePercent24Hr < 0;

  // Tentativa de mostrar uma imagem já que a api não retorna.
  // Url retirada do site da CoinCap
  String url(String midString) =>
      'https://assets.coincap.io'
      '/assets'
      '/icons'
      '/${midString.toLowerCase()}2@2x.png';
}
