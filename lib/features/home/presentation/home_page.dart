import 'package:brasilcard/core/di/core_di.dart';
import 'package:brasilcard/core/utils/debounce.dart';
import 'package:brasilcard/core/utils/extensions/widget_extensions.dart';
import 'package:brasilcard/core/widgets/ds_app_bar.dart';
import 'package:brasilcard/core/widgets/ds_loading_indicator.dart';
import 'package:brasilcard/features/coin_list/presentation/viewmodel/coin_list/coin_list_viewmodel.dart';
import 'package:brasilcard/features/coin_list/presentation/widgets/coin_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ICoinListViewModel viewmodel;
  final controller = TextEditingController();
  final debounce = Debounce(milliseconds: 1000);

  @override
  void initState() {
    viewmodel = injection<ICoinListViewModel>();
    viewmodel.getCryptos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DsAppBar(title: 'BrasilCard'),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SearchBar(
            elevation: WidgetStatePropertyAll(0),
            controller: controller,
            onChanged: (value) {
              debounce(() => viewmodel.getCryptos(query: value));
            },
          ).all(16),
          Expanded(
            child: Observer(
              builder: (context) {
                if (viewmodel.isLoading) {
                  return DSLoadingIndicator();
                }
                if (viewmodel.errorMessage != null) {
                  return Center(child: Text(viewmodel.errorMessage!));
                }

                return Visibility(
                  visible: viewmodel.cryptos.isNotEmpty,
                  replacement: Text('Nenhuma criptomoeda encontrada'),
                  child: ListView.separated(
                    itemCount: viewmodel.cryptos.length,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) {
                      final model = viewmodel.cryptos[index];
                      return CoinCard(coinModel: model);
                    },
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
