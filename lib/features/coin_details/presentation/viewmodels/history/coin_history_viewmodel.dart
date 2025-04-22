import 'package:brasilcard/features/coin_details/data/models/graph_epoch.dart';
import 'package:brasilcard/features/coin_details/data/models/graph_model.dart';
import 'package:mobx/mobx.dart';

import '../../../data/repositories/coin_history_repository.dart';

part 'coin_history_viewmodel.g.dart';

class CoinHistoryViewModel = ICoinHistoryViewModel with _$CoinHistoryViewModel;

abstract class ICoinHistoryViewModel with Store {
  final ICoinHistoryRepository repository;

  ICoinHistoryViewModel(this.repository);

  @observable
  ObservableList<GraphModel> history = ObservableList<GraphModel>();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  GraphEpoch epoch = GraphEpoch.last90Days();

  @action
  Future<void> fetchHistory({
    required String coinId,
    GraphEpoch? newEpoch,
  }) async {
    isLoading = true;
    errorMessage = null;

    final result = await repository.getCoinHistory(
      coinId: coinId,
      epoch: newEpoch ?? epoch,
    );

    result.when(
      success: (data) {
        history = ObservableList.of(data);
        if (newEpoch != null) {
          epoch = newEpoch;
        }
        isLoading = false;
      },
      error: (error) {
        errorMessage = error.message;
        isLoading = false;
      },
    );
  }

  GraphEpoch mapEpochToGraphEpoch(String label) {
    return switch (label) {
      '30 dias' => GraphEpoch.last30Days(),
      '90 dias' => GraphEpoch.last90Days(),
      '180 dias' => GraphEpoch.last180Days(),
      '1 ano' => GraphEpoch.lastYear(),
      '2 anos' => GraphEpoch.last2Years(),
      _ => GraphEpoch.last90Days(),
    };
  }

  String mapGraphEpochToString(GraphEpoch epoch) {
    return switch (epoch) {
      GraphEpoch.last30Days => '30 dias',
      GraphEpoch.last90Days => '90 dias',
      GraphEpoch.last180Days => '180 dias',
      GraphEpoch.lastYear => '1 ano',
      GraphEpoch.last2Years => '2 anos',
      _ => '90 dias',
    };
  }
}
