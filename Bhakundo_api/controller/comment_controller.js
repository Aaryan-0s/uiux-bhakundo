

const commentModel = require("../models/comment");
const userModel = require("../models/user");

const createComment = async (req, res) => {
  try {
    const { content } = req.body;
    const gameId = req.params.gameId;
    const userId = req.userId;

    // Create a new comment

    const comment = new commentModel({
      content,
      userId,
      gameId,
      likes: [],
      likeCount: 0 // Initialize likes as an empty array
    });

    await comment.save();

    res.status(200).json(comment);
  } catch (error) {
    res.status(500).json({ error: "Failed to create comment" });
    console.log(error);
  }
};




// Rest of the code remains the same



const updateComment = async (req, res) => {
  try {
    const { id, gameId } = req.params;
    const userId = req.userId;
    const { content } = req.body;

    // Find the comment by ID
    const comment = await commentModel.findOne({ _id: id, gameId: gameId });

    // Update the comment content
    if (comment.userId == userId) {
      comment.content = content;
      comment.updatedAt = Date.now();
      await comment.save();
    } else {
      return res.status(401).json({ error: "You are not authorized to update this comment" });
    }

    res.json(comment);
  } catch (error) {
    res.status(500).json({ error: "Failed to update comment" });
    console.log(error)
  }
};


const deleteComment = async (req, res) => {
  try {
    const { gameId, id } = req.params;
    const userId = req.userId;

    // Find the comment by ID and gameId
    const comment = await commentModel.findOne({ _id: id, gameId: gameId });

    // Check if the comment exists and the user is authorized to delete it
    if (!comment) {
      return res.status(404).json({ error: "Comment not found" });
    }

    // Check if the user is authorized to delete the comment
    if (comment.userId.toString() !== userId) {
      return res.status(401).json({ error: "You are not authorized to delete this comment" });
    }

    // Remove the comment and its child comments recursively
    await comment.deleteOne();

    res.json({ message: "Comment deleted successfully" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to delete comment" });
  }
};


const toggleCommentLike = async (req, res) => {
  try {
    const { id, gameId } = req.params;
    const userId = req.userId;

    // Find the comment by ID and gameId, populate the likes field
    const comment = await commentModel.findOne({ _id: id, gameId: gameId }).populate('likes');

    // Check if the comment exists
    if (!comment) {
      return res.status(404).json({ error: "Comment not found" });
    }

    console.log("comment:", comment);

    // Check if the user has already liked the comment
    const likedIndex = comment.likes.findIndex((user) => user._id.toString() === req.userId);

    console.log("likedIndex:", likedIndex);

    if (likedIndex !== -1) {
      // User has already liked the comment, remove the like
      comment.likes.splice(likedIndex, 1);
      comment.likeCount -= 1;
    } else {
      // User has not liked the comment, add the like
      comment.likes.push(userId);
      comment.likeCount += 1;
    }

    await comment.save();

    res.json(comment);
  } catch (error) {
    res.status(500).json({ error: "Failed to toggle comment like", errorMessage: error.message });
  }
};





const getComment = async (req, res) => {
  try {
    // Retrieve all comments in descending order of createdAt (newest first)
    const { gameId } = req.params;
    const comments = await commentModel
      .find({ gameId })
      .sort({ createdAt: -1 })
      .populate('userId', 'username image'); // Include user's name and image

    res.json(comments);
  } catch (error) {
    res.status(500).json({ error: "Failed to get comments" });
  }
};

module.exports = {
  createComment,
  updateComment,
  deleteComment,
  getComment,
  toggleCommentLike,

};
