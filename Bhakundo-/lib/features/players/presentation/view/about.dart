import 'package:flutter/material.dart';
import 'package:nba_hub/features/players/domain/entity/player_entity.dart';

class About extends StatelessWidget {
  final PlayerEntity player;
  const About({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statistics = player.statistics[0];
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
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: isTablet ? 230 : 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: isTablet ? 10 : 0,
                    ),
                    Text(
                      'Ranking: 1',
                      style: TextStyle(
                        fontSize: isTablet ? 25 : 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Handle container tap
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(player.player.photo),
                              radius: isTablet ? 30 : 20,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Country of Origin: ${player.player.nationality}',
                              style: TextStyle(
                                fontSize: isTablet ? 22 : 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              statistics.team.logo,
                              width: isTablet ? 50 : 40,
                              height: isTablet ? 50 : 40,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Team: ${statistics.team.name}',
                              style: TextStyle(
                                fontSize: isTablet ? 22 : 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(
                      height: isTablet ? 10 : 0,
                    ),
                    Text(
                      'Player Statistics',
                      style: TextStyle(
                        fontSize: isTablet ? 22 : 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Appearances',
                              style: TextStyle(fontSize: isTablet ? 22 : 16),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              statistics.games.appearences.toString(),
                              style: TextStyle(fontSize: isTablet ? 24 : 18),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Lineups',
                              style: TextStyle(fontSize: isTablet ? 22 : 16),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              statistics.games.lineups.toString(),
                              style: TextStyle(fontSize: isTablet ? 24 : 18),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Minutes',
                              style: TextStyle(fontSize: isTablet ? 22 : 16),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              statistics.games.minutes.toString(),
                              style: TextStyle(fontSize: isTablet ? 24 : 18),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Goals',
                              style: TextStyle(fontSize: isTablet ? 22 : 16),
                            ),
                            Text(
                              statistics.goals.total.toString(),
                              style: TextStyle(fontSize: isTablet ? 24 : 18),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Assists',
                              style: TextStyle(fontSize: isTablet ? 22 : 16),
                            ),
                            Text(
                              statistics.goals.assists.toString(),
                              style: TextStyle(fontSize: isTablet ? 24 : 18),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Yellow Cards',
                              style: TextStyle(fontSize: isTablet ? 22 : 16),
                            ),
                            Text(
                              statistics.cards.yellow.toString(),
                              style: TextStyle(fontSize: isTablet ? 24 : 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayerPage extends StatelessWidget {
  final PlayerEntity player;
  const PlayerPage({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 1,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(player.player.photo),
                        radius: 40,
                      ),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.0, 0.5),
                            end: Alignment(0.0, 0.0),
                            colors: <Color>[
                              Color(0x60000000),
                              Color(0x00000000),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  const TabBar(
                    tabs: [
                      Tab(text: "About"),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              About(
                player: player,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
