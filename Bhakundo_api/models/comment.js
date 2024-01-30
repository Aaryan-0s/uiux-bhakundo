const mongoose = require('mongoose');

const commentSchema = mongoose.Schema(
  {
    content: {
      type: String,
      required: true
    },
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true
    },
    createdAt: {
      type: Date,
      default: Date.now,
      required: true
    },
    updatedAt: {
      type: Date,
      default: Date.now,
      required: true
    },
    gameId: {
      type: String,
      required: true
    },
   
    likes: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        default: [],
      },
    ],
    likeCount: {
      type: Number,
      default: 0
    }
  },
  {
    timestamps: true
  }
);


const Comment = mongoose.model('Comment', commentSchema);

module.exports = Comment;
