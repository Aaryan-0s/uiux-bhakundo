import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/router/app_route.dart';
import '../../../../core/common/provider/internet_connectivity.dart';
import '../../../players/presentation/viewmodel/player_view_model.dart';
import '../../domain/entity/favourite_entity.dart';
import '../viewmodel/favourite_profile_view_model.dart';

class FavouritePlayerContainer extends ConsumerStatefulWidget {
  final FavouritePlayerEntity player;

  const FavouritePlayerContainer({
    Key? key,
    required this.player,
  }) : super(key: key);

  @override
  ConsumerState<FavouritePlayerContainer> createState() =>
      _FavouritePlayerContainerState();
}

class _FavouritePlayerContainerState
    extends ConsumerState<FavouritePlayerContainer> {
  bool isStarred = true;

  Future<void> onPlayerTap(String id) async {
    await ref.watch(playerViewModelProvider.notifier).getAllPlayerById(id);
    var playerin = ref.watch(playerViewModelProvider);
    print(playerin.playerById);
    if (!mounted) return;

    Navigator.pushNamed(context, AppRoute.player,
        arguments: playerin.playerById[0]);
  }

  Future<void> toggleStar() async {
    try {
      {
        final confirmed = await showConfirmationDialog(context);
        if (confirmed == true) {
          await ref
              .watch(favouritePlayerViewModelProvider.notifier)
              .removeFavouritePlayer(widget.player.playerId);
        }
      }
      await ref
          .watch(favouritePlayerViewModelProvider.notifier)
          .getfavouritePlayer();
    } catch (error) {
      print('Error removing/adding favorite team: $error');
    }
  }

  Future<bool?> showConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Remove from Favorites?'),
          content: const Text(
              'Are you sure you want to remove this team from favorites?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(null);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final internetStatus = ref.watch(connectivityStatusProvider);
    return GestureDetector(
      onTap: () async {
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.none) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No Internet Connection'),
              duration: Duration(seconds: 1),
            ),
          );
        } else {
          onPlayerTap(widget.player.playerId);
        }
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(221, 252, 245, 245),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: internetStatus == ConnectivityStatus.isConnected
                  ? Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.network(
                          widget.player.photoUrl,
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
                      ))
                  : Image.asset(
                      'assets/images/barsa.png',
                      width: 50.0,
                      height: 50.0,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.player.playerName,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 150.0),
            IconButton(
              onPressed: () async {
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
                  toggleStar();
                }
              },
              icon: Icon(
                isStarred
                    ? CupertinoIcons.heart_fill
                    : CupertinoIcons.heart_fill,
                color: isStarred
                    ? const Color.fromARGB(255, 236, 3, 3)
                    : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
