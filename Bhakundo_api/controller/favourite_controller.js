const favourite_model = require("../models/favourite");
const User_model = require("../models/user");

// Controller method to get all teams in the user's favourite
const getfavourite = async (req, res, next) => {
  try {
    const userId = req.userId; // Assuming you have middleware to extract the user ID

    const favourite = await favourite_model.find({ user: userId });

    res.json({data : favourite});
  } catch (err) {
    next(err);
  }
};


// Controller method to add a movie to the user's favourite
const addfavourite = async (req, res, next) => {
  try {
    const userId = req.userId; // Assuming you have middleware to extract the user ID
    const { teamId, teamName, logoUrl } = req.body;

    const user = await User_model.findById(userId);

    // Check if the team already exists in user's favorites
    if (user.favourites.includes(teamId)) {
      return res.status(400).json({ error: 'Team is already favorited' });
    }

    const favourite = new favourite_model({
      user: userId,
      teamId: teamId,
      teamName: teamName,
      logoUrl: logoUrl,
    });

    user.favourites.push(teamId);
    await user.save();

    await favourite.save();

    res.json({ data: [favourite] });
  } catch (err) {
    next(err);
  }
};

  

// Controller method to remove a movie from the user's favourite
const removefavourite = async (req, res, next) => {
    try {
        const userId = req.userId; // Assuming you have middleware to extract the user ID
        const teamId = req.params.id;

        const user = await User_model.findById(userId);


        const favourite = await favourite_model.findOneAndDelete({ user: userId, teamId });

        user.favourites = user.favourites.filter(
          (favourites) => favourites.toString() !== teamId
        );
        await user.save();
    
        res.json({message:"deleted"});
    } catch (err) {
        next(err);
    }
};

const getfavouriteTeamById = async (req, res, next) => {
  try {
    const userId = req.userId; // Assuming you have middleware to extract the user ID
    const TeamId = req.params.id; 
    
    // Assuming the Team ID is passed as a URL parameter

    const favoriteTeam = await favourite_model.findOne({ user: userId,teamId: TeamId });
    

    if (!favoriteTeam) {
      return res.status(404).json({ error: 'Favorite Team not found' });
    }

    res.json({ data: favoriteTeam });
  } catch (err) {
    next(err);
  }
};



module.exports = {
  getfavourite,
  addfavourite,
  removefavourite,
  getfavouriteTeamById
};