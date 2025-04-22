// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_details_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CoinDetailsViewModel on ICoinDetailsViewModel, Store {
  late final _$cryptoAtom = Atom(
    name: 'ICoinDetailsViewModel.crypto',
    context: context,
  );

  @override
  CoinModel? get crypto {
    _$cryptoAtom.reportRead();
    return super.crypto;
  }

  @override
  set crypto(CoinModel? value) {
    _$cryptoAtom.reportWrite(value, super.crypto, () {
      super.crypto = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: 'ICoinDetailsViewModel.isLoading',
    context: context,
  );

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

  late final _$errorMessageAtom = Atom(
    name: 'ICoinDetailsViewModel.errorMessage',
    context: context,
  );

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

  late final _$getDetailsAsyncAction = AsyncAction(
    'ICoinDetailsViewModel.getDetails',
    context: context,
  );

  @override
  Future<void> getDetails({required String coinId}) {
    return _$getDetailsAsyncAction.run(() => super.getDetails(coinId: coinId));
  }

  @override
  String toString() {
    return '''
crypto: ${crypto},
isLoading: ${isLoading},
errorMessage: ${errorMessage}
    ''';
  }
}
