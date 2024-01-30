import '../../domain/entity/comment_entity.dart';

class CommentState {
  final bool isLoading;
  final List<CommentEntity> comment;
  final List<CommentEntity> like;

  final String? error;

  CommentState(
      {required this.isLoading,
      required this.comment,
      this.error,
      required,
      required this.like});

  factory CommentState.initial() {
    return CommentState(
      isLoading: false,
      comment: [],
      error: null,
      like: [],
    );
  }

  CommentState copyWith({
    bool? isLoading,
    List<CommentEntity>? comment,
    List<CommentEntity>? commentComment,
    String? error,
    List<CommentEntity>? like,
  }) {
    return CommentState(
      isLoading: isLoading ?? this.isLoading,
      comment: comment ?? this.comment,
      error: error ?? this.error,
      like: like ?? this.like,
    );
  }
}
