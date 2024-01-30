const axios = require("axios");

const getgame = async (req, res) => {
  const currentDate = new Date();
  const formattedDate = currentDate.toISOString().slice(0, 10);
  const options = {
    method: "GET",
    url: "https://api-football-v1.p.rapidapi.com/v3/fixtures",
    params: {
      date: formattedDate,
      league: "98",
      season: "2023",
    },
    headers: {
      "X-RapidAPI-Key": "8ca33e6631mshb8c9173b82afe13p12a8e1jsnea9f247d215f",
      "X-RapidAPI-Host": "api-football-v1.p.rapidapi.com",
    },
  };

  try {
    const response = await axios.request(options);

    // Extracting the desired data
    const extractedData = response.data.response.map((fixture) => ({
      fixtureId: fixture.fixture.id,
      status:fixture.fixture.status.elapsed !== null 
      ? `${fixture.fixture.status.elapsed}`
      : "ft",
      homeTeam: fixture.teams.home.name,
      homeTeamLogo: fixture.teams.home.logo,
      awayTeam: fixture.teams.away.name,
      awayTeamLogo: fixture.teams.away.logo,
      score:
        fixture.goals.home !== null && fixture.goals.away !== null
          ? `${fixture.goals.home} - ${fixture.goals.away}`
          : "x-x",
    }));

    res.json({
      message: "Successfully fetched today's games",
      data: extractedData,
    });
  } catch (error) {
    res.json(error);
  }
};

const getgamebyId = async (req, res) => {
  const { id } = req.params;
  const currentDate = new Date();
  const formattedDate = currentDate.toISOString().slice(0, 10);
  
const options = {
  method: 'GET',
  url: 'https://api-football-v1.p.rapidapi.com/v3/fixtures',
  params: {id: `${id}`},
  headers: {
    'X-RapidAPI-Key': '8ca33e6631mshb8c9173b82afe13p12a8e1jsnea9f247d215f',
    'X-RapidAPI-Host': 'api-football-v1.p.rapidapi.com'
  }
};
  

  try {
    const response = await axios.request(options);

    // Extracting the desired data
    const extractedData = response.data.response.map((fixture) => ({
      fixtureId: fixture.fixture.id,
      status:fixture.fixture.status.elapsed !== null 
      ? `${fixture.fixture.status.elapsed}`
      : "ft",
      homeTeam: fixture.teams.home.name,
      homeTeamLogo: fixture.teams.home.logo,
      awayTeam: fixture.teams.away.name,
      awayTeamLogo: fixture.teams.away.logo,
      score:
        fixture.goals.home !== null && fixture.goals.away !== null
          ? `${fixture.goals.home} - ${fixture.goals.away}`
          : "x-x",
    }));

    res.json({
      message: `Successfully fetched ${id} games`,
      data: extractedData,
    });
  } catch (error) {
    res.json(error);
  }
};

const getgamebydate = async (req, res) => {
  const { date, season } = req.params;

  const options = {
    method: "GET",
    url: "https://api-football-v1.p.rapidapi.com/v3/fixtures",
    params: {
      league: "98",
      date: date,
      season: season,
    },
    headers: {
      "X-RapidAPI-Key": "8ca33e6631mshb8c9173b82afe13p12a8e1jsnea9f247d215f",
      "X-RapidAPI-Host": "api-football-v1.p.rapidapi.com",
    },
  };

  try {
    const response = await axios.request(options);

    // Extracting the desired data
    const extractedData = response.data.response.map((fixture) => ({
      fixtureId: fixture.fixture.id,
      status:fixture.fixture.status.elapsed !== null 
      ? `${fixture.fixture.status.elapsed}`
      : "ft",
      homeTeam: fixture.teams.home.name,
      homeTeamLogo: fixture.teams.home.logo,
      awayTeam: fixture.teams.away.name,
      awayTeamLogo: fixture.teams.away.logo,
      score:
        fixture.goals.home !== null && fixture.goals.away !== null
          ? `${fixture.goals.home} - ${fixture.goals.away}`
          : "x-x",
    }));

    res.json({
      message: `Successfully fetched games for ${date}`,
      data: extractedData,
    });
  } catch (error) {
    res.json(error);
  }
};


