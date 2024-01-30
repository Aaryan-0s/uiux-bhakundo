import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nba_hub/features/comments/domain/entity/comment_entity.dart';
import 'package:nba_hub/features/profile/domain/entity/profile_entity.dart';
import 'package:nba_hub/features/profile/presentation/viewmodel/profile_view_model.dart';

import '../viewmodel/comment_view_model.dart';

class FixtureComment extends ConsumerStatefulWidget {
  final String fixtureId;
  const FixtureComment({Key? key, required this.fixtureId}) : super(key: key);

  @override
  ConsumerState<FixtureComment> createState() => _FixtureCommentState();
}

class _FixtureCommentState extends ConsumerState<FixtureComment> {
  @override
  void initState() {
    super.initState();

    Future(() async {
      await ref
          .watch(commentViewModelProvider.notifier)
          .getComment(widget.fixtureId);
      await ref.watch(profileInfoViewModelProvider.notifier).getProfile();
    });
  }

  TextEditingController commentController = TextEditingController();
  TextEditingController replyController = TextEditingController();
  bool showReplyField = false;
  int selectedCommentIndex = -1;
  String originalComment = '';

  @override
  void dispose() {
    commentController.dispose();
    replyController.dispose();
    super.dispose();
  }

  void addComment(String content) {
    if (content.isNotEmpty) {
      ref.watch(commentViewModelProvider.notifier).addComment(
            content,
            widget.fixtureId,
          );

      commentController.clear();
      ref.watch(commentViewModelProvider.notifier).getComment(widget.fixtureId);
    }
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, CommentEntity comment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Comment'),
          content: const Text('Are you sure you want to delete this comment?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await ref
                    .watch(commentViewModelProvider.notifier)
                    .deleteComment(widget.fixtureId, comment.id);

                ref
                    .read(commentViewModelProvider.notifier)
                    .getComment(widget.fixtureId);

                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void editComment(String commentId, String newContent) async {
    if (newContent.isNotEmpty) {
      await ref
          .watch(commentViewModelProvider.notifier)
          .editComment(widget.fixtureId, commentId, newContent);
      ref.watch(commentViewModelProvider.notifier).getComment(widget.fixtureId);
    }
  }

  bool isCommentLiked(CommentEntity comment, ProfileEntity user) {
    for (int i = 0; i < comment.likes.length; i++) {
      if (comment.likes[i] == user.userId) {
        return true;
      }
    }
    return false;
  }

  void toggleLikeComment(fixtureId, String id) async {
    await ref
        .watch(commentViewModelProvider.notifier)
        .likeComment(fixtureId, id);
    ref.watch(commentViewModelProvider.notifier).getComment(widget.fixtureId);
  }

  @override
  Widget build(BuildContext context) {
    var comment = ref.watch(commentViewModelProvider);
    var user = ref.watch(profileInfoViewModelProvider);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: comment.comment.length,
              itemBuilder: (context, index) {
                final comments = comment.comment[index];
                return Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: _buildCommentTile(comments, index, user.profile[0]),
                );
              },
            ),
          ),
          if (selectedCommentIndex == -1) _buildCommentTextField(),
        ],
      ),
    );
  }

  Widget _buildCommentTile(
      CommentEntity comment, int commentIndex, ProfileEntity user) {
    bool isEditing = selectedCommentIndex == commentIndex;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.network(
                "http://192.168.137.1:3001/uploads/${comment.userId.image}",
                fit: BoxFit.cover,
              )),
          title: Text(
            comment.userId.username,
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: isEditing
              ? SizedBox(
                  width: double.infinity,
                  child: TextField(
                    controller: commentController,
                    decoration: const InputDecoration(
                      labelText: 'Edit Comment',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) {
                      editComment(comment.id, value);
                      selectedCommentIndex = -1;
                    },
                  ),
                )
              : Text(
                  comment.content,
                  style: const TextStyle(color: Colors.white),
                ),
          trailing: !isEditing
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        isCommentLiked(comment, user)
                            ? Icons.thumb_up
                            : Icons.thumb_up_outlined,
                        color: isCommentLiked(comment, user)
                            ? Colors.white
                            : Colors.grey,
                      ),
                      onPressed: () {
                        toggleLikeComment(widget.fixtureId, comment.id);
                      },
                    ),
                    Text(
                      '${comment.likeCount}', // Display the like count
                      style: const TextStyle(color: Colors.white),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          commentController.text = comment.content;
                          selectedCommentIndex = commentIndex;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.white),
                      onPressed: () {
                        _showDeleteConfirmationDialog(context, comment);
                      },
                    ),
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.cancel, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          commentController.text = originalComment;
                          selectedCommentIndex = -1;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () {
                        editComment(comment.id, commentController.text);
                        setState(() {
                          selectedCommentIndex = -1;
                          commentController.clear();
                        });
                      },
                    ),
                  ],
                ),
        ),
        const SizedBox(height: 8.0),
        const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Column(
            children: [],
          ),
        ),
      ],
    );
  }

  Widget _buildCommentTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: commentController,
              decoration: const InputDecoration(
                labelText: 'Comment',
                filled: true,
                fillColor: Colors.white,
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (value) {
                addComment(value);
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            color: Colors.white,
            onPressed: () {
              addComment(commentController.text);
            },
          ),
        ],
      ),
    );
  }
}

class Comment {
  final String userName;
  final String comment;
  final List<Comment> replies;
  int upvotes;

  Comment({
    required this.userName,
    required this.comment,
    this.replies = const [],
    this.upvotes = 0,
  });
}
