import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nba_hub/config/constants/hive_table_constant.dart';
import 'package:nba_hub/features/favourite/data/model/favourite_hive_model.dart';
import 'package:nba_hub/features/favourite_player/data/model/favourite_player_hive_model.dart';
import 'package:nba_hub/features/games/data/model/game_hive_model.dart';
import 'package:nba_hub/features/profile/data/model/profile_hive_model.dart';
import 'package:nba_hub/features/standing/data/model/standing_hive_model.dart';
import 'package:nba_hub/features/standing/data/model/standing_player_hive_model.dart';
import 'package:path_provider/path_provider.dart';

final hiveServiceProvider = Provider<HiveService>((ref) => HiveService());

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    // Register Adapters
    Hive.registerAdapter(GameHiveModelAdapter());
    Hive.registerAdapter(StandingHiveModelAdapter());
    Hive.registerAdapter(StandingPlayerHiveModelAdapter());
    Hive.registerAdapter(FavouriteHiveModelAdapter());
    Hive.registerAdapter(FavouritePlayerHiveModelAdapter());
    Hive.registerAdapter(ProfileHiveModelAdapter());

    // Add dummy data
  }

  Future<void> addGame(GameHiveModel game) async {
    var box = await Hive.openBox<GameHiveModel>(HiveTableConstant.gameBox);
    await box.put(game.fixtureId, game);
  }

  Future<List<GameHiveModel>> getAllGames() async {
    var box = await Hive.openBox<GameHiveModel>(HiveTableConstant.gameBox);
    var games = box.values.toList();
    box.close();
    return games;
  }

  Future<List<StandingHiveModel>> getAllStandings() async {
    var box = await Hive.openBox<StandingHiveModel>(
        HiveTableConstant.standingTeamBox);
    var standings = box.values.toList();
    box.close();
    return standings;
  }

  Future<List<StandingPlayerHiveModel>> getAllStandingPlayer() async {
    var box = await Hive.openBox<StandingPlayerHiveModel>(
        HiveTableConstant.standingPlayerBox);
    var standingPlayer = box.values.toList();
    box.close();
    return standingPlayer;
  }

  Future<void> addStanding(StandingHiveModel standing) async {
    var box = await Hive.openBox<StandingHiveModel>(
        HiveTableConstant.standingTeamBox);
    await box.put(standing.id, standing);
  }

  Future<void> addStandingPlayer(StandingPlayerHiveModel standingPlayer) async {
    var box = await Hive.openBox<StandingPlayerHiveModel>(
        HiveTableConstant.standingPlayerBox);
    await box.put(standingPlayer.id, standingPlayer);
  }

  Future<void> addFavourite(FavouriteHiveModel favourite) async {
    var box =
        await Hive.openBox<FavouriteHiveModel>(HiveTableConstant.favouriteBox);
    await box.put(favourite.id, favourite);
  }

  Future<List<FavouriteHiveModel>> getAllFavourite() async {
    var box =
        await Hive.openBox<FavouriteHiveModel>(HiveTableConstant.favouriteBox);
    var favourite = box.values.toList();
    box.close();
    return favourite;
  }

  Future<List<FavouritePlayerHiveModel>> getAllFavouritePlayer() async {
    var box = await Hive.openBox<FavouritePlayerHiveModel>(
        HiveTableConstant.favouritePlayerBox);
    var favouritePlayer = box.values.toList();
    box.close();
    return favouritePlayer;
  }

  Future<void> addFavouritePlayer(
      FavouritePlayerHiveModel favouritePlayer) async {
    var box = await Hive.openBox<FavouritePlayerHiveModel>(
        HiveTableConstant.favouritePlayerBox);
    await box.put(favouritePlayer.id, favouritePlayer);
  }

  Future<void> addProfile(ProfileHiveModel profile) async {
    var box =
        await Hive.openBox<ProfileHiveModel>(HiveTableConstant.profileBox);
    await box.put(profile.userId, profile);
  }

  Future<List<ProfileHiveModel>> getProfile() async {
    var box =
        await Hive.openBox<ProfileHiveModel>(HiveTableConstant.profileBox);
    var profile = box.values.toList();
    box.close();
    return profile;
  }

  // ======================== Delete All Data ========================
  Future<void> deleteAllData() async {
    var box = await Hive.openBox<GameHiveModel>(HiveTableConstant.gameBox);
    await box.clear();
  }

  // ======================== Close Hive ========================
  Future<void> closeHive() async {
    await Hive.close();
  }

  // ======================== Delete Hive ========================
  Future<void> deleteHive() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    await Hive.deleteBoxFromDisk(HiveTableConstant.gameBox);

    await Hive.deleteFromDisk();
  }
}
