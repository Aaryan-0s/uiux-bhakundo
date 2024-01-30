import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/use_case/game_use_case.dart';
import '../state/game_state.dart';

final gameViewModelProvider = StateNotifierProvider<GameViewModel, GameState>(
  (ref) {
    return GameViewModel(ref.read(gameUsecaseProvider));
  },
);

class GameViewModel extends StateNotifier<GameState> {
  final GameUseCase gameUseCase;

  GameViewModel(this.gameUseCase) : super(GameState.initial()) {
    getAllGames();
  }

  getAllGames() async {
    state = state.copyWith(isLoading: true);
    var data = await gameUseCase.getAllGames();

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, games: r, error: null),
    );
  }

  getAllGameByDate(
    String season,
    String date,
  ) async {
    state = state.copyWith(isLoading: true);
    final result = await gameUseCase.getAllGameByDate(season, date);
    print(result);

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
      },
      (games) {
        state = state.copyWith(isLoading: false, games: games, error: null);
      },
    );
  }
}
