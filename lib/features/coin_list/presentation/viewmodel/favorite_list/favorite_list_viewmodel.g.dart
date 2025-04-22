// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_list_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FavoriteListViewModel on IFavoriteListViewModel, Store {
  late final _$favoriteCoinsIdAtom =
      Atom(name: 'IFavoriteListViewModel.favoriteCoinsId', context: context);

  @override
  ObservableList<String> get favoriteCoinsId {
    _$favoriteCoinsIdAtom.reportRead();
    return super.favoriteCoinsId;
  }

  @override
  set favoriteCoinsId(ObservableList<String> value) {
    _$favoriteCoinsIdAtom.reportWrite(value, super.favoriteCoinsId, () {
      super.favoriteCoinsId = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: 'IFavoriteListViewModel.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'IFavoriteListViewModel.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$loadFavoritesAsyncAction =
      AsyncAction('IFavoriteListViewModel.loadFavorites', context: context);

  @override
  Future<void> loadFavorites() {
    return _$loadFavoritesAsyncAction.run(() => super.loadFavorites());
  }

  late final _$unFavoriteAllAsyncAction =
      AsyncAction('IFavoriteListViewModel.unFavoriteAll', context: context);

  @override
  Future<void> unFavoriteAll() {
    return _$unFavoriteAllAsyncAction.run(() => super.unFavoriteAll());
  }

  late final _$toggleFavoriteAsyncAction =
      AsyncAction('IFavoriteListViewModel.toggleFavorite', context: context);

  @override
  Future<void> toggleFavorite(String coinId) {
    return _$toggleFavoriteAsyncAction.run(() => super.toggleFavorite(coinId));
  }

  @override
  String toString() {
    return '''
favoriteCoinsId: ${favoriteCoinsId},
errorMessage: ${errorMessage},
isLoading: ${isLoading}
    ''';
  }
}
