// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_history_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CoinHistoryViewModel on ICoinHistoryViewModel, Store {
  late final _$historyAtom =
  Atom(name: 'ICoinHistoryViewModel.history', context: context);

  @override
  ObservableList<GraphModel> get history {
    _$historyAtom.reportRead();
    return super.history;
  }

  @override
  set history(ObservableList<GraphModel> value) {
    _$historyAtom.reportWrite(value, super.history, () {
      super.history = value;
    });
  }

  late final _$isLoadingAtom =
  Atom(name: 'ICoinHistoryViewModel.isLoading', context: context);

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
  Atom(name: 'ICoinHistoryViewModel.errorMessage', context: context);

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

  late final _$epochAtom =
  Atom(name: 'ICoinHistoryViewModel.epoch', context: context);

  @override
  GraphEpoch get epoch {
    _$epochAtom.reportRead();
    return super.epoch;
  }

  @override
  set epoch(GraphEpoch value) {
    _$epochAtom.reportWrite(value, super.epoch, () {
      super.epoch = value;
    });
  }

  late final _$fetchHistoryAsyncAction =
  AsyncAction('ICoinHistoryViewModel.fetchHistory', context: context);

  @override
  Future<void> fetchHistory({required String coinId, GraphEpoch? newEpoch}) {
    return _$fetchHistoryAsyncAction
        .run(() => super.fetchHistory(coinId: coinId, newEpoch: newEpoch));
  }

  @override
  String toString() {
    return '''
history: ${history},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
epoch: ${epoch}
    ''';
  }
}
