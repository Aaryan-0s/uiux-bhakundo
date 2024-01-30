import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:nba_hub/features/Team/domain/entity/team_entity.dart';

import '../../../standing/domain/entity/standing_entity.dart';

class TeamStats extends StatelessWidget {
  final StandingEntity team;
  final List<TeamEntity> stats;
  const TeamStats({
    Key? key,
    required this.stats,
    required this.team,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TeamEntity teamEntity = stats.first;
    final ForAgainst datumFor = teamEntity.datumFor;
    final ForAgainst against = teamEntity.against;

    final Total totalFor = datumFor.total;
    final Average averageFor = datumFor.average;
    final Map<String, Minute> minuteFor = datumFor.minute;

    final Total totalAgainst = against.total;
    final Average averageAgainst = against.average;
    final Map<String, Minute> minuteAgainst = against.minute;

    // Printing the extracted data
    print(
        'Total For - Home: ${totalFor.home}, Away: ${totalFor.away}, Total: ${totalFor.total}');
    print(
        'Average For - Home: ${averageFor.home}, Away: ${averageFor.away}, Total: ${averageFor.total}');
    print(
        'Total Against - Home: ${totalAgainst.home}, Away: ${totalAgainst.away}, Total: ${totalAgainst.total}');
    print(
        'Average Against - Home: ${averageAgainst.home}, Away: ${averageAgainst.away}, Total: ${averageAgainst.total}');

    List<MapEntry<String, int>> goalsData = [];

    minuteFor.forEach((key, value) {
      goalsData.add(MapEntry(key, value.total));
    });
    print(goalsData);

    final series = [
      charts.Series<MapEntry<String, int>, String>(
        id: 'Goals',
        domainFn: (MapEntry<String, int> entry, _) => entry.key,
        measureFn: (MapEntry<String, int> entry, _) => entry.value,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        data: goalsData,
      ),
    ];

    List<MapEntry<String, int>> goalsAgainstData = [];

    minuteAgainst.forEach((key, value) {
      goalsAgainstData.add(MapEntry(key, value.total));
    });

    final seriesAgainst = [
      charts.Series<MapEntry<String, int>, String>(
        id: 'Goals Against',
        domainFn: (MapEntry<String, int> entry, _) => entry.key,
        measureFn: (MapEntry<String, int> entry, _) => entry.value,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        data: goalsAgainstData,
      ),
    ];

    final chart = charts.BarChart(
      series,
      animate: true,
      domainAxis: const charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelRotation: 45,
          labelStyle: charts.TextStyleSpec(
            fontSize: 14,
          ),
        ),
      ),
      primaryMeasureAxis: const charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 14,
          ),
        ),
      ),
    );

    final chartAgainst = charts.BarChart(
      seriesAgainst,
      animate: true,
      domainAxis: const charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelRotation: 45,
          labelStyle: charts.TextStyleSpec(
            fontSize: 14,
          ),
        ),
      ),
      primaryMeasureAxis: const charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 14,
          ),
        ),
      ),
    );

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
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            'Points',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Rank : ${team.rank}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 180),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        team.points.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: DataTable(
                    columnSpacing: 20.0,
                    columns: const [
                      DataColumn(label: Text('')),
                      DataColumn(label: Text('PL')),
                      DataColumn(label: Text('W')),
                      DataColumn(label: Text('D')),
                      DataColumn(label: Text('L')),
                      DataColumn(label: Text('GD')),
                      DataColumn(label: Text('PTS')),
                    ],
                    rows: [
                      DataRow(cells: [
                        const DataCell(Text("total")),
                        DataCell(Text(team.played.toString())),
                        DataCell(Text(team.win.toString())),
                        DataCell(Text(team.draw.toString())),
                        DataCell(Text(team.lose.toString())),
                        DataCell(Text(team.goalsDiff.toString())),
                        DataCell(Text(team.played.toString())),
                      ]),
                    ],
                  ),
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
                    const Text(
                      'Goals Scored',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      child: chart,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Goals Against',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      child: chartAgainst,
                    ),
                    const Text(
                      'Time',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
