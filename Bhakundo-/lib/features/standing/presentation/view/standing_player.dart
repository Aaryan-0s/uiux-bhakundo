import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nba_hub/features/standing/domain/entity/standing_player_entity.dart';

import '../../../../config/router/app_route.dart';
import '../../../../core/common/provider/internet_connectivity.dart';
import '../../../players/presentation/viewmodel/player_view_model.dart';

class StandingPlayer extends ConsumerStatefulWidget {
  final List<StandingPlayerEntity> standingPlayer;

  const StandingPlayer({Key? key, required this.standingPlayer})
      : super(key: key);

  @override
  ConsumerState<StandingPlayer> createState() => _StandingPlayerState();
}

class _StandingPlayerState extends ConsumerState<StandingPlayer> {
  Future<void> onPlayerTap(StandingPlayerEntity player) async {
    await ref
        .watch(playerViewModelProvider.notifier)
        .getAllPlayerById(player.id.toString());
    var playerin = ref.watch(playerViewModelProvider);

    if (!mounted) return;

    Navigator.pushNamed(context, AppRoute.player,
        arguments: playerin.playerById[0]);
  }

  @override
  Widget build(BuildContext context) {
    final internetStatus = ref.watch(connectivityStatusProvider);
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;

    return Scaffold(
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            final isHorizontal = orientation == Orientation.landscape;
            final columnSpacing = isTablet
                ? isHorizontal
                    ? 275.0
                    : 146.0
                : isHorizontal
                    ? 80.0
                    : 14.0;

            return Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: IntrinsicWidth(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: SingleChildScrollView(
                        child: DataTable(
                          columnSpacing: columnSpacing,
                          columns: [
                            DataColumn(
                                label: Text(
                              'Player',
                              style: TextStyle(
                                fontSize: isTablet ? 22 : 16,
                              ),
                            )),
                            DataColumn(
                                label: Text(
                              'Goals',
                              style: TextStyle(
                                fontSize: isTablet ? 22 : 16,
                              ),
                            )),
                            DataColumn(
                                label: Text(
                              'Passes',
                              style: TextStyle(
                                fontSize: isTablet ? 22 : 16,
                              ),
                            )),
                            DataColumn(
                                label: Text(
                              'Games',
                              style: TextStyle(
                                fontSize: isTablet ? 22 : 16,
                              ),
                            )),
                          ],
                          rows: widget.standingPlayer.map((player) {
                            final teamAbbreviation =
                                player.team.split(' ').map((word) {
                              if (word.length > 3) {
                                return word.substring(0, 3);
                              } else {
                                return word;
                              }
                            }).join(' ');

                            return DataRow(cells: [
                              DataCell(
                                GestureDetector(
                                  onTap: () async {
                                    var connectivityResult =
                                        await (Connectivity()
                                            .checkConnectivity());
                                    if (connectivityResult ==
                                        ConnectivityResult.none) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('No Internet Connection'),
                                          duration: Duration(seconds: 1),
                                        ),
                                      );
                                    } else {
                                      onPlayerTap(player);
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      internetStatus ==
                                              ConnectivityStatus.isConnected
                                          ? Image.network(
                                              player.picture,
                                              width: isTablet ? 30 : 24,
                                              height: isTablet ? 30 : 24,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                  'assets/images/barsa.png',
                                                  width: 50.0,
                                                  height: 50.0,
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            )
                                          : Image.asset(
                                              'assets/images/barsa.png',
                                              width: 50.0,
                                              height: 50.0,
                                              fit: BoxFit.cover,
                                            ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        player.name,
                                        style: TextStyle(
                                          fontSize: isTablet ? 18 : 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  player.goals.toString(),
                                  style: TextStyle(
                                    fontSize: isTablet ? 18 : 14,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  player.passes.toString(),
                                  style: TextStyle(
                                    fontSize: isTablet ? 18 : 14,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  player.games.toString(),
                                  style: TextStyle(
                                    fontSize: isTablet ? 18 : 14,
                                  ),
                                ),
                              ),
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
