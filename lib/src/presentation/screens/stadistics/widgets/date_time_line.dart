import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class DateTimeComboLinePointChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DateTimeComboLinePointChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Emociones detectadas en los últimos siete días",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Divider(),
              Expanded(
                child: new charts.BarChart(
                  seriesList,
                  animate: animate,
                  barGroupingType: charts.BarGroupingType.grouped,
                  // Add the series legend behavior to the chart to turn on series legends.
                  // By default the legend will display above the chart.
                  behaviors: [
                    new charts.SeriesLegend(
                        // Configures the "Other" series to be hidden on first chart draw.
                        //defaultHiddenSeries: ['Other'],
                        )
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
