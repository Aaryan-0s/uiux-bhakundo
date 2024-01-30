import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/router/app_route.dart';
import '../../../../core/common/provider/internet_connectivity.dart';
import '../../../standing/presentation/viewmodel/standing_view_model.dart';
import '../../domain/entity/favourite_entity.dart';
import '../viewmodel/favourite_profile_view_model.dart';

class FavouriteTeamContainer extends ConsumerStatefulWidget {
  final FavouriteEntity team;

  const FavouriteTeamContainer({
    Key? key,
    required this.team,
  }) : super(key: key);

  @override
  ConsumerState<FavouriteTeamContainer> createState() =>
      _FavouriteTeamContainerState();
}

class _FavouriteTeamContainerState
    extends ConsumerState<FavouriteTeamContainer> {
  bool isStarred = true;

  Future<void> onTeamTap(String id) async {
    await ref.watch(standingViewModelProvider.notifier).getStandingByTeamId(id);
    var standingin = ref.watch(standingViewModelProvider);
    print(standingin.standingByid);
    if (!mounted) return;

    Navigator.pushNamed(context, AppRoute.teams,
        arguments: standingin.standingByid[0]);
  }

  Future<void> toggleStar() async {
    try {
      {
        final confirmed = await showConfirmationDialog(context);
        if (confirmed == true) {
          await ref
              .watch(favouriteViewModelProvider.notifier)
              .removeFavourite(widget.team.teamId);
        }
      }
      await ref.watch(favouriteViewModelProvider.notifier).getfavourite();
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
    return Container(
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
                        widget.team.logoUrl,
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
            child: GestureDetector(
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
                  onTeamTap(widget.team.teamId);
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.team.teamName,
                    style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ],
              ),
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
              isStarred ? Icons.star : Icons.star_border,
              color: isStarred ? Colors.yellow : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
