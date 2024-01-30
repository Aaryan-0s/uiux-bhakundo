const express=require("express");
const { getComment, createComment, deleteComment, updateComment,toggleCommentLike} = require("../controller/comment_controller");
const auth = require("../middleware/auth");
const commentRouter=express.Router();

commentRouter.get("/:gameId",auth,getComment);


commentRouter.post("/:gameId",auth,createComment);

commentRouter.delete("/:gameId/:id",auth,deleteComment);
 
commentRouter.put("/:gameId/:id",auth,updateComment);


commentRouter.post('/:gameId/:id/like',auth, toggleCommentLike);




module.exports=commentRouter;