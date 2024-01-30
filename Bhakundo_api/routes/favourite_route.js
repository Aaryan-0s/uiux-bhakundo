const express = require('express');
const favouriterouter = express.Router();
const auth = require("../middleware/auth");
const {getfavourite, addfavourite, removefavourite,getfavouriteTeamById} = require("../controller/favourite_controller");


// Get all favorite teams of a specific user
favouriterouter.get('/favourites',auth, getfavourite);
favouriterouter.get('/favourites/:id',auth, getfavouriteTeamById);

// Add a new favorite team for a specific user
favouriterouter.post('/favourites/add',auth, addfavourite);

// Remove a favorite team for a specific user by teamId
favouriterouter.delete('/unfavourite/:id',auth, removefavourite);


module.exports = favouriterouter;
