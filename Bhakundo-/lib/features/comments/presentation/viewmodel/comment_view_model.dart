import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/use_case/comment_use_case.dart';
import '../state/comment_state.dart';

final commentViewModelProvider =
    StateNotifierProvider<CommentViewModel, CommentState>(
  (ref) {
    return CommentViewModel(ref.read(commentUsecaseProvider));
  },
);

class CommentViewModel extends StateNotifier<CommentState> {
  final CommentUseCase commentUseCase;

  CommentViewModel(this.commentUseCase) : super(CommentState.initial());

  getComment(String fixtureId) async {
    state = state.copyWith(isLoading: true);
    var data = await commentUseCase.getComment(fixtureId);
    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) {
        state = state.copyWith(isLoading: false, comment: r, error: null);
      },
    );
  }

  addComment(String fixtureId, String content) async {
    state = state.copyWith(isLoading: true);
    var data = await commentUseCase.addComment(fixtureId, content);
    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) {
        state = state.copyWith(isLoading: false, error: null);
      },
    );
  }

  deleteComment(String fixtureId, String id) async {
    state = state.copyWith(isLoading: true);
    var data = await commentUseCase.deleteComment(fixtureId, id);
    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) {
        state = state.copyWith(isLoading: false, error: null);
      },
    );
  }

  editComment(String fixtureId, String id, String context) async {
    state = state.copyWith(isLoading: true);
    var data = await commentUseCase.editComment(fixtureId, id, context);
    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) {
        state = state.copyWith(isLoading: false, error: null);
      },
    );
  }

  likeComment(String fixtureId, String id) async {
    state = state.copyWith(isLoading: true);
    var data = await commentUseCase.likeComment(fixtureId, id);
    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) {
        state = state.copyWith(isLoading: false, error: null);
      },
    );
  }
}
