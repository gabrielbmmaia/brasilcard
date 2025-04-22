import 'package:brasilcard/features/coin_list/repositories/favorite_list_repository.dart';
import 'package:mobx/mobx.dart';

part 'favorite_list_viewmodel.g.dart';

class FavoriteListViewModel = IFavoriteListViewModel
    with _$FavoriteListViewModel;

abstract class IFavoriteListViewModel with Store {
  final IFavoriteListRepository _repository;

  IFavoriteListViewModel(this._repository);

  @observable
  ObservableList<String> favoriteCoinsId = ObservableList<String>();

  @observable
  String? errorMessage;

  @observable
  bool isLoading = true;

  @action
  Future<void> loadFavorites() async {
    final coins = await _repository.getFavoriteCoinsId();
    coins.when(
      success: (data) {
        favoriteCoinsId = ObservableList.of(data);
        isLoading = false;
      },
      error: (error) {
        errorMessage = error.message;
        isLoading = false;
      },
    );
  }

  @action
  Future<void> unFavoriteAll() async {
    isLoading = true;
    final coins = await _repository.clearFavoriteCoins();
    coins.whenNullable(
      success: (_) {
        favoriteCoinsId.clear();
        isLoading = false;
      },
      error: (error) {
        errorMessage = error.message;
        isLoading = false;
      },
    );
  }

  @action
  Future<void> toggleFavorite(String coinId) async {
    isLoading = true;
    if (isFavorite(coinId)) {
      await _repository.deleteFavoriteCoin(coinId: coinId);
      favoriteCoinsId.removeWhere((e) => e == coinId);
      isLoading = false;
    } else {
      await _repository.saveFavoriteCoins(coinId: coinId);
      favoriteCoinsId.add(coinId);
      isLoading = false;
    }
  }

  bool isFavorite(String coinId) => favoriteCoinsId.any((e) => e == coinId);
}
