import 'package:charts_flutter/flutter.dart' as charts;
import 'package:emcare/constants.dart';
import 'package:emcare/src/domain/feelings_today_stadistics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class Stadistics extends StatelessWidget {
  const Stadistics({Key key, @required this.data}) : super(key: key);

  final List<TodayFeelings> data;

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    final Future<Response> res = getFeelings(firebaseUser.uid);

    List<charts.Series<TodayFeelings, String>> series = [
      charts.Series(
          id: "Price",
          data: data,
          domainFn: (TodayFeelings series, _) => series.month,
          measureFn: (TodayFeelings series, _) => series.price,
          colorFn: (TodayFeelings series, _) => series.barColor),
    ];

    return FutureBuilder(
      future: res,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error.toString()}'),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 400,
                    padding: EdgeInsets.all(20),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Bitcoin price from Jan to March (2021) ",
                            ),
                            Expanded(
                              child: (charts.BarChart(series, animate: true)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Container(
          color: kBackgroundColor,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
