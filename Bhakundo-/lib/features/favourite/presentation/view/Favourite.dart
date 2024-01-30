import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nba_hub/features/favourite/presentation/view/favourite_team.dart';

import '../../../favourite_player/presentation/view/favourite_player.dart';
import '../viewmodel/favourite_profile_view_model.dart';

class Favourite extends ConsumerStatefulWidget {
  const Favourite({super.key});

  @override
  ConsumerState<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends ConsumerState<Favourite> {
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
      //     .getAllTeam(widget.team.id.toString());

      // await ref
      //     .watch(playerViewModelProvider.notifier)
      //     .getAllPlayer(widget.team.id.toString());

      // Check if the team is already in favorites
      await ref.watch(favouriteViewModelProvider.notifier).getfavourite();

      // final widgetTeamId = widget.team.id.toString();
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favourite'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(CupertinoIcons.star)),
              Tab(icon: Icon(CupertinoIcons.heart)),
            ],
          ),
        ),
        body: const SafeArea(
          child: SafeArea(
            child: TabBarView(
              children: [
                FavouriteTeams(),
                FavouritePlayer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
