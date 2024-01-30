import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nba_hub/core/common/snackbar/my_snackbar.dart';
import 'package:nba_hub/features/games/presentation/widget/game_fixture.dart';

import '../viewmodel/game_view_model.dart';

class Home extends ConsumerStatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  DateTime selectedDate = DateTime.now();
  Timer? _timer;

  Future<void> _openCalendar() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
      final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      final seasonYear = selectedDate.year.toString();
      await ref
          .read(gameViewModelProvider.notifier)
          .getAllGameByDate(seasonYear, formattedDate);
    }
  }

  void _decrementDate() async {
    setState(() {
      selectedDate = selectedDate.subtract(const Duration(days: 1));
    });
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    final seasonYear = selectedDate.year.toString();
    await ref
        .read(gameViewModelProvider.notifier)
        .getAllGameByDate(seasonYear, formattedDate);
  }

  void _incrementDate() async {
    setState(() {
      selectedDate = selectedDate.add(const Duration(days: 1));
    });
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    final seasonYear = selectedDate.year.toString();
    await ref
        .read(gameViewModelProvider.notifier)
        .getAllGameByDate(seasonYear, formattedDate);
  }

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
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    final seasonYear = selectedDate.year.toString();
    await ref
        .watch(gameViewModelProvider.notifier)
        .getAllGameByDate(seasonYear, formattedDate);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(gameViewModelProvider.notifier).getAllGames();
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
    var gameState = ref.watch(gameViewModelProvider);

    print(gameState);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    final double iconSize = isTablet ? 40.0 : 24.0;
    final double fontSize = isTablet ? 20.0 : 16.0;

    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: _decrementDate,
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _openCalendar,
                ),
                Text(
                  formattedDate,
                  style: TextStyle(fontSize: fontSize),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () async {
                    showSnackBar(
                      context: context,
                      message: 'Refreshing...',
                      color: Colors.green,
                    );
                    await ref
                        .watch(gameViewModelProvider.notifier)
                        .getAllGames();
                  },
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: _incrementDate,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Image.asset(
                'assets/images/background.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              if (gameState.games.isEmpty)
                Center(
                  child: Text(
                    'No games for today',
                    style: TextStyle(
                      fontSize: fontSize * 2,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              GameFixture(gameList: gameState.games),
            ],
          ),
        ),
      ),
    );
  }
}
