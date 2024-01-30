const mongoose = require('mongoose');


const favorite_player_Schema =mongoose.Schema({

  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },

  playerId: {
    type: String,
    required: true,
  },
  
  playerName: {
    type: String,
    required: true,
  },
   
  photoUrl: {
    type: String,
    required: true,
  },
 
});

const Favorite_player = mongoose.model('Favorite_player', favorite_player_Schema);

module.exports = Favorite_player;
