import '../../domain/entity/favourite_entity.dart';

class FavouriteState {
  final bool isLoading;
  final List<FavouriteEntity> favourite;
  final List<FavouriteEntity> check;
  final String id;
  final List<FavouriteEntity> response;

  final String? error;

  FavouriteState({
    required this.isLoading,
    required this.favourite,
    required this.check,
    this.error,
    required this.id,
    required this.response,
  });

  factory FavouriteState.initial() {
    return FavouriteState(
      isLoading: false,
      check: [],
      favourite: [],
      error: null,
      id: '',
      response: [],
    );
  }

  FavouriteState copyWith({
    bool? isLoading,
    List<FavouriteEntity>? favourites,
    List<FavouriteEntity>? check,
    String? error,
    String? id,
    List<FavouriteEntity>? response,
  }) {
    return FavouriteState(
      isLoading: isLoading ?? this.isLoading,
      favourite: favourites ?? favourite,
      check: check ?? this.check,
      error: error ?? this.error,
      id: id ?? this.id,
      response: response ?? this.response,
    );
  }
}
