import '../../domain/entity/standing_entity.dart';
import '../../domain/entity/standing_player_entity.dart';

class StandingState {
  final bool isLoading;
  final List<StandingEntity> standing;
  final List<StandingEntity> standingByid;
  final List<StandingPlayerEntity> standingPlayer;

  final String? error;

  StandingState({
    required this.isLoading,
    required this.standing,
    required this.standingByid,
    required this.standingPlayer,
    this.error,
  });

  factory StandingState.initial() {
    return StandingState(
      isLoading: false,
      standingByid: [],
      standing: [],
      standingPlayer: [],
    );
  }

  StandingState copyWith({
    bool? isLoading,
    List<StandingEntity>? standing,
    List<StandingPlayerEntity>? standingPlayer,
    List<StandingEntity>? standingByid,
    String? error,
  }) {
    return StandingState(
      isLoading: isLoading ?? this.isLoading,
      standingByid: standingByid ?? this.standingByid,
      standing: standing ?? this.standing,
      standingPlayer: standingPlayer ?? this.standingPlayer,
      error: error ?? this.error,
    );
  }
}
