import 'package:brasilcard/features/coin_list/data/models/coin_model.dart';
import 'package:mobx/mobx.dart';

import '../../../data/repositories/coin_details_repository.dart';

part 'coin_details_viewmodel.g.dart';

class CoinDetailsViewModel = ICoinDetailsViewModel with _$CoinDetailsViewModel;

abstract class ICoinDetailsViewModel with Store {
  final ICoinDetailsRepository _repository;

  ICoinDetailsViewModel(this._repository);

  @observable
  CoinModel? crypto;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future<void> getDetails({required String coinId}) async {
    isLoading = true;
    errorMessage = null;

    final data = await _repository.getCoinDetails(coinId: coinId);

    data.when(
      success: (data) {
        crypto = data;
        isLoading = false;
      },
      error: (error) {
        errorMessage = error.message;
        isLoading = false;
      },
    );
  }
}
