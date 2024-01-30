const mongoose=require("mongoose")

const UserSchema=mongoose.Schema({
    fname: {
        type: String,
        required: true,
        trim: true,
      },
    lname: {
        type: String,
        required: true,
        trim: true,
      },
    username:{
        type:String,
        required:true,
        trim: true,
        
    },
    image: {
        type: String,
        default: "",
      },
    password:{
        type:String,
        required:true,
    },
    email:{
        type:String,
        required:true,
    },
    favourites: [
      {
      type: String,
      default: null,
      },
    ],
    favourites_players: [
      {
      type: String,
      default: null,
      },
    ],

    
},{timestamps:true});

module.exports=(mongoose.model("User",UserSchema))