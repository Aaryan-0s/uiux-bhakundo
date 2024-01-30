import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../games/domain/entity/game_entity.dart';
import '../viewmodel/fixture_view_model.dart';

class FixtureStats extends ConsumerStatefulWidget {
  final GameEntity game;

  const FixtureStats({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  ConsumerState<FixtureStats> createState() => _FixtureStatsState();
}

class _FixtureStatsState extends ConsumerState<FixtureStats> {
  Timer? _timer;
  void startTimer() {
    const duration = Duration(seconds: 60);
    _timer = Timer.periodic(duration, (_) {
      _fetchGames();
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> _fetchGames() async {
    await ref
        .read(fixtureViewModelProvider.notifier)
        .getFixtureById(widget.game.fixtureId.toString());
    await ref.read(fixtureViewModelProvider.notifier).getFixtureInfo(
        widget.game.fixtureId.toString()); // Function to fetch games
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(fixtureViewModelProvider.notifier)
          .getFixtureById(widget.game.fixtureId.toString());
      ref.read(fixtureViewModelProvider.notifier).getFixtureInfo(
          widget.game.fixtureId.toString()); // Function to fetch games
    });
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var stats = ref.watch(fixtureViewModelProvider);
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Game Status: ${stats.fixtureInfo.isNotEmpty ? stats.fixtureInfo[0].status : "N/A"}',
                    style: TextStyle(
                      fontSize: isTablet ? 20 : 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: isTablet ? 10 : 8.0),
                  Text(
                    'Game score: ${stats.fixtureInfo.isNotEmpty ? stats.fixtureInfo[0].score : "N/A"}',
                    style: TextStyle(
                      fontSize: isTablet ? 25 : 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Fixture Stats',
                    style: TextStyle(
                      fontSize: isTablet ? 30 : 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isTablet ? 20 : 16.0),
                  for (final team in stats.fixture)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          team.name,
                          style: TextStyle(
                            fontSize: isTablet ? 25 : 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: isTablet ? 10 : 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: LinearProgressIndicator(
                                value: int.parse(team.ballPossession) / 100,
                                backgroundColor: Colors.grey,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.green),
                                minHeight: isTablet ? 15 : 10.0,
                              ),
                            ),
                            SizedBox(width: isTablet ? 10 : 8.0),
                            Text(
                              '${team.ballPossession}%',
                              style: TextStyle(
                                fontSize: isTablet ? 20 : 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Shots on Goal',
                                  style: TextStyle(
                                    fontSize: isTablet ? 20 : 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: LinearProgressIndicator(
                                  value: team.shotsOnGoal / 50,
                                  backgroundColor: Colors.grey,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.blue),
                                  minHeight: isTablet ? 15 : 10.0,
                                ),
                              ),
                              SizedBox(width: isTablet ? 10 : 8.0),
                              Text(
                                team.shotsOnGoal.toString(),
                                style: TextStyle(
                                  fontSize: isTablet ? 20 : 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Shots off Goal',
                                  style: TextStyle(
                                    fontSize: isTablet ? 20 : 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: LinearProgressIndicator(
                                  value: team.shotsOffGoal / 50,
                                  backgroundColor: Colors.grey,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.blue),
                                  minHeight: isTablet ? 15 : 10,
                                ),
                              ),
                              SizedBox(width: isTablet ? 10 : 8.0),
                              Text(
                                team.shotsOffGoal.toString(),
                                style: TextStyle(
                                  fontSize: isTablet ? 20 : 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Total Shots',
                                  style: TextStyle(
                                    fontSize: isTablet ? 20 : 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: LinearProgressIndicator(
                                  value: team.totalShots / 50,
                                  backgroundColor: Colors.grey,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.blue),
                                  minHeight: isTablet ? 15 : 10,
                                ),
                              ),
                              SizedBox(width: isTablet ? 10 : 8.0),
                              Text(
                                team.totalShots.toString(),
                                style: TextStyle(
                                  fontSize: isTablet ? 20 : 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Blocked Shots',
                                  style: TextStyle(
                                    fontSize: isTablet ? 20 : 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: LinearProgressIndicator(
                                  value: team.blockedShots / 50,
                                  backgroundColor: Colors.grey,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.blue),
                                  minHeight: isTablet ? 15 : 10,
                                ),
                              ),
                              SizedBox(width: isTablet ? 10 : 8.0),
                              Text(
                                team.blockedShots.toString(),
                                style: TextStyle(
                                  fontSize: isTablet ? 20 : 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Shots inside box',
                                  style: TextStyle(
                                    fontSize: isTablet ? 20 : 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: LinearProgressIndicator(
                                  value: team.shotsInsideBox / 50,
                                  backgroundColor: Colors.grey,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.blue),
                                  minHeight: isTablet ? 15 : 10,
                                ),
                              ),
                              SizedBox(width: isTablet ? 10 : 8.0),
                              Text(
                                team.shotsInsideBox.toString(),
                                style: TextStyle(
                                  fontSize: isTablet ? 20 : 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Shots outside box',
                                  style: TextStyle(
                                    fontSize: isTablet ? 20 : 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: LinearProgressIndicator(
                                  value: team.shotsOutsideBox / 50,
                                  backgroundColor: Colors.grey,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.blue),
                                  minHeight: isTablet ? 15 : 10,
                                ),
                              ),
                              SizedBox(width: isTablet ? 10 : 8.0),
                              Text(
                                team.shotsOutsideBox.toString(),
                                style: TextStyle(
                                  fontSize: isTablet ? 20 : 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Fouls',
                                  style: TextStyle(
                                    fontSize: isTablet ? 20 : 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: LinearProgressIndicator(
                                  value: team.fouls / 50,
                                  backgroundColor: Colors.grey,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.blue),
                                  minHeight: isTablet ? 15 : 10,
                                ),
                              ),
                              SizedBox(width: isTablet ? 10 : 8.0),
                              Text(
                                team.fouls.toString(),
                                style: TextStyle(
                                  fontSize: isTablet ? 20 : 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Corner Kicks',
                                  style: TextStyle(
                                    fontSize: isTablet ? 20 : 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: LinearProgressIndicator(
                                  value: team.cornerKicks / 50,
                                  backgroundColor: Colors.grey,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.blue),
                                  minHeight: isTablet ? 15 : 10,
                                ),
                              ),
                              SizedBox(width: isTablet ? 10 : 8.0),
                              Text(
                                team.cornerKicks.toString(),
                                style: TextStyle(
                                  fontSize: isTablet ? 20 : 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Offsides',
                                  style: TextStyle(
                                    fontSize: isTablet ? 20 : 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: LinearProgressIndicator(
                                  value: team.offsides / 50,
                                  backgroundColor: Colors.grey,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.blue),
                                  minHeight: isTablet ? 15 : 10,
                                ),
                              ),
                              SizedBox(width: isTablet ? 10 : 8.0),
                              Text(
                                team.offsides.toString(),
                                style: TextStyle(
                                  fontSize: isTablet ? 25 : 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: isTablet ? 20 : 16.0),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
