import 'package:brasilcard/core/di/core_di.dart';
import 'package:brasilcard/core/utils/debounce.dart';
import 'package:brasilcard/core/utils/extensions/context_extension.dart';
import 'package:brasilcard/core/utils/extensions/widget_extensions.dart';
import 'package:brasilcard/core/widgets/ds_app_bar.dart';
import 'package:brasilcard/core/widgets/ds_loading_indicator.dart';
import 'package:brasilcard/features/coin_list/presentation/coin_list_router.dart';
import 'package:brasilcard/features/coin_list/presentation/viewmodel/coin_list/coin_list_viewmodel.dart';
import 'package:brasilcard/features/coin_list/presentation/viewmodel/favorite_list/favorite_list_viewmodel.dart';
import 'package:brasilcard/features/coin_list/presentation/widgets/coin_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:brasilcard/core/utils/extensions/size_extensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ICoinListViewModel coinListVM;
  late IFavoriteListViewModel favoriteListVM;
  final controller = TextEditingController();
  final debounce = Debounce(milliseconds: 1000);

  @override
  void initState() {
    coinListVM = injection<ICoinListViewModel>();
    favoriteListVM = injection<IFavoriteListViewModel>();
    favoriteListVM.loadFavorites();
    coinListVM.getCryptos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DsAppBar(
        title: 'BrasilCard',
        actions: [
          IconButton(
            onPressed: () => CoinListRouters.navigateToFavoritePage(context),
            icon: Icon(Icons.star),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SearchBar(
            elevation: WidgetStatePropertyAll(0),
            controller: controller,
            onChanged: (value) {
              debounce(() => coinListVM.getCryptos(query: value));
            },
          ).all(16),
          Expanded(
            child: Observer(
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
                  child: RefreshIndicator(
                    onRefresh:
                        () => coinListVM.getCryptos(
                          query: controller.text.trim(),
                        ),
                    color: context.colorTheme.tertiary,
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
                              isFavorite: favoriteListVM.isFavorite(model.id),
                              onFavoriteClick: () {
                                favoriteListVM.toggleFavorite(model.id);
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
          ),
        ],
      ),
    );
  }
}
