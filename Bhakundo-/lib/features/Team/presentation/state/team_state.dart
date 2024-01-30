import '../../domain/entity/team_entity.dart';

class TeamState {
  final bool isLoading;
  final List<TeamEntity> team;

  final String? error;

  TeamState({
    required this.isLoading,
    required this.team,
    this.error,
  });

  factory TeamState.initial() {
    return TeamState(
      isLoading: false,
      team: [],
    );
  }

  TeamState copyWith({
    bool? isLoading,
    List<TeamEntity>? team,
    List<TeamEntity>? teamPlayer,
    String? error,
  }) {
    return TeamState(
      isLoading: isLoading ?? this.isLoading,
      team: team ?? this.team,
      error: error ?? this.error,
    );
  }
}
