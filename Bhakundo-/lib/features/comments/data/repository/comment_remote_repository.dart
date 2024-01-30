import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/comment_entity.dart';
import '../../domain/repository/comment_repository.dart';
import '../data_source/comment_remote_data_source.dart';

final commentRemoteRepoProvider = Provider<ICommentRepository>(
  (ref) => CommentRemoteRepositoryImpl(
    commentRemoteDataSource: ref.read(commentRemoteDataSourceProvider),
  ),
);

class CommentRemoteRepositoryImpl implements ICommentRepository {
  final CommentRemoteDataSource commentRemoteDataSource;

  CommentRemoteRepositoryImpl({required this.commentRemoteDataSource});

  @override
  Future<Either<Failure, List<CommentEntity>>> getComment(String fixtureId) {
    return commentRemoteDataSource.getComment(fixtureId);
  }

  @override
  Future<Either<Failure, bool>> addComment(String fixtureId, String content) {
    return commentRemoteDataSource.addComment(fixtureId, content);
  }

  @override
  Future<Either<Failure, bool>> deleteComment(String fixtureId, String id) {
    return commentRemoteDataSource.deleteComment(fixtureId, id);
  }

  @override
  Future<Either<Failure, bool>> editComment(
      String fixtureId, String id, String content) {
    return commentRemoteDataSource.editComment(fixtureId, id, content);
  }

  @override
  Future<Either<Failure, bool>> likeComment(String fixtureId, String id) {
    return commentRemoteDataSource.likeComment(fixtureId, id);
  }
}
