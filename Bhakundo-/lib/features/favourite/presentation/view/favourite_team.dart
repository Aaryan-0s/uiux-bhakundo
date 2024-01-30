import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shake/shake.dart';

import '../../../../core/common/snackbar/my_snackbar.dart';
import '../viewmodel/favourite_profile_view_model.dart';
import '../widget/favourite_team_widget.dart';

class FavouriteTeams extends ConsumerStatefulWidget {
  const FavouriteTeams({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<FavouriteTeams> createState() => _FavouriteTeamsState();
}

class _FavouriteTeamsState extends ConsumerState<FavouriteTeams> {
  late ShakeDetector detector;

  @override
  void initState() {
    super.initState();

    detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        ref.watch(favouriteViewModelProvider.notifier).getfavourite();
        showSnackBar(
          message: 'Refreshing data...',
          context: context,
          color: Colors.blue,
        );
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 7.5,
    );
    Future(() async {
      await ref.watch(favouriteViewModelProvider.notifier).getfavourite();
    });
  }

  @override
  void dispose() {
    super.dispose();
    detector.stopListening();
  }

  @override
  Widget build(BuildContext context) {
    final favouriteViewModel = ref.watch(favouriteViewModelProvider);

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
          child: favouriteViewModel.isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : favouriteViewModel.check.isEmpty
                  ? const Center(
                      child: Text(
                        "No teams in favourite",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: favouriteViewModel.check.length,
                      itemBuilder: (context, index) {
                        final team = favouriteViewModel.check[index];
                        return FavouriteTeamContainer(
                          team: team,
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
