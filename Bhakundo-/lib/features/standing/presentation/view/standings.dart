import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nba_hub/features/standing/presentation/view/Standing_team.dart';
import 'package:nba_hub/features/standing/presentation/view/standing_player.dart';

import '../../../../core/common/snackbar/my_snackbar.dart';
import '../viewmodel/standing_view_model.dart';

class Standings extends ConsumerStatefulWidget {
  const Standings({Key? key}) : super(key: key);

  @override
  ConsumerState<Standings> createState() => _StandingsState();
}

class _StandingsState extends ConsumerState<Standings> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Standings',
                style: TextStyle(
                  fontSize: isTablet ? 25 : 20,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () async {
                  showSnackBar(
                    context: context,
                    message: 'Refreshing...',
                    color: Colors.green,
                  );

                  ref
                      .watch(standingViewModelProvider.notifier)
                      .getAllStanding();

                  ref
                      .watch(standingViewModelProvider.notifier)
                      .getAllStandingPlayer();
                },
              ),
            ],
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  'Teams',
                  style: TextStyle(
                    fontSize: isTablet ? 25 : 16,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Players',
                  style: TextStyle(
                    fontSize: isTablet ? 25 : 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              Consumer(
                builder: (context, watch, child) {
                  final standingState = ref.watch(standingViewModelProvider);

                  if (standingState.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white), // Set the color to white
                      ),
                    );
                  } else {
                    final standings = standingState.standing;

                    return StandingTeam(standing: standings);
                  }
                },
              ),
              Consumer(
                builder: (context, watch, child) {
                  final standingplayerState =
                      ref.watch(standingViewModelProvider);
                  if (standingplayerState.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white), // Set the color to white
                      ),
                    );
                  } else {
                    final standingplayer = standingplayerState.standingPlayer;
                    return StandingPlayer(standingPlayer: standingplayer);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
