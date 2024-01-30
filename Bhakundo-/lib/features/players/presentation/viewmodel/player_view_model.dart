import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/use_case/player_use_case.dart';
import '../state/player_state.dart';

final playerViewModelProvider =
    StateNotifierProvider<PlayerViewModel, PlayerState>(
  (ref) {
    return PlayerViewModel(ref.read(playerUsecaseProvider));
  },
);

class PlayerViewModel extends StateNotifier<PlayerState> {
  final PlayerUseCase playerUseCase;

  PlayerViewModel(this.playerUseCase) : super(PlayerState.initial());

  getAllPlayer(String id) async {
    state = state.copyWith(isLoading: true);
    var data = await playerUseCase.getAllPlayer(id);
    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) {
        state = state.copyWith(isLoading: false, player: r, error: null);
      },
    );
  }

  getAllPlayerById(String id) async {
    state = state.copyWith(isLoading: true);
    var data = await playerUseCase.getAllPlayerById(id);
    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) {
        state = state.copyWith(isLoading: false, playerById: r, error: null);
      },
    );
  }
}
