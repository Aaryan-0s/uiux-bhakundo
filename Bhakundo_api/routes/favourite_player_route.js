const express = require('express');
const favourite_player_router = express.Router();
const auth = require("../middleware/auth");
const {getfavourite_player, addfavourite_player, removefavourite_player,getFavouritePlayerById} = require("../controller/favourite_player_controller");

// Get all favorite teams of a specific user
favourite_player_router.get('/favourites/player',auth, getfavourite_player);

favourite_player_router.get('/favourites/player/:id',auth, getFavouritePlayerById);

// Add a new favorite team for a specific user
favourite_player_router.post('/favourites/player/add',auth, addfavourite_player);

// Remove a favorite team for a specific user by teamId
favourite_player_router.delete('/unfavourite/player/:id',auth, removefavourite_player);


module.exports = favourite_player_router;
