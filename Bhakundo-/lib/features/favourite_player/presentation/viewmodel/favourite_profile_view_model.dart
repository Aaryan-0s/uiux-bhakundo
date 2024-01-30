import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/favourite_entity.dart';
import '../../domain/use_case/favourite_use_case.dart';
import '../state/favourite_state.dart';

final favouritePlayerViewModelProvider =
    StateNotifierProvider<FavouritePlayerViewModel, FavouritePlayerState>(
  (ref) => FavouritePlayerViewModel(ref.read(favouritePlayerUsecaseProvider)),
);

class FavouritePlayerViewModel extends StateNotifier<FavouritePlayerState> {
  final FavouritePlayerUseCase favouritePlayerUseCase;

  FavouritePlayerViewModel(this.favouritePlayerUseCase)
      : super(FavouritePlayerState.initial());

  addfavouritePlayer(FavouritePlayerEntity favouritePlayer) async {
    state = state.copyWith(isLoading: true);
    var data = await favouritePlayerUseCase.addFavouritePlayer(favouritePlayer);

    data.fold((l) => state = state.copyWith(isLoading: false, error: l.error),
        (r) {
      state = state.copyWith(isLoading: false, response: r, error: null);
    });
  }

  removeFavouritePlayer(String id) async {
    state = state.copyWith(isLoading: true);
    var data = await favouritePlayerUseCase.removeFavouritePlayer(id);
    data.fold((l) => state = state.copyWith(isLoading: false, error: l.error),
        (r) {
      state = state.copyWith(isLoading: false, error: null);
    });
  }

  getfavouritePlayer() async {
    state = state.copyWith(isLoading: true);
    var data = await favouritePlayerUseCase.getFavouritePlayer();
    data.fold((l) => state = state.copyWith(isLoading: false, error: l.error),
        (r) {
      state = state.copyWith(isLoading: false, check: r, error: null);
    });
  }
}
