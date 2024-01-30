const express = require('express');

const {getgamebydate,getstats,getgame,getTeamStanding, gettopScorers, getteamgoalstats,getallplayer, getallplayerbyId,getTeamStandingById,getLeague,getgamebyId} = require("../controller/football_controller");
const auth = require("../middleware/auth");
const footballRouter=express.Router();

// Route to get leagues by country name
footballRouter.get('/game',auth, getgame);
footballRouter.get('/game/:id',auth, getgamebyId)
footballRouter.get('/game/:season/:date',auth, getgamebydate);
footballRouter.get('/stats/:fixtureId',auth, getstats);
footballRouter.get('/standings/teams',auth, getTeamStanding);
footballRouter.get('/standings/players',auth, gettopScorers);
footballRouter.get('/:teamId/stats',auth, getteamgoalstats);
footballRouter.get('/:teamId/players',auth, getallplayer);
footballRouter.get('/players/:playerId',auth,getallplayerbyId);
footballRouter.get('/standings/teams/:teamId',auth,getTeamStandingById);
footballRouter.get('/league',auth,getLeague);


module.exports = footballRouter;
