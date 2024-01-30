import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nba_hub/features/players/domain/entity/player_entity.dart';

class TeamPlayers extends ConsumerStatefulWidget {
  final List<PlayerEntity> players;

  const TeamPlayers({Key? key, required this.players}) : super(key: key);

  @override
  ConsumerState<TeamPlayers> createState() => _TeamPlayersState();
}

class _TeamPlayersState extends ConsumerState<TeamPlayers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: ListView.builder(
          itemCount: widget.players.length,
          itemBuilder: (BuildContext context, int index) {
            final player = widget.players[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  '/player',
                  arguments: player,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  color: Colors.grey.shade200,
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(player.player.photo),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            player.player.name,
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Height: ${player.player.height} ',
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Age: ${player.player.age}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
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
