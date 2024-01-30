import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/use_case/team_use_case.dart';
import '../state/team_state.dart';

final teamViewModelProvider = StateNotifierProvider<TeamViewModel, TeamState>(
  (ref) {
    return TeamViewModel(ref.read(teamUsecaseProvider));
  },
);

class TeamViewModel extends StateNotifier<TeamState> {
  final TeamUseCase teamUseCase;

  TeamViewModel(this.teamUseCase) : super(TeamState.initial());

  getAllTeam(String id) async {
    state = state.copyWith(isLoading: true);
    var data = await teamUseCase.getAllTeam(id);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) {
        state = state.copyWith(isLoading: false, team: r, error: null);
      },
    );
  }
}
