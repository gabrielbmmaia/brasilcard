import 'package:brasilcard/core/di/core_di.dart';
import 'package:brasilcard/core/theme/text_style.dart';
import 'package:brasilcard/core/theme/viewmodel/theme_viewmodel.dart';
import 'package:brasilcard/core/utils/debounce.dart';
import 'package:brasilcard/core/utils/extensions/context_extension.dart';
import 'package:brasilcard/core/utils/extensions/text_style_extension.dart';
import 'package:brasilcard/core/utils/extensions/widget_extensions.dart';
import 'package:brasilcard/core/widgets/ds_app_bar.dart';
import 'package:brasilcard/core/widgets/ds_error.dart';
import 'package:brasilcard/core/widgets/ds_loading_indicator.dart';
import 'package:brasilcard/core/widgets/ds_text.dart';
import 'package:brasilcard/features/coin_list/presentation/coin_list_router.dart';
import 'package:brasilcard/features/coin_list/presentation/viewmodels/coin_list/coin_list_viewmodel.dart';
import 'package:brasilcard/features/coin_list/presentation/viewmodels/favorite_list/favorite_list_viewmodel.dart';
import 'package:brasilcard/features/coin_list/presentation/widgets/coin_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:brasilcard/core/utils/extensions/size_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../coin_list/presentation/utils/unfavorite_dialog.dart';

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
    coinListVM.getCryptos();
    super.initState();
  }

  void refreshList() {
    favoriteListVM.loadFavorites();
    coinListVM.getCryptos(query: controller.text.trim());
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 4.w),
            decoration: BoxDecoration(
              color: context.colorTheme.secondary,
              borderRadius: BorderRadius.circular(100),
            ),
            child: TextFormField(
              controller: controller,
              onChanged: (value) {
                debounce(() => coinListVM.getCryptos(query: value));
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
          Expanded(
            child: Observer(
              builder: (context) {
                if (coinListVM.isLoading) {
                  return DSLoadingIndicator();
                }
                if (coinListVM.errorMessage != null) {
                  return DSError(
                    title: coinListVM.errorMessage ?? 'Teve um error aqui',
                    onTap: () => refreshList(),
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
                    onRefresh: () async => refreshList(),
                    color: context.colorTheme.tertiary,
                    child: ListView.separated(
                      itemCount: coinListVM.cryptos.length,
                      padding: EdgeInsets.all(16.r),
                      separatorBuilder: (context, index) => 16.hg,
                      itemBuilder: (context, index) {
                        final model = coinListVM.cryptos[index];
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
                                    ? UnfavoriteDialog.show(
                                      context,
                                      model: model,
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
