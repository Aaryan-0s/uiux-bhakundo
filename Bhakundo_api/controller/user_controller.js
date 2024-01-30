const userModel = require("../models/user");
const bcrypt = require("bcrypt");
const e = require("express");
const jwt = require("jsonwebtoken");
const SECRET_KEY = "NBAAPI";
const commentModel = require("../models/comment");

const signup = async (req, res) => {
  const { username, email, password, image, fname, lname } = req.body;

  try {
    const existingUser = await userModel.findOne({ $or: [{ email: email }, { username: username }] });
    if (existingUser) {
      return res.status(400).json({
        message: "user already exist",
      });
    }
    const hashedPassword = await bcrypt.hash(password, 10);

    const result = await userModel.create({
      fname: fname,
      lname: lname,
      email: email,
      password: hashedPassword,
      username: username,
      image: image,
    });
    const token = jwt.sign(
      {
        email: result.email,
        id: result._id,
      },
      SECRET_KEY
    );
    res.status(201).json({
      user: result,

      message: "user created successfully",
    });
  } catch (error) {
    console.log(error);
    res.status(500).json({
      message: "Something went wrong",
    });
  }
};



const uploadImage = async (req, res) => {
 

  if (!req.file) {
    return res.status(400).send({ message: "Please upload a file" });
  }
  res.status(200).json({
    success: true,
    data: req.file.filename,
  });
};

const signin = async (req, res) => {
  const { username, password } = req.body;
  try {
    const existingUser = await userModel.findOne({ username: username });
    if (!existingUser) {
      return res.status(400).json({
        message: "user doesnt exist",
      });
    }

    const matchedPassword = await bcrypt.compare(
      password,
      existingUser.password
    );

    if (!matchedPassword) {
      return res.status(400).json({
        message: "incorrect password",
      });
    }

    const token = jwt.sign(
      {
        email: existingUser.email,
        id: existingUser._id,
      },
      SECRET_KEY,
      { expiresIn: "1d" }
    );

    res.status(201).json({
      success: true,
      existingUser,
      token,
    });
  } catch (error) {
    console.log(error);
    res.status(500).json({
      message: "Something went wrong",
    });
  }
};


const updateUserProfile = async (req, res) => {
  const userId = req.userId;
  const { fname, lname, email, username, image } = req.body;

  try {
    const user = await userModel.findById(userId);
    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }

    // Update the user fields if they are provided in the request body
    if (fname) {
      user.fname = fname;
    }
    if (lname) {
      user.lname = lname;
    }
    if (email) {
      user.email = email;
    }
    if (username) {
      user.username = username;
    }
    if (image) {
      user.image = image;
    }

    const updatedUser = await user.save();

    res.json({
      message: "Profile updated successfully",
      data:[updatedUser],
    });
  } catch (error) {
   
    res.status(500).json({
      message: "Something went wrong",
    });
  }
};


const getUserInfo = async (req, res) => {
  const userId = req.userId;

  try {
    const user = await userModel.findById(userId);
    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }

    const userInfo = {
      _id: user._id,
      fname: user.fname,
      lname: user.lname,
      email: user.email,
      username: user.username,
      image: user.image,
    };

    res.json({data:[userInfo]});
  } catch (error) {
    console.log(error);
    res.status(500).json({
      message: "Something went wrong",
    });
  }
};

const deleteCommentsByUserId = async (userId) => {
  try {
    await commentModel.deleteMany({ userId: userId });
    console.log("User's comments deleted successfully");
  } catch (error) {
    console.error(error);
    throw new Error("Failed to delete user's comments");
  }
};

const deleteUser = async (req, res) => {
  const userId = req.userId;
  try {
    const user = await userModel.findById(userId);
    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }

    // Delete the comments made by the user
    await deleteCommentsByUserId(userId);

    await userModel.deleteOne({ _id: userId });
    res.json({ message: "User deleted successfully" });
  } catch (error) {
    console.log(error);
    res.status(500).json({
      message: "Something went wrong",
    });
  }
};



// const deleteUser = async (req, res) => {
//   const userId=req.userId;
//   try{
//     const user=await userModel.findById(userId);
//     if(!user){
//       return res.status(404).json({error:"User not found"})
//     }
//     await userModel.deleteOne({ _id: userId });
//     res.json({message:"User deleted successfully"})


//   }catch(error){
//     console.log(error);
//     res.status(500).json({
//       message: "Something went wrong",
//     });
// };
// };

module.exports = {
  signup,
  signin,
  uploadImage,
  updateUserProfile,
  getUserInfo,
  deleteUser
};

