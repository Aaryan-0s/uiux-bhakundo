const mongoose = require('mongoose');


const favoriteSchema =mongoose.Schema({

  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },

  teamId: {
    type: String,
    required: true,
  },
  
  teamName: {
    type: String,
    required: true,
  },
   
  logoUrl: {
    type: String,
    required: true,
  },
 
});

const Favorite = mongoose.model('Favorite', favoriteSchema);

module.exports = Favorite;
