import 'package:brasilcard/features/coin_list/data/models/coin_model.dart';
import 'package:mobx/mobx.dart';

import '../../../data/repositories/coin_list_repository.dart';

part 'coin_list_from_ids_viewmodel.g.dart';

class CoinListFromIdsViewModel = ICoinListFromIdsViewModel
    with _$CoinListFromIdsViewModel;

abstract class ICoinListFromIdsViewModel with Store {
  final ICoinListRepository _repository;

  ICoinListFromIdsViewModel(this._repository);

  @observable
  ObservableList<CoinModel> cryptos = ObservableList<CoinModel>();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future<void> getCryptos({required List<String> ids}) async {
    isLoading = true;
    errorMessage = null;

    final data = await _repository.getCoinListFromIds(ids: ids);

    data.when(
      success: (data) {
        cryptos = ObservableList.of(data);
        isLoading = false;
      },
      error: (error) {
        errorMessage = error.message;
        isLoading = false;
      },
    );
  }

  @action
  void removeCoin(String coinId) {
    cryptos.removeWhere((coin) => coin.id == coinId);
  }

  @action
  void clearCoins() => cryptos.clear();
}
