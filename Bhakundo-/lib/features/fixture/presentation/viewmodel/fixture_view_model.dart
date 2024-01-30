import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/use_case/fixture_use_case.dart';
import '../state/fixture_state.dart';

final fixtureViewModelProvider =
    StateNotifierProvider<FixtureViewModel, FixtureState>(
  (ref) {
    return FixtureViewModel(ref.read(fixtureUsecaseProvider));
  },
);

class FixtureViewModel extends StateNotifier<FixtureState> {
  final FixtureUseCase fixtureUseCase;

  FixtureViewModel(this.fixtureUseCase) : super(FixtureState.initial());

  getFixtureById(
    String id,
  ) async {
    state = state.copyWith(isLoading: true);
    final result = await fixtureUseCase.getFixtureById(id);

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
      },
      (fixtures) {
        state =
            state.copyWith(isLoading: false, fixture: fixtures, error: null);
      },
    );
  }

  getFixtureInfo(
    String id,
  ) async {
    state = state.copyWith(isLoading: true);
    final result = await fixtureUseCase.getFixtureInfo(id);

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
      },
      (fixturesInfo) {
        state = state.copyWith(
            isLoading: false, fixtureInfo: fixturesInfo, error: null);
      },
    );
  }
}
