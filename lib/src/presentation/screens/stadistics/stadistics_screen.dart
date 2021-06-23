import 'package:charts_flutter/flutter.dart' as charts;
import 'package:emcare/constants.dart';
import 'package:emcare/src/domain/today_user_tones.dart';
import 'package:emcare/src/domain/user_tones.dart';
import 'package:emcare/src/presentation/screens/stadistics/widgets/date_time_line.dart';
import 'package:emcare/src/presentation/screens/stadistics/widgets/empty_container.dart';
import 'package:emcare/src/presentation/screens/stadistics/widgets/grouped_bar_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Stadistics extends StatelessWidget {
  const Stadistics({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    final firebaseUser = context.watch<User>();
    final Future<List> res = getFeelings(firebaseUser.uid);
    List<charts.Series> todayData;
    List<dynamic> allData;
    List todayFlag, lastSevenDaysFlag;
    res.then((value) => {
          todayFlag = value[0],
          lastSevenDaysFlag = value[1],
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
                        : EmptyContainer(
                            message:
                                'Hoy no hemos detectado ninguna emoción, por favor conversa con el chatbot',
                          ),
                    (lastSevenDaysFlag.isNotEmpty)
                        ? DateTimeComboLinePointChart(allData)
                        : EmptyContainer(
                            message:
                                'No encontramos registros en los últimos siete días',
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