const getstats = async (req, res) => {
  const { fixtureId } = req.params;

  const options = {
    method: "GET",
    url: "https://api-football-v1.p.rapidapi.com/v3/fixtures/statistics",
    params: { fixture: fixtureId },
    headers: {
      "X-RapidAPI-Key": "8ca33e6631mshb8c9173b82afe13p12a8e1jsnea9f247d215f",
      "X-RapidAPI-Host": "api-football-v1.p.rapidapi.com",
    },
  };

  try {
    const response = await axios.request(options);
    console.log(response.data);
    const teamData = response.data.response || [];

    const teamStats = teamData.map((team) => {
      const shotsOnGoal =
        team.statistics.find((stat) => stat.type === "Shots on Goal")?.value ||
        0;
      const shotsOffGoal =
        team.statistics.find((stat) => stat.type === "Shots off Goal")?.value ||
        0;
      const totalShots =
        team.statistics.find((stat) => stat.type === "Total Shots")?.value || 0;
      const blockedShots =
        team.statistics.find((stat) => stat.type === "Blocked Shots")?.value ||
        0;
      const shotsInsideBox =
        team.statistics.find((stat) => stat.type === "Shots insidebox")
          ?.value || 0;
      const shotsOutsideBox =
        team.statistics.find((stat) => stat.type === "Shots outsidebox")
          ?.value || 0;
      const fouls =
        team.statistics.find((stat) => stat.type === "Fouls")?.value || 0;
      const cornerKicks =
        team.statistics.find((stat) => stat.type === "Corner Kicks")?.value ||
        0;
      const offsides =
        team.statistics.find((stat) => stat.type === "Offsides")?.value || 0;
      const ballPossession =
        team.statistics.find((stat) => stat.type === "Ball Possession")
          ?.value || "0%";

      // Remove the percent sign using a regular expression
      const formattedBallPossession = ballPossession.replace(/%/g, "");

      return {
        name: team.team.name,
        shotsOnGoal,
        shotsOffGoal,
        totalShots,
        blockedShots,
        shotsInsideBox,
        shotsOutsideBox,
        fouls,
        cornerKicks,
        offsides,
        ballPossession: formattedBallPossession, // Use the formatted value without percent sign
      };
    });

    res.json({
      message: "Successfully fetched team statistics",
      data: teamStats,
    });
    console.log(fixtureId);
  } catch (error) {
    console.error(error);
  }
};

const getTeamStanding = async (req, res) => {
  const axios = require("axios");

  const options = {
    method: "GET",
    url: "https://api-football-v1.p.rapidapi.com/v3/standings",
    params: {
      season: "2023",
      league: "98",
    },
    headers: {
      "X-RapidAPI-Key": "8ca33e6631mshb8c9173b82afe13p12a8e1jsnea9f247d215f",
      "X-RapidAPI-Host": "api-football-v1.p.rapidapi.com",
    },
  };

  try {
    const response = await axios.request(options);
    const league = response.data.response[0].league;

    const standings = response.data.response[0].league.standings[0];

    const teamData = standings.map((team) => ({
      rank: team.rank,
      id: team.team.id,
      leagueNames: league.name,
      leagueLogo: league.logo,
      name: team.team.name,
      logo: team.team.logo,
      points: team.points,
      goalsDiff: team.goalsDiff,

      status: team.status,

      played: team.all.played,
      win: team.all.win,
      draw: team.all.draw,
      lose: team.all.lose,
      goalsFor: team.all.goals.for,
      goalsAgainst: team.all.goals.against,
    }));

    res.json({
      message: "Successfully fetched team standings",
      data: teamData,
    });
  } catch (error) {
    console.error(error);
  }
};

const getTeamStandingById = async (req, res) => {
  const { teamId } = req.params;
  

  const options = {
    method: "GET",
    url: "https://api-football-v1.p.rapidapi.com/v3/standings",
    params: {
      season: "2023",
      team: teamId,

    },
    headers: {
      "X-RapidAPI-Key": "8ca33e6631mshb8c9173b82afe13p12a8e1jsnea9f247d215f",
      "X-RapidAPI-Host": "api-football-v1.p.rapidapi.com",
    },
  };

  try {
    const response = await axios.request(options);

    const standings = response.data.response[1].league.standings[0];

    const teamData = standings.map((team) => ({
      rank: team.rank,
      id: team.team.id,
      name: team.team.name,
      logo: team.team.logo,
      points: team.points,
      goalsDiff: team.goalsDiff,

      status: team.status,

      played: team.all.played,
      win: team.all.win,
      draw: team.all.draw,
      lose: team.all.lose,
      goalsFor: team.all.goals.for,
      goalsAgainst: team.all.goals.against,
    }));

    res.json({
      message: "Successfully fetched team standings",
      data: teamData,
    });
  } catch (error) {
    console.error(error);
  }
};

