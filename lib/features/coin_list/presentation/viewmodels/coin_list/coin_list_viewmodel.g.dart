// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_list_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CoinListViewModel on ICoinListViewModel, Store {
  late final _$currentQueryAtom =
  Atom(name: 'ICoinListViewModel.currentQuery', context: context);

  @override
  String get currentQuery {
    _$currentQueryAtom.reportRead();
    return super.currentQuery;
  }

  @override
  set currentQuery(String value) {
    _$currentQueryAtom.reportWrite(value, super.currentQuery, () {
      super.currentQuery = value;
    });
  }

  late final _$ICoinListViewModelActionController =
  ActionController(name: 'ICoinListViewModel', context: context);

  @override
  void init() {
    final _$actionInfo = _$ICoinListViewModelActionController.startAction(
        name: 'ICoinListViewModel.init');
    try {
      return super.init();
    } finally {
      _$ICoinListViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void refreshList({String? query}) {
    final _$actionInfo = _$ICoinListViewModelActionController.startAction(
        name: 'ICoinListViewModel.refreshList');
    try {
      return super.refreshList(query: query);
    } finally {
      _$ICoinListViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentQuery: ${currentQuery}
    ''';
  }
}
