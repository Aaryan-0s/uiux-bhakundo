import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodel/favourite_profile_view_model.dart';
import '../widget/favourite_player_widget.dart';

class FavouritePlayer extends ConsumerStatefulWidget {
  const FavouritePlayer({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<FavouritePlayer> createState() => _FavouritePlayerState();
}

class _FavouritePlayerState extends ConsumerState<FavouritePlayer> {
  @override
  void initState() {
    super.initState();

    Future(() async {
      // if (!mounted) {
      //   // Widget is already disposed, do not proceed.
      //   return;
      // }

      // Call the API to fetch the statistics
      // await ref
      //     .watch(teamViewModelProvider.notifier)
      //     .getAllTeam(widget.player.id.toString());

      // await ref
      //     .watch(playerViewModelProvider.notifier)
      //     .getAllPlayer(widget.player.id.toString());

      // Check if the player is already in favorites
      await ref
          .watch(favouritePlayerViewModelProvider.notifier)
          .getfavouritePlayer();

      // final widgetTeamId = widget.player.id.toString();
      // var isFavourite = false;

      // for (var favourite in favouriteViewModel.check) {
      //   if (favourite.teamId == widgetTeamId) {
      //     isFavourite = true;
      //     break;
      //   }
      // }

      // if (mounted) {
      //   // Check again if the widget is still mounted before calling setState.
      //   setState(() {
      //     isStarred = isFavourite;
      //   });
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    final favouritePlayerViewModel =
        ref.watch(favouritePlayerViewModelProvider);

    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView.builder(
            itemCount: favouritePlayerViewModel.check.length,
            itemBuilder: (context, index) {
              final player = favouritePlayerViewModel.check[index];
              return FavouritePlayerContainer(
                player: player,
              );
            },
          ),
        ),
      ),
    );
  }
}