const gettopScorers = async (req, res) => {
  const options = {
    method: "GET",
    url: "https://api-football-v1.p.rapidapi.com/v3/players/topscorers",
    params: {
      league: "98",
      season: "2023",
    },
    headers: {
      "X-RapidAPI-Key": "8ca33e6631mshb8c9173b82afe13p12a8e1jsnea9f247d215f",
      "X-RapidAPI-Host": "api-football-v1.p.rapidapi.com",
    },
  };

  try {
    const response = await axios.request(options);
    const players = response.data.response;

    const playerInfo = players.map((player) => ({
      id: player.player.id,
      name: player.player.name,
      team: player.statistics[0].team.name,
      teamPicture: player.statistics[0].team.logo,
      goals: player.statistics[0].goals.total,
      passes: player.statistics[0].passes.total,
      games: player.statistics[0].games.appearences,
      picture: player.player.photo,
    }));

    res.json({
      message: "Successfully fetched top scorers",
      data: playerInfo,
    });
  } catch (error) {
    console.error(error);
  }
};

const getteamgoalstats = async (req, res) => {
  const { teamId } = req.params;

  const options = {
    method: 'GET',
    url: 'https://api-football-v1.p.rapidapi.com/v3/teams/statistics',
    params: {
      league: '98',
      season: '2023',
      team: teamId
    },
    headers: {
      'X-RapidAPI-Key': '8ca33e6631mshb8c9173b82afe13p12a8e1jsnea9f247d215f',
      'X-RapidAPI-Host': 'api-football-v1.p.rapidapi.com'
    }
  };

  try {
    const response = await axios.request(options);
    const goalData = response.data.response.goals;

    // Remove the "106-120" data from minute object
  

    // Convert null values to 0 and "0"
    Object.entries(goalData.for.minute).forEach(([key, value]) => {
      goalData.for.minute[key].total = value.total !== null ? value.total : 0;
      goalData.for.minute[key].percentage = value.percentage !== null ? value.percentage : "0";
    });

    Object.entries(goalData.against.minute).forEach(([key, value]) => {
      goalData.against.minute[key].total = value.total !== null ? value.total : 0;
      goalData.against.minute[key].percentage = value.percentage !== null ? value.percentage : "0";
    });

    res.json({
      message: 'Successfully fetched team goal stats',
      data: [goalData]
    });
  } catch (error) {
    console.error(error);
  }
};

const getallplayer= async (req, res) => {

  const { teamId } = req.params;

const options = {
  method: 'GET',
  url: 'https://api-football-v1.p.rapidapi.com/v3/players',
  params: {
    team: teamId,
    season: '2023'
  },
  headers: {
    'X-RapidAPI-Key': '8ca33e6631mshb8c9173b82afe13p12a8e1jsnea9f247d215f',
    'X-RapidAPI-Host': 'api-football-v1.p.rapidapi.com'
  }
};

try {
	const response = await axios.request(options);
	res.json({
    message: 'Successfully fetched players',
    data: response.data.response
  })
} catch (error) {
	console.error(error);
}
}

const getallplayerbyId= async (req, res) => {

  const { playerId } = req.params;

const options = {
  method: 'GET',
  url: 'https://api-football-v1.p.rapidapi.com/v3/players',
  params: {
    id: playerId,
    season: '2023'
  },
  headers: {
    'X-RapidAPI-Key': '8ca33e6631mshb8c9173b82afe13p12a8e1jsnea9f247d215f',
    'X-RapidAPI-Host': 'api-football-v1.p.rapidapi.com'
  }
};

try {
	const response = await axios.request(options);
	res.json({
    message: 'Successfully fetched player',
    data: response.data.response
  })
} catch (error) {
	console.error(error);
}}

const getLeague = async (req, res) => {


  const options = {
    method: 'GET',
    url: 'https://api-football-v1.p.rapidapi.com/v3/leagues',
    params: { id: '98' },
    headers: {
      'X-RapidAPI-Key': '8ca33e6631mshb8c9173b82afe13p12a8e1jsnea9f247d215f',
      'X-RapidAPI-Host': 'api-football-v1.p.rapidapi.com'
    }
  };

  try {
    const response = await axios.request(options);
    const leagueData = response.data.response[0].league;

    // Extract the required data from the leagueData object
    const leagueId = leagueData.id;
    const leagueName = leagueData.name;
    const leagueLogo = leagueData.logo;

    // Now you have the required data, you can use it as needed
 

    // Send the required data as a response
    res.json({ id: leagueId, name: leagueName, logo: leagueLogo });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to fetch league data" });
  }
};





module.exports = {
  getgamebydate,
  getgame,
  getstats,
  getTeamStanding,
  gettopScorers,
  getteamgoalstats,
  getallplayer,
  getallplayerbyId,
  getTeamStandingById,
  getLeague,
  getgamebyId
};
