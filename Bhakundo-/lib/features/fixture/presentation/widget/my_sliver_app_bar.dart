import 'package:flutter/material.dart';
import 'package:nba_hub/features/games/presentation/state/game_state.dart';

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final GameState game;
  final int index;

  MySliverAppBar({
    required this.expandedHeight,
    required this.game,
    required this.index,
  });

  @override
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double appBarHeight = maxExtent - shrinkOffset;
    final double logoSize = appBarHeight * 0.25;
    final double scoreSize = appBarHeight * 0.2;
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;

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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 50,
                  child: Image.network(
                    game.games[index].homeTeamLogo,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  game.games[index].score,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 23,
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Image.network(game.games[index].awayTeamLogo),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: expandedHeight / 1 - shrinkOffset,
          left: 0,
          right: 0,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight).clamp(0.0, 1.0),
            child: Column(
              children: [
                Text(
                  game.games[index].status,
                  style: TextStyle(
                      fontSize: isTablet ? 22 : 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: logoSize,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image.network(
                          game.games[index].homeTeamLogo,
                          width: logoSize,
                          height: logoSize,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          game.games[index].score,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: scoreSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Image.network(
                          game.games[index].awayTeamLogo,
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
