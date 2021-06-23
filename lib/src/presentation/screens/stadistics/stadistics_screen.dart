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
    Size size = MediaQuery.of(context).size;
    final firebaseUser = context.watch<User>();
    final Future<List> res = getFeelings(firebaseUser.uid);
    List<charts.Series> todayData;
    List<dynamic> allData;
    List todayFlag;
    res.then((value) => {
          todayFlag = value[0],
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
            backgroundColor: kBackgroundColor,
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    (todayFlag.isNotEmpty)
                        ? GroupedBarChart(todayData)
                        : Container(
                            padding: EdgeInsets.all(20),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 8.0),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.sentiment_dissatisfied,
                                      size: 30,
                                    ),
                                    Text(
                                      'Hoy no hemos detectado ninguna emoción, por favor conversa con el chatbot',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    Container(
                      height: 400,
                      width: size.width * 0.9,
                      padding: EdgeInsets.symmetric(
                          vertical: 20, horizontal: size.width * 0.05),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
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
