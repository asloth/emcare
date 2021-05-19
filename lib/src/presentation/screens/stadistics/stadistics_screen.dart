import 'package:charts_flutter/flutter.dart' as charts;
import 'package:emcare/constants.dart';
import 'package:emcare/src/domain/feelings_today_stadistics.dart';
import 'package:emcare/src/presentation/screens/stadistics/widgets/grouped_bar_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Stadistics extends StatelessWidget {
  const Stadistics({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    final Future<List> res = getFeelings(firebaseUser.uid);
    List<charts.Series> data;
    res.then((value) => {data = createSampleData(value)});
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
                              "Emociones detectadas hoy",
                            ),
                            Expanded(
                              child: GroupedBarChart(data),
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
