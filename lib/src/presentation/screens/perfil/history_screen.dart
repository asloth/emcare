import 'package:emcare/constants.dart';
import 'package:emcare/src/domain/today_user_tones.dart';
import 'package:emcare/src/domain/user_tones.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class History extends StatelessWidget {
  const History({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    final fontS = 25.0;
    List<DataRow> allData = <DataRow>[];
    final Future<List> res = getFeelings(firebaseUser.uid);
    res.then((value) => {
      allData = UserTone.setHistory(value[1]),
      
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
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Text('Historial de emociones',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontS,
                    )),
                  ),
                  SingleChildScrollView(
                    child: DataTable(
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            'Fecha',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Emoción',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Probabilidad',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ], 
                      rows: allData,
                    ),
                  )
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
       }

    );
  }
}
