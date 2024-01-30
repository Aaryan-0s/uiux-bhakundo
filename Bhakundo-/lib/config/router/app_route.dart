import 'package:flutter/cupertino.dart';
import 'package:nba_hub/features/Team/presentation/view/Team.dart';
import 'package:nba_hub/features/favourite/presentation/view/Favourite.dart';
import 'package:nba_hub/features/fixture/presentation/view/fixture.dart';
import 'package:nba_hub/features/players/presentation/view/player.dart';
import 'package:nba_hub/features/profile/domain/entity/profile_entity.dart';
import 'package:nba_hub/features/profile/presentation/view/contact_page.dart';
import 'package:nba_hub/features/splash/presentation/view/splash_view.dart';

import '../../features/auth/presentation/view/login_view.dart';
import '../../features/auth/presentation/view/signup_view.dart';
import '../../features/games/domain/entity/game_entity.dart';
import '../../features/players/domain/entity/player_entity.dart';
import '../../features/profile/presentation/view/profile_screen.dart';
import '../../features/profile/presentation/view/update_profile.dart';
import '../../features/standing/domain/entity/standing_entity.dart';
import '../../view/dashboard.dart';

class AppRoute {
  AppRoute._();

  // static const String splashRoute = '/splash';
  static const String signUpRoute = '/signup';
  static const String loginRoute = '/login';
  static const String dashBoardRoute = '/dashboard';
  static const String splashScreen = "/splashScreen";
  static const String profile = "/profile";
  static const String favourite = "/favourite";
  static const String updateProfile = "/updateProfile";
  static const String contact="/contact";
  static const String teams = "/teams";
  static const String fixture = "/fixture";
  static const String player = "/player";

  static getApplicationRoute() {
    return {
      // splashRoute: (context) => const SplashView(),
      loginRoute: (context) => const Login(),
      dashBoardRoute: (context) => const Dashboard(),
      signUpRoute: (context) => const SignUp(),
      splashScreen: (context) => const SplashView(),
      profile: (context) => const ProfileScreen(),
      contact: (context) => const ContactPage(),

      updateProfile: (context) {
        final updateProfile =
            ModalRoute.of(context)!.settings.arguments as ProfileEntity;
        return UpdateProfileScreen(profile: updateProfile);
      },
      player: (context) {
        final player =
            ModalRoute.of(context)!.settings.arguments as PlayerEntity;
        return PlayerPage(player: player);
      },
      teams: (context) {
        final team =
            ModalRoute.of(context)!.settings.arguments as StandingEntity;

        return TeamPage(team: team);
      },
      fixture: (context) {
        final args = ModalRoute.of(context)!.settings.arguments as List;
        final game = args[0] as GameEntity;
        final index = args[1] as int;

        return Fixture(game: game, index: index);
      },
      favourite: (context) {
        return const Favourite();
      }
    };
  }
}
