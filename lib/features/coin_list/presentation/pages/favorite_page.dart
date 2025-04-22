import 'package:brasilcard/core/di/core_di.dart';
import 'package:brasilcard/core/theme/text_style.dart';
import 'package:brasilcard/core/utils/extensions/context_extension.dart';
import 'package:brasilcard/core/utils/extensions/size_extensions.dart';
import 'package:brasilcard/core/utils/extensions/text_style_extension.dart';
import 'package:brasilcard/core/widgets/ds_app_bar.dart';
import 'package:brasilcard/core/widgets/ds_dialogs.dart';
import 'package:brasilcard/core/widgets/ds_error.dart';
import 'package:brasilcard/core/widgets/ds_text.dart';
import 'package:brasilcard/features/coin_list/presentation/viewmodels/coin_list_from_ids/coin_list_from_ids_viewmodel.dart';
import 'package:brasilcard/features/coin_list/presentation/viewmodels/favorite_list/favorite_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/widgets/ds_loading_indicator.dart';
import '../widgets/coin_card.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late IFavoriteListViewModel favoriteVM;
  late ICoinListFromIdsViewModel coinListVM;

  @override
  void initState() {
    favoriteVM = injection<IFavoriteListViewModel>();
    coinListVM = injection<ICoinListFromIdsViewModel>();
    favoriteVM.loadFavorites();
    when(
      (_) => !favoriteVM.isLoading,
      () => coinListVM.getCryptos(ids: favoriteVM.favoriteCoinsId),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DsAppBar.withBackButton(title: 'Favoritos'),
      body: Observer(
        builder: (context) {
          if (coinListVM.isLoading) {
            return DSLoadingIndicator();
          }
          if (coinListVM.errorMessage != null) {
            return DSError(
              title: coinListVM.errorMessage!,
              onTap: () => favoriteVM.loadFavorites(),
            );
          }
          return Visibility(
            visible: coinListVM.cryptos.isNotEmpty,
            replacement: Center(
              child: DSText(
                'Nenhuma criptomoeda encontrada',
                style: AppTextStyle.h7.regular,
                color: context.colorTheme.onSecondary,
              ),
            ),
            child: RefreshIndicator(
              onRefresh: () async => favoriteVM.loadFavorites(),
              child: ListView.separated(
                itemCount: coinListVM.cryptos.length,
                padding: EdgeInsets.all(16),
                separatorBuilder: (context, index) => 16.hg,
                itemBuilder: (context, index) {
                  final model = coinListVM.cryptos[index];
                  return Observer(
                    builder: (context) {
                      return CoinCard(
                        coinModel: model,
                        isFavorite: favoriteVM.isFavorite(model.id),
                        onFavoriteClick: () {
                          DSDialogs.showHighlightedText(
                            context,
                            prefixText: 'Tem certeza que deseja apagar ',
                            highlightedText: model.name,
                            suffixText: ' dos favoritos?',
                            onConfirm: () {
                              favoriteVM.toggleFavorite(model.id);
                              coinListVM.removeCoin(model.id);
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: Observer(
        builder: (_) {
          return coinListVM.cryptos.isNotEmpty
              ? FloatingActionButton(
                backgroundColor: context.colorTheme.secondary,
                onPressed: () {
                  DSDialogs.showHighlightedText(
                    context,
                    prefixText: 'Tem certeza que deseja apagar ',
                    highlightedText: 'todos',
                    suffixText: ' os favoritos?',
                    onConfirm: () {
                      favoriteVM.unFavoriteAll();
                      coinListVM.clearCoins();
                    },
                  );
                },
                child: Icon(Icons.delete, color: context.colorTheme.tertiary),
              )
              : SizedBox.shrink();
        },
      ),
    );
  }
}
