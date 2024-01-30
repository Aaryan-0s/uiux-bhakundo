import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/provider/internet_connectivity.dart';
import '../../domain/entity/game_entity.dart';

class GameFixture extends ConsumerStatefulWidget {
  final List<GameEntity> gameList;
  const GameFixture({super.key, required this.gameList});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameFixtureState();
}

class _GameFixtureState extends ConsumerState<GameFixture> {
  @override
  Widget build(BuildContext context) {
    final wifi = checkConnectivity1();
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;
    final internetStatus = ref.watch(connectivityStatusProvider);
    return Positioned(
      top: 20.0,
      left: 0,
      right: 0,
      bottom: 0,
      child: ListView.builder(
        itemCount: widget.gameList.length,
        itemBuilder: (context, index) {
          GameEntity gameList = widget.gameList[index];
          return GestureDetector(
            onTap: () async {
              var connectivityResult =
                  await (Connectivity().checkConnectivity());
              if (connectivityResult == ConnectivityResult.none) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('No Internet Connection'),
                    duration: Duration(seconds: 1),
                  ),
                );
              } else {
                Navigator.pushNamed(context, '/fixture',
                    arguments: [widget.gameList[index], index]);
              }
            },
            child: Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 2.0,
                    spreadRadius: 2.0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Image.network(
                          gameList.homeTeamLogo,
                          width: 50.0,
                          height: 50.0,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/barsa.png',
                              width: 50.0,
                              height: 50.0,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            gameList.homeTeam,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        gameList.score,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        gameList.status,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Image.network(
                          gameList.awayTeamLogo,
                          width: 50.0,
                          height: 50.0,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/barsa.png',
                              width: 50.0,
                              height: 50.0,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            gameList.awayTeam,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Future<ConnectivityResult> checkConnectivity1() async {
  var connectivityResult = await (Connectivity().checkConnectivity());

  return connectivityResult;
}
