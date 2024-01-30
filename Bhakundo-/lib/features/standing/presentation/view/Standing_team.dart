import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nba_hub/config/router/app_route.dart';
import 'package:nba_hub/features/standing/domain/entity/standing_entity.dart';

import '../../../../core/common/provider/internet_connectivity.dart';

class StandingTeam extends ConsumerStatefulWidget {
  final List<StandingEntity> standing;

  const StandingTeam({Key? key, required this.standing}) : super(key: key);

  @override
  ConsumerState<StandingTeam> createState() => _StandingTeamState();
}

class _StandingTeamState extends ConsumerState<StandingTeam> {
  @override
  Widget build(BuildContext context) {
    final internetStatus = ref.watch(connectivityStatusProvider);
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;
    return Scaffold(
      body: SafeArea(
        child: OrientationBuilder(builder: (context, orientation) {
          final isHorizontal = orientation == Orientation.landscape;
          final columnSpacing = isTablet
              ? isHorizontal
                  ? 124.0
                  : 76.0
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
                padding: const EdgeInsets.all(10.0),
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
                            'Rank',
                            style: TextStyle(
                              fontSize: isTablet ? 22 : 15,
                            ),
                          )),
                          DataColumn(
                              label: Text(
                            'Status',
                            style: TextStyle(
                              fontSize: isTablet ? 22 : 15,
                            ),
                          )),
                          DataColumn(
                              label: Text(
                            'Team',
                            style: TextStyle(
                              fontSize: isTablet ? 22 : 15,
                            ),
                          )),
                          DataColumn(
                              label: Text(
                            'GP',
                            style: TextStyle(
                              fontSize: isTablet ? 22 : 15,
                            ),
                          )),
                          DataColumn(
                              label: Text(
                            'GW',
                            style: TextStyle(
                              fontSize: isTablet ? 22 : 15,
                            ),
                          )),
                          DataColumn(
                              label: Text(
                            'GL',
                            style: TextStyle(
                              fontSize: isTablet ? 22 : 15,
                            ),
                          )),
                          DataColumn(
                              label: Text(
                            'GD',
                            style: TextStyle(
                              fontSize: isTablet ? 22 : 15,
                            ),
                          )),
                          DataColumn(
                              label: Text(
                            'PT',
                            style: TextStyle(
                              fontSize: isTablet ? 22 : 15,
                            ),
                          )),
                        ],
                        rows: widget.standing.map(
                          (standing) {
                            final abbreviation = getAbbreviation(standing.name);
                            return DataRow(
                              cells: [
                                DataCell(Text(
                                  standing.rank.toString(),
                                  style: TextStyle(
                                    fontSize: isTablet ? 20 : 14,
                                  ),
                                )),
                                DataCell(
                                  getStatusIndicator(standing.status),
                                ),
                                DataCell(
                                  GestureDetector(
                                    onTap: () async {
                                      // Handle team cell click
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
                                        Navigator.pushNamed(
                                            context, AppRoute.teams,
                                            arguments: standing);
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        internetStatus ==
                                                ConnectivityStatus.isConnected
                                            ? Image.network(
                                                standing.logo,
                                                width: isTablet ? 30 : 24,
                                                height: isTablet ? 30 : 24,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
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
                                          abbreviation,
                                          style: TextStyle(
                                            fontSize: isTablet ? 20 : 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                DataCell(Text(
                                  standing.played.toString(),
                                  style: TextStyle(
                                    fontSize: isTablet ? 20 : 14,
                                  ),
                                )),
                                DataCell(Text(
                                  standing.win.toString(),
                                  style: TextStyle(
                                    fontSize: isTablet ? 20 : 14,
                                  ),
                                )),
                                DataCell(Text(
                                  standing.lose.toString(),
                                  style: TextStyle(
                                    fontSize: isTablet ? 20 : 14,
                                  ),
                                )),
                                DataCell(Text(
                                  standing.draw.toString(),
                                  style: TextStyle(
                                    fontSize: isTablet ? 20 : 14,
                                  ),
                                )),
                                DataCell(Text(
                                  standing.points.toString(),
                                  style: TextStyle(
                                    fontSize: isTablet ? 20 : 14,
                                  ),
                                )),
                              ],
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  String getAbbreviation(String name) {
    final words = name.split(' ');
    final initials = words.map((word) => word[0]).join('');
    return initials.toUpperCase();
  }

  Widget getStatusIndicator(String status) {
    IconData icon;
    Color color;

    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;

    if (status == 'up') {
      icon = Icons.arrow_upward;
      color = Colors.green;
    } else if (status == 'down') {
      icon = Icons.arrow_downward;
      color = Colors.red;
    } else {
      icon = Icons.remove;
      color = Colors.grey;
    }

    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: isTablet ? 25 : 18.0,
        ),
        const SizedBox(width: 4.0),
      ],
    );
  }
}
