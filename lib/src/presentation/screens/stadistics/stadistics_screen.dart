import 'package:charts_flutter/flutter.dart' as charts;
import 'package:emcare/constants.dart';
import 'package:emcare/src/domain/today_user_tones.dart';
import 'package:emcare/src/domain/user_tones.dart';
import 'package:emcare/src/presentation/screens/stadistics/widgets/date_time_line.dart';
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
    List<charts.Series> todayData;
    List<dynamic> allData;
    res.then((value) => {
          todayData = createSampleData(value[0]),
          allData = UserTone.setData(value[1]),
          // print('All data: $allData')
        });
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
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GroupedBarChart(todayData),
                    Container(
                      height: 400,
                      padding: EdgeInsets.all(20),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Total de emociones detectadas",
                              ),
                              Expanded(
                                child: DateTimeComboLinePointChart(allData),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
