import 'dart:math';

import 'package:brasilcard/core/di/core_di.dart';
import 'package:brasilcard/core/utils/extensions/context_extension.dart';
import 'package:brasilcard/core/utils/extensions/size_extensions.dart';
import 'package:brasilcard/core/utils/extensions/text_style_extension.dart';
import 'package:brasilcard/core/widgets/ds_app_bar.dart';
import 'package:brasilcard/core/widgets/ds_error.dart';
import 'package:brasilcard/core/widgets/ds_loading_indicator.dart';
import 'package:brasilcard/core/widgets/ds_text.dart';
import 'package:brasilcard/features/coin_details/presentation/viewmodels/details/coin_details_viewmodel.dart';
import 'package:brasilcard/features/coin_details/presentation/viewmodels/history/coin_history_viewmodel.dart';
import 'package:brasilcard/features/coin_details/presentation/widgets/field_text.dart';
import 'package:brasilcard/features/coin_list/data/models/coin_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/theme/text_style.dart';
import '../../../../core/utils/formatters.dart';
import '../widgets/price_chart.dart';

class CoinDetailsPage extends StatefulWidget {
  const CoinDetailsPage({
    required this.coinId,
    required this.coinName,
    super.key,
  });

  final String coinId;
  final String coinName;

  @override
  State<CoinDetailsPage> createState() => _CoinDetailsPageState();
}

class _CoinDetailsPageState extends State<CoinDetailsPage> {
  late ICoinDetailsViewModel detailsVM;
  late ICoinHistoryViewModel historyVM;
  final List<String> _graphEpochLabels = [
    '30 dias',
    '90 dias',
    '180 dias',
    '1 ano',
    '2 anos',
  ];

  @override
  void initState() {
    detailsVM = injection<ICoinDetailsViewModel>();
    historyVM = injection<ICoinHistoryViewModel>();
    detailsVM.getDetails(coinId: widget.coinId);
    historyVM.fetchHistory(coinId: widget.coinId);
    when((_) => detailsVM.errorMessage != null, () {
      context.showSimpleSnackBar(text: detailsVM.errorMessage!);
      context.pop();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DsAppBar.withBackButton(title: widget.coinName),
      body: Observer(
        builder: (context) {
          final model = detailsVM.crypto;
          if (detailsVM.isLoading || model == null) {
            return DSLoadingIndicator();
          }
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CachedNetworkImage(
                            maxHeightDiskCache: 500,
                            maxWidthDiskCache: 500,
                            imageUrl: url(model.symbol),
                            fit: BoxFit.fill,
                            height: 50.h,
                            width: 50.w,
                            errorWidget:
                                (context, _, error) =>
                                    Container(color: Colors.grey),
                            placeholder:
                                (context, url) => Container(color: Colors.grey),
                          ),
                          16.wt,
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DSText(
                                model.name,
                                style: AppTextStyle.h5.semiBold,
                                color: context.colorTheme.onSecondary,
                              ),
                              DSText(
                                model.symbol,
                                style: AppTextStyle.h6,
                                color: context.colorTheme.onSecondary,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Transform.rotate(
                          angle: depreciating(model) ? (pi / 2) : (-pi / 2),
                          child: Icon(
                            Icons.double_arrow_rounded,
                            size: 36.r,
                            color:
                                depreciating(model) ? Colors.red : Colors.green,
                          ),
                        ),
                        DSText(
                          '${model.changePercent24Hr.toStringAsFixed(2)}% (24h)',
                          style: AppTextStyle.h7.semiBold,
                          color:
                              depreciating(model) ? Colors.red : Colors.green,
                        ),
                      ],
                    ),
                  ],
                ),
                16.hg,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: FieldText(field: 'Rank: ', value: model.rank),
                    ),
                    FieldText(
                      field: 'Preço: ',
                      value: DSFormatter.doubleToDollar(model.priceUsd),
                    ),
                  ],
                ),
                16.hg,
                FieldText(
                  field: 'Volume(24h): ',
                  value: DSFormatter.doubleToDollar(model.volumeUsd24Hr),
                ),
                16.hg,
                FieldText(
                  field: 'VWAP(24h): ',
                  value: DSFormatter.doubleToDollar(model.vwap24Hr),
                ),
                16.hg,
                FieldText(
                  field: 'Moedas existentes: ',
                  value: DSFormatter.formatNumberBR(model.supply),
                ),
                16.hg,
                FieldText(
                  field: 'Limite de moedas: ',
                  value:
                      model.maxSupply == null
                          ? 'Não existe limite'
                          : DSFormatter.formatNumberBR(model.maxSupply!),
                ),
                16.hg,
                FieldText(
                  field: 'Capitalização total: ',
                  value: DSFormatter.doubleToDollar(model.marketCapUsd),
                ),
                16.hg,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DSText(
                      'Histórico de preço',
                      style: AppTextStyle.h6.bold,
                      color: context.colorTheme.onSecondary,
                    ),
                    8.wt,
                    Observer(
                      builder:
                          (context) => Container(
                            decoration: BoxDecoration(
                              color: context.colorTheme.secondary,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            padding: EdgeInsets.only(
                              right: 4.w,
                              left: 12.w,
                              top: 2.h,
                              bottom: 2.h,
                            ),
                            child: DropdownButton<String>(
                              isDense: true,
                              value: historyVM.mapGraphEpochToString(
                                historyVM.epoch,
                              ),
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: context.colorTheme.onSecondary,
                              ),
                              dropdownColor: context.colorTheme.secondary,
                              style: AppTextStyle.h6.copyWith(
                                color: context.colorTheme.onSecondary,
                              ),
                              underline: SizedBox(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  final epoch = historyVM.mapEpochToGraphEpoch(
                                    newValue,
                                  );
                                  historyVM.fetchHistory(
                                    coinId: widget.coinId,
                                    newEpoch: epoch,
                                  );
                                }
                              },
                              items:
                                  _graphEpochLabels
                                      .map<DropdownMenuItem<String>>((
                                        String value,
                                      ) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      })
                                      .toList(),
                            ),
                          ),
                    ),
                  ],
                ),
                16.hg,
                Observer(
                  builder: (_) {
                    if (historyVM.isLoading) {
                      return SizedBox(
                        height: 250.h,
                        child: DSLoadingIndicator(),
                      );
                    }
                    if (historyVM.errorMessage != null) {
                      return DSError(
                        title: historyVM.errorMessage!,
                        onTap: () {
                          historyVM.fetchHistory(coinId: widget.coinId);
                        },
                      );
                    }
                    return PriceChart(data: historyVM.history.toList());
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  bool depreciating(CoinModel coinModel) => coinModel.changePercent24Hr < 0;

  // Tentativa de mostrar uma imagem já que a api não retorna.
  // Url retirada do site da CoinCap
  String url(String midString) =>
      'https://assets.coincap.io'
      '/assets'
      '/icons'
      '/${midString.toLowerCase()}2@2x.png';
}
