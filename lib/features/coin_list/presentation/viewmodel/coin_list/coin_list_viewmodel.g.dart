// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_list_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CoinListViewModel on ICoinListViewModel, Store {
  late final _$cryptosAtom =
      Atom(name: 'ICoinListViewModel.cryptos', context: context);

  @override
  ObservableList<CoinModel> get cryptos {
    _$cryptosAtom.reportRead();
    return super.cryptos;
  }

  @override
  set cryptos(ObservableList<CoinModel> value) {
    _$cryptosAtom.reportWrite(value, super.cryptos, () {
      super.cryptos = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'ICoinListViewModel.isLoading', context: context);

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

  late final _$errorMessageAtom =
      Atom(name: 'ICoinListViewModel.errorMessage', context: context);

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

  late final _$getCryptosAsyncAction =
      AsyncAction('ICoinListViewModel.getCryptos', context: context);

  @override
  Future<void> getCryptos({String? query}) {
    return _$getCryptosAsyncAction.run(() => super.getCryptos(query: query));
  }

  @override
  String toString() {
    return '''
cryptos: ${cryptos},
isLoading: ${isLoading},
errorMessage: ${errorMessage}
    ''';
  }
}
