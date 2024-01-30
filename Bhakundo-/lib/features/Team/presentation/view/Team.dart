import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nba_hub/features/Team/presentation/view/team_players.dart';
import 'package:nba_hub/features/Team/presentation/view/team_stats.dart';
import 'package:nba_hub/features/favourite/presentation/viewmodel/favourite_profile_view_model.dart';
import 'package:nba_hub/features/fixture/presentation/widget/my_sliver_app_bar_deligate.dart';
import 'package:nba_hub/features/players/presentation/viewmodel/player_view_model.dart';
import 'package:nba_hub/features/standing/domain/entity/standing_entity.dart';

import '../../../favourite/domain/entity/favourite_entity.dart';
import '../viewmodel/team_view_model.dart';

class TeamPage extends ConsumerStatefulWidget {
  final StandingEntity team;
  const TeamPage({Key? key, required this.team}) : super(key: key);

  @override
  ConsumerState<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends ConsumerState<TeamPage> {
  bool isStarred = false;

  @override
  void initState() {
    super.initState();

    Future(() async {
      if (!mounted) {
        return;
      }

      await ref
          .watch(teamViewModelProvider.notifier)
          .getAllTeam(widget.team.id.toString());

      await ref
          .watch(playerViewModelProvider.notifier)
          .getAllPlayer(widget.team.id.toString());

      await ref.watch(favouriteViewModelProvider.notifier).getfavourite();

      final favouriteViewModel = ref.watch(favouriteViewModelProvider);

      final widgetTeamId = widget.team.id.toString();
      var isFavourite = false;

      for (var favourite in favouriteViewModel.check) {
        if (favourite.teamId == widgetTeamId) {
          isFavourite = true;
          break;
        }
      }

      if (mounted) {
        setState(() {
          isStarred = isFavourite;
        });
      }
    });
  }

  void toggleStar() {
    setState(() {
      isStarred = !isStarred;
    });

    final favouriteViewModel = ref.read(favouriteViewModelProvider.notifier);

    if (isStarred) {
      final favourite = FavouriteEntity(
          teamId: widget.team.id.toString(),
          teamName: widget.team.name,
          logoUrl: widget.team.logo);

      favouriteViewModel.addfavourite(favourite);
    } else {
      favouriteViewModel.removeFavourite(widget.team.id.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var stats = ref.watch(teamViewModelProvider);
    var players = ref.watch(playerViewModelProvider);

    if (stats.team.isEmpty || players.player.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverPersistentHeader(
                delegate:
                    MySliverAppBar(expandedHeight: 100.0, team: widget.team),
                pinned: true,
              ),
              SliverPersistentHeader(
                delegate: MySliverAppBarDelegate(
                  const TabBar(
                    tabs: [
                      Tab(text: "Stats"),
                      Tab(text: "Players"),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              TeamStats(team: widget.team, stats: stats.team),
              TeamPlayers(
                players: players.player,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleStar,
        backgroundColor: isStarred ? Colors.yellow : Colors.grey,
        child: const Icon(
          Icons.star,
          color: Colors.white,
        ),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final StandingEntity team;

  MySliverAppBar({required this.expandedHeight, required this.team});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double appBarHeight = maxExtent - shrinkOffset;
    final double logoSize = appBarHeight * 0.25;
    final double scoreSize = appBarHeight * 0.2;

    double opacity = (shrinkOffset / expandedHeight).clamp(0.0, 1.0);

    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 39, 29, 29),
                Color.fromARGB(255, 39, 29, 29),
              ],
            ),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        Center(
          child: Opacity(
            opacity: (shrinkOffset / expandedHeight).clamp(0, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  child: Image.network(
                    team.logo,
                  ),
                ),
                Text(
                  team.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 23,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: expandedHeight / 1.5 - shrinkOffset,
          left: 0,
          right: 0,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight).clamp(0.0, 1.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    team.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: logoSize,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.network(
                          team.logo,
                          width: logoSize,
                          height: logoSize,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 200.0;

  @override
  double get minExtent => 90;

  @override
  bool shouldRebuild(covariant MySliverAppBar oldDelegate) => false;
}
