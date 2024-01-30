import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/use_case/standing_use_case.dart';
import '../state/standinig_state.dart';

final standingViewModelProvider =
    StateNotifierProvider<StandingViewModel, StandingState>(
  (ref) {
    return StandingViewModel(ref.read(standingUsecaseProvider));
  },
);

class StandingViewModel extends StateNotifier<StandingState> {
  final StandingUseCase standingUseCase;

  StandingViewModel(this.standingUseCase) : super(StandingState.initial()) {
    getAllStanding();
    getAllStandingPlayer();
  }

  getAllStanding() async {
    state = state.copyWith(isLoading: true);
    var data = await standingUseCase.getAllStanding();
    print(data);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) {
        state = state.copyWith(isLoading: false, standing: r, error: null);
      },
    );
  }

  getStandingByTeamId(String id) async {
    state = state.copyWith(isLoading: true);
    var data = await standingUseCase.getStandingByTeamId(id);
    print(data);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) {
        state = state.copyWith(isLoading: false, standingByid: r, error: null);
      },
    );
  }

  getAllStandingPlayer() async {
    state = state.copyWith(isLoading: true);
    var data = await standingUseCase.getAllStandingPlayer();

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) {
        state =
            state.copyWith(isLoading: false, standingPlayer: r, error: null);
      },
    );
  }
}
