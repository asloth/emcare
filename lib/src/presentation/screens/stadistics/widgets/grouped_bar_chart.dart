import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class GroupedBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  GroupedBarChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Emociones detectadas hoy",
              ),
              Expanded(
                child: new charts.BarChart(
                  seriesList,
                  animate: animate,
                  barGroupingType: charts.BarGroupingType.grouped,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
