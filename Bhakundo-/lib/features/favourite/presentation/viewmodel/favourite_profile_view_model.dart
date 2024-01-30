import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/favourite_entity.dart';
import '../../domain/use_case/favourite_use_case.dart';
import '../state/favourite_state.dart';

final favouriteViewModelProvider =
    StateNotifierProvider<FavouriteViewModel, FavouriteState>(
  (ref) => FavouriteViewModel(ref.read(favouriteUsecaseProvider)),
);

class FavouriteViewModel extends StateNotifier<FavouriteState> {
  final FavouriteUseCase favouriteUseCase;

  FavouriteViewModel(this.favouriteUseCase) : super(FavouriteState.initial());

  addfavourite(FavouriteEntity favourite) async {
    state = state.copyWith(isLoading: true);
    var data = await favouriteUseCase.addFavourite(favourite);

    data.fold((l) => state = state.copyWith(isLoading: false, error: l.error),
        (r) {
      state = state.copyWith(isLoading: false, response: r, error: null);
    });
  }

  removeFavourite(String id) async {
    state = state.copyWith(isLoading: true);
    var data = await favouriteUseCase.removeFavourite(id);
    data.fold((l) => state = state.copyWith(isLoading: false, error: l.error),
        (r) {
      state = state.copyWith(isLoading: false, error: null);
    });
  }

  getfavourite() async {
    state = state.copyWith(isLoading: true);
    var data = await favouriteUseCase.getFavourite();
    data.fold((l) => state = state.copyWith(isLoading: false, error: l.error),
        (r) {
      state = state.copyWith(isLoading: false, check: r, error: null);
    });
  }
}
