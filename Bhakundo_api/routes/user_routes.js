const express = require("express");
const {
  signin,
  signup,
  uploadImage,
  updateUserProfile,
  getUserInfo,
  deleteUser
} = require("../controller/user_controller");

const userRouter = express.Router();
const upload = require("../middleware/uploads");
const auth = require("../middleware/auth");

userRouter.post("/signup", signup);

userRouter.put("/profile/update", auth, updateUserProfile);
userRouter.post("/uploadImage", upload, uploadImage);

userRouter.post("/login", signin);


userRouter.get("/info/get", auth, getUserInfo);
userRouter.delete('/delete', auth, deleteUser)

module.exports = userRouter;
