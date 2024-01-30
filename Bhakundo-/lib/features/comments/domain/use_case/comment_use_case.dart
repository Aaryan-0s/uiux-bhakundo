import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../entity/comment_entity.dart';
import '../repository/comment_repository.dart';

final commentUsecaseProvider = Provider<CommentUseCase>(
  (ref) => CommentUseCase(
    commentRepository: ref.watch(commentRepositoryProvider),
  ),
);

class CommentUseCase {
  final ICommentRepository commentRepository;

  CommentUseCase({required this.commentRepository});

  Future<Either<Failure, List<CommentEntity>>> getComment(String fixtureId) {
    return commentRepository.getComment(fixtureId);
  }

  Future<Either<Failure, bool>> addComment(String fixtureId, String content) {
    return commentRepository.addComment(fixtureId, content);
  }

  Future<Either<Failure, bool>> deleteComment(String fixtureId, String id) {
    return commentRepository.deleteComment(fixtureId, id);
  }

  Future<Either<Failure, bool>> editComment(
      String fixtureId, String id, String content) {
    return commentRepository.editComment(fixtureId, id, content);
  }

  Future<Either<Failure, bool>> likeComment(String fixtureId, String id) {
    return commentRepository.likeComment(fixtureId, id);
  }
}
