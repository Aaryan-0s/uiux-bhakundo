const favourite_player_model = require("../models/favourite_player");
const User_model = require("../models/user");

// Controller method to get all players in the user's favourite
const getfavourite_player = async (req, res, next) => {
  try {
    const userId = req.userId; // Assuming you have middleware to extract the user ID

    const favourite_player = await favourite_player_model.find({ user: userId });

    res.json({data : favourite_player});
  } catch (err) {
    next(err);
  }
};


// Controller method to add a movie to the user's favourite_player
const addfavourite_player = async (req, res, next) => {
  try {
    const userId = req.userId; // Assuming you have middleware to extract the user ID
    const { playerId, playerName, photoUrl } = req.body;

    const user = await User_model.findById(userId);

    // Check if the player already exists in user's favorites
    if (user.favourites_players.includes(playerId)) {
      return res.status(400).json({ error: 'player is already favorited' });
    }

    const favourite_player = new favourite_player_model({
      user: userId,
      playerId: playerId,
      playerName: playerName,
      photoUrl: photoUrl,
    });

    user.favourites_players.push(playerId);
    await user.save();

    await favourite_player.save();

    res.json({ data: [favourite_player] });
  } catch (err) {
    next(err);
  }
};

  

// Controller method to remove a movie from the user's favourite_player
const removefavourite_player = async (req, res, next) => {
    try {
        const userId = req.userId; // Assuming you have middleware to extract the user ID
        const playerId = req.params.id;

        const user = await User_model.findById(userId);


        const favourite_player = await favourite_player_model.findOneAndDelete({ user: userId, playerId });

        user.favourites_players = user.favourites_players.filter(
          (favourites_players) => favourites_players.toString() !== playerId
        );
        await user.save();
    
        res.json({message:"deleted"});
    } catch (err) {
        next(err);
    }
};

const getFavouritePlayerById = async (req, res, next) => {
  try {
    const userId = req.userId; // Assuming you have middleware to extract the user ID
    const playerId = req.params.id; // Assuming the player ID is passed as a URL parameter

    const favoritePlayer = await favourite_player_model.findOne({ user: userId, playerId });

    if (!favoritePlayer) {
      return res.status(404).json({ error: 'Favorite player not found' });
    }

    res.json({ data: favoritePlayer });
  } catch (err) {
    next(err);
  }
};

module.exports = {
  getfavourite_player,
  addfavourite_player,
  removefavourite_player,
  getFavouritePlayerById
};