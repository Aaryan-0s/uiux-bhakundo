import 'package:nba_hub/features/games/domain/entity/game_entity.dart';

class GameState {
  final bool isLoading;
  final List<GameEntity> games;

  final String? error;

  GameState({
    required this.isLoading,
    required this.games,
    this.error,
  });

  factory GameState.initial() {
    return GameState(
      isLoading: false,
      games: [],
    );
  }

  GameState copyWith({
    bool? isLoading,
    List<GameEntity>? games,
    String? error,
  }) {
    return GameState(
      isLoading: isLoading ?? this.isLoading,
      games: games ?? this.games,
      error: error ?? this.error,
    );
  }
}
