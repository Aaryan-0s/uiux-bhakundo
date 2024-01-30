import '../../domain/entity/favourite_entity.dart';

class FavouritePlayerState {
  final bool isLoading;
  final List<FavouritePlayerEntity> favouritePlayer;
  final List<FavouritePlayerEntity> check;
  final String id;
  final List<FavouritePlayerEntity> response;

  final String? error;

  FavouritePlayerState({
    required this.isLoading,
    required this.favouritePlayer,
    required this.check,
    this.error,
    required this.id,
    required this.response,
  });

  factory FavouritePlayerState.initial() {
    return FavouritePlayerState(
      isLoading: false,
      check: [],
      favouritePlayer: [],
      error: null,
      id: '',
      response: [],
    );
  }

  FavouritePlayerState copyWith({
    bool? isLoading,
    List<FavouritePlayerEntity>? favouritePlayers,
    List<FavouritePlayerEntity>? check,
    String? error,
    String? id,
    List<FavouritePlayerEntity>? response,
  }) {
    return FavouritePlayerState(
      isLoading: isLoading ?? this.isLoading,
      favouritePlayer: favouritePlayers ?? favouritePlayer,
      check: check ?? this.check,
      error: error ?? this.error,
      id: id ?? this.id,
      response: response ?? this.response,
    );
  }
}
