import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/provider/internet_connectivity.dart';
import '../../../../core/failure/failure.dart';
import '../../data/repository/comment_remote_repository.dart';
import '../entity/comment_entity.dart';

final commentRepositoryProvider = Provider<ICommentRepository>(
  (ref) {
    // return ref.watch(commentLocalRepoProvider);
    // // Check for the internet
    final internetStatus = ref.watch(connectivityStatusProvider);
    return ref.watch(commentRemoteRepoProvider);

    // if (ConnectivityStatus.isConnected == internetStatus) {
    //   // If internet is available then return remote repo
    //   return ref.watch(commentRemoteRepoProvider);
    // } else {
    //   // If internet is not available then return local repo
    //   return ref.watch(commentRemoteRepoProvider);
    // }
  },
);

abstract class ICommentRepository {
  Future<Either<Failure, List<CommentEntity>>> getComment(String fixtureId);
  Future<Either<Failure, bool>> addComment(String fixtureId, String content);
  Future<Either<Failure, bool>> deleteComment(String fixtureId, String id);
  Future<Either<Failure, bool>> editComment(
      String fixtureId, String id, String content);
  Future<Either<Failure, bool>> likeComment(String fixtureId, String id);
}
