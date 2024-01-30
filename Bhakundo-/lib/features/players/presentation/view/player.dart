import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nba_hub/features/fixture/presentation/widget/my_sliver_app_bar_deligate.dart';
import 'package:nba_hub/features/players/domain/entity/player_entity.dart';
import 'package:nba_hub/features/players/presentation/view/about.dart';

import '../../../favourite_player/domain/entity/favourite_entity.dart';
import '../../../favourite_player/presentation/viewmodel/favourite_profile_view_model.dart';

class PlayerPage extends ConsumerStatefulWidget {
  final PlayerEntity player;
  const PlayerPage({Key? key, required this.player}) : super(key: key);

  @override
  ConsumerState<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends ConsumerState<PlayerPage> {
  bool isStarred = false;
  @override
  void initState() {
    super.initState();

    Future(() async {
      if (!mounted) {
        return;
      }

      await ref
          .watch(favouritePlayerViewModelProvider.notifier)
          .getfavouritePlayer();

      final favouritePlayerViewModel =
          ref.watch(favouritePlayerViewModelProvider);

      final widgetPlayerId = widget.player.player.id.toString();
      var isFavourite = false;

      for (var favourite in favouritePlayerViewModel.check) {
        if (favourite.playerId == widgetPlayerId) {
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

      final favouriteViewModel =
          ref.read(favouritePlayerViewModelProvider.notifier);

      if (isStarred) {
        final favourite = FavouritePlayerEntity(
            playerId: widget.player.player.id.toString(),
            playerName: widget.player.player.name,
            photoUrl: widget.player.player.photo);

        favouriteViewModel.addfavouritePlayer(favourite);
      } else {
        favouriteViewModel
            .removeFavouritePlayer(widget.player.player.id.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;

    return Scaffold(
      body: DefaultTabController(
        length: 1,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverPersistentHeader(
                delegate: MySliverAppBar(
                    expandedHeight: 100.0, player: widget.player),
                pinned: true,
              ),
              SliverPersistentHeader(
                delegate: MySliverAppBarDelegate(
                  TabBar(
                    tabs: [
                      Tab(
                        child: Text(
                          'Teams',
                          style: TextStyle(
                            fontSize: isTablet ? 25 : 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              About(
                player: widget.player,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleStar,
        backgroundColor: isStarred
            ? const Color.fromARGB(255, 152, 6, 6)
            : const Color.fromARGB(255, 82, 60, 60),
        child: const Icon(
          CupertinoIcons.heart,
          color: Color.fromARGB(255, 219, 35, 35),
        ),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final PlayerEntity player;

  MySliverAppBar({required this.expandedHeight, required this.player});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double appBarHeight = maxExtent - shrinkOffset;
    final double logoSize = appBarHeight * 0.25;
    final double scoreSize = appBarHeight * 0.2;

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
                      player.player.photo,
                    )),
                Text(
                  player.player.name,
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
                    player.player.name,
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
                          player.player.photo,
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
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant MySliverAppBar oldDelegate) => false;
}
