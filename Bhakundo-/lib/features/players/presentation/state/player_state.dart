import '../../domain/entity/player_entity.dart';

class PlayerState {
  final bool isLoading;
  final List<PlayerEntity> player;
  final List<PlayerEntity> playerById;

  final String? error;

  PlayerState(
      {required this.isLoading,
      required this.player,
      required this.playerById,
      this.error,
      required});

  factory PlayerState.initial() {
    return PlayerState(
      isLoading: false,
      player: [],
      playerById: [],
    );
  }

  PlayerState copyWith({
    bool? isLoading,
    List<PlayerEntity>? player,
    List<PlayerEntity>? playerPlayer,
    List<PlayerEntity>? playerById,
    String? error,
  }) {
    return PlayerState(
      isLoading: isLoading ?? this.isLoading,
      player: player ?? this.player,
      playerById: playerById ?? this.playerById,
      error: error ?? this.error,
    );
  }
}
