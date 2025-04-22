import 'package:brasilcard/core/di/core_di.dart';
import 'package:brasilcard/core/theme/text_style.dart';
import 'package:brasilcard/core/theme/viewmodel/theme_viewmodel.dart';
import 'package:brasilcard/core/utils/debounce.dart';
import 'package:brasilcard/core/utils/extensions/context_extension.dart';
import 'package:brasilcard/core/utils/extensions/size_extensions.dart';
import 'package:brasilcard/core/utils/extensions/widget_extensions.dart';
import 'package:brasilcard/core/widgets/ds_app_bar.dart';
import 'package:brasilcard/core/widgets/ds_dialogs.dart';
import 'package:brasilcard/core/widgets/ds_error.dart';
import 'package:brasilcard/core/widgets/ds_loading_indicator.dart';
import 'package:brasilcard/core/widgets/ds_text.dart';
import 'package:brasilcard/features/coin_list/presentation/coin_list_router.dart';
import 'package:brasilcard/features/coin_list/presentation/viewmodels/coin_list/coin_list_viewmodel.dart';
import 'package:brasilcard/features/coin_list/presentation/viewmodels/favorite_list/favorite_list_viewmodel.dart';
import 'package:brasilcard/features/coin_list/presentation/widgets/coin_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../coin_list/data/models/coin_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ICoinListViewModel coinListVM;
  late IFavoriteListViewModel favoriteListVM;
  late IThemeViewModel themeVM;
  final controller = TextEditingController();
  final debounce = Debounce(milliseconds: 1000);

  @override
  void initState() {
    coinListVM = injection<ICoinListViewModel>();
    favoriteListVM = injection<IFavoriteListViewModel>();
    themeVM = injection<IThemeViewModel>();

    favoriteListVM.loadFavorites();
    coinListVM.init();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    coinListVM.dispose();
    super.dispose();
  }

  void refreshList() {
    favoriteListVM.loadFavorites();
    coinListVM.refreshList(query: controller.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DsAppBar(
        title: 'BrasilCard',
        actions: [
          Observer(
            builder:
                (context) => IconButton(
                  onPressed: () => themeVM.toggleTheme(),
                  icon: Icon(
                    themeVM.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    color: context.colorTheme.tertiary,
                  ),
                ),
          ),
          IconButton(
            onPressed: () {
              CoinListRouter.navigateToFavoritePage(
                context,
              ).then((_) => favoriteListVM.loadFavorites());
            },
            icon: Icon(Icons.star, color: context.colorTheme.tertiary),
          ),
        ],
      ),
      body: Column(
        children: [
          Material(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 4.w),
              decoration: BoxDecoration(
                color: context.colorTheme.secondary,
                borderRadius: BorderRadius.circular(100),
              ),
              child: TextFormField(
                controller: controller,
                onChanged: (value) {
                  debounce(() => coinListVM.refreshList(query: value));
                },
                cursorColor: context.colorTheme.onSurface,
                style: AppTextStyle.h7.copyWith(
                  color: context.colorTheme.onSecondary,
                ),
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: context.colorTheme.onSurface),
                  hintText: 'Pesquise pelo nome ou símbolo',
                  hintStyle: AppTextStyle.h7.copyWith(
                    color: context.colorTheme.onSurface,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ).all(16),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => refreshList(),
              color: context.colorTheme.tertiary,
              child: PagedListView<int, CoinModel>.separated(
                separatorBuilder: (context, index) => 16.hg,
                pagingController: coinListVM.pagingController,
                padding: EdgeInsets.only(left: 16.w, bottom: 16.h, right: 16.w),
                builderDelegate: PagedChildBuilderDelegate<CoinModel>(
                  itemBuilder: (context, model, index) {
                    return Observer(
                      builder: (context) {
                        return CoinCard(
                          coinModel: model,
                          isFavorite: favoriteListVM.isFavorite(model.id),
                          onFavoriteClick: () {
                            final wasFavorite = favoriteListVM.isFavorite(
                              model.id,
                            );
                            wasFavorite
                                ? DSDialogs.showHighlightedText(
                                  context,
                                  prefixText: 'Tem certeza que deseja apagar ',
                                  highlightedText: model.name,
                                  suffixText: ' dos favoritos?',
                                  onConfirm: () {
                                    favoriteListVM.toggleFavorite(model.id);
                                  },
                                )
                                : favoriteListVM.toggleFavorite(model.id);
                          },
                        );
                      },
                    );
                  },
                  firstPageProgressIndicatorBuilder: (_) {
                    return const DSLoadingIndicator();
                  },
                  newPageProgressIndicatorBuilder: (_) {
                    return const DSLoadingIndicator();
                  },
                  firstPageErrorIndicatorBuilder: (context) {
                    return DSError(
                      title: 'Erro ao carregar dados',
                      onTap: () => coinListVM.pagingController.refresh(),
                    );
                  },
                  newPageErrorIndicatorBuilder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DSText(
                            'Erro ao carregar mais dados',
                            style: AppTextStyle.h7,
                            color: context.colorTheme.onPrimary,
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              coinListVM.pagingController
                                  .retryLastFailedRequest();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: context.colorTheme.tertiary,
                            ),
                            child: DSText(
                              'Tentar novamente',
                              style: AppTextStyle.h7.copyWith(),
                              color: context.colorTheme.primary,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  noItemsFoundIndicatorBuilder: (_) {
                    return Center(
                      child: DSText(
                        'Nenhuma criptomoeda encontrada',
                        style: AppTextStyle.h7,
                        color: context.colorTheme.onSecondary,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
