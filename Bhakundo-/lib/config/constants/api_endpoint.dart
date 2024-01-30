class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:3001/api/v1/";
  // static const String baseUrl = "http://192.168.137.1:3001/api/v1/";

  // ====================== Auth Routes ======================
  static const String login = "auth/login";
  static const String register = "auth/signup";
  static const String getUser = "auth/info/get";
  static const String deleteProfile = "auth/delete";
  static const String uploadImage = "auth/uploadImage";
  static const String getgame = "football/game";
  static const String getFixtureInfo = "football/game/";
  static const String getAllSeason = "football/season";
  static const String getAllGameByDate = "football/game/";

  static const String getFixtureById = "football/stats/";
  static const String getAllStanding = "football/standings/teams";
  static const String getAllStandingPlayer = "football/standings/players";
  static const String getAllTeam = "football/";
  static const String getAllPlayer = "football/";
  static const String getAllPlayerById = "football/";
  static const String updateProfile = "auth/profile/update";
  static const String getFavourite = "teams/favourites";
  static const String addFavourite = "teams/favourites/add";
  static const String removeFavourite = "teams/unfavourite";
  static const String getFavouritePlayer = "players/favourites/player";
  static const String addFavouritePlayer = "players/favourites/player/add";
  static const String removeFavouritePlayer = "players/unfavourite/player/";
  static const String getStandingByTeamId = "football/standings/teams/";
  static const String getComment = "comment/";
  static const String addComment = "comment/";
  static const String deleteComment = "comment/";
  static const String editComment = "comment/";
}
