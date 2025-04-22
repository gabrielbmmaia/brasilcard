import 'package:brasilcard/core/di/core_di.dart';
import 'package:brasilcard/core/theme/text_style.dart';
import 'package:brasilcard/core/utils/extensions/context_extension.dart';
import 'package:brasilcard/core/utils/extensions/size_extensions.dart';
import 'package:brasilcard/core/widgets/ds_app_bar.dart';
import 'package:brasilcard/core/widgets/ds_dialog.dart';
import 'package:brasilcard/core/widgets/ds_text.dart';
import 'package:brasilcard/features/coin_list/presentation/viewmodel/coin_list_from_ids/coin_list_from_ids_viewmodel.dart';
import 'package:brasilcard/features/coin_list/presentation/viewmodel/favorite_list/favorite_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
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
    reaction(
      (_) => !favoriteVM.isLoading,
      (_) => coinListVM.getCryptos(ids: favoriteVM.favoriteCoinsId),
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
            return Center(child: Text(coinListVM.errorMessage!));
          }
          return Visibility(
            visible: coinListVM.cryptos.isNotEmpty,
            replacement: Text('Nenhuma criptomoeda encontrada'),
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
                        final wasFavorite = favoriteVM.isFavorite(model.id);
                        favoriteVM.toggleFavorite(model.id);

                        if (wasFavorite) {
                          coinListVM.removeCoin(model.id);
                        }
                      },
                    );
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: Observer(
        builder: (_) {
          return coinListVM.cryptos.isNotEmpty
              ? FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DSDialog(
                        title:
                            'Tem certeza que deseja apagar todos os favoritos?',
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
                              favoriteVM.unFavoriteAll();
                              context.pop();
                            },
                            child: DSText(
                              'Confirmar',
                              style: AppTextStyle.h6,
                              color: context.colorTheme.onPrimary,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Icon(Icons.delete),
              )
              : SizedBox.shrink();
        },
      ),
    );
  }
}
