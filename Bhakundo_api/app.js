require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose")
const userRouter = require("./routes/user_routes");
const commentRouter = require("./routes/Comment_route");
const footballRoutes = require('./routes/football-route');
const favouriterouter = require('./routes/favourite_route');
const favourite_player_router = require('./routes/favourite_player_route');

const cors=require('cors');


const MONGODB_URI =
    process.env.NODE_ENV === "test"
        ? process.env.TEST_DB_URI
        : process.env.DB_URI;

        
        

mongoose.connect(MONGODB_URI).then(() => {
    console.log(`connected to db${MONGODB_URI}`)
})
    .catch((error) => {
        console.log(error)
    });


const app = express();
app.use(cors());

app.use(express.json())
app.use(express.static("public"));



app.use("/api/v1/auth", userRouter)
app.use("/api/v1/comment", commentRouter)
app.use("/api/v1/football", footballRoutes)
app.use("/api/v1/teams",favouriterouter)
app.use("/api/v1/players",favourite_player_router)



// Error Handling
app.use((err, req, res, next) => {
    console.error(err);
    if (err.name === "ValidationError") res.status(400);
    else if (err.name === "CastError") res.status(400);
    res.json({ error: err.message });
});

// Unknown Path
app.use((req, res) => {
    res.status(404).json({ error: "Path Not Found" });
});

module.exports = app;