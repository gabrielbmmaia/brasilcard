import 'package:brasilcard/features/coin_list/data/models/coin_model.dart';
import 'package:brasilcard/features/coin_list/data/repositories/coin_list_repository.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mobx/mobx.dart';

part 'coin_list_viewmodel.g.dart';

class CoinListViewModel = ICoinListViewModel with _$CoinListViewModel;

abstract class ICoinListViewModel with Store {
  final ICoinListRepository _repository;

  ICoinListViewModel(this._repository);

  static const int _pageSize = 20;

  final PagingController<int, CoinModel> pagingController = PagingController(
    firstPageKey: 0,
  );

  @observable
  String currentQuery = '';

  @action
  void init() {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @action
  void refreshList({String? query}) {
    currentQuery = query ?? '';
    pagingController.refresh();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final result = await _repository.getCoinList(
        query: currentQuery.isNotEmpty ? currentQuery : null,
        limit: _pageSize,
        offset: pageKey,
      );

      result.when(
        success: (newItems) {
          final isLastPage = newItems.length < _pageSize;
          if (isLastPage) {
            pagingController.appendLastPage(newItems);
          } else {
            final nextPageKey = pageKey + newItems.length;
            pagingController.appendPage(newItems, nextPageKey);
          }
        },
        error: (error) {
          pagingController.error = error.message;
        },
      );
    } catch (e) {
      pagingController.error = e.toString();
    }
  }

  void dispose() => pagingController.dispose();
}
