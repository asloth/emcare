import 'package:emcare/constants.dart';
import 'package:emcare/src/domain/analysis_service.dart';
import 'package:emcare/src/presentation/screens/analysis/widgets/recommendation_label.dart';
import 'package:emcare/src/presentation/screens/analysis/widgets/tendency_label.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Analysis extends StatelessWidget {
  const Analysis({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    final Future<Map<String, dynamic>> res =
        AnalysisService.getDataAnalysis(firebaseUser.uid);
    String url, name;
    num slope;
    res.then(
      (value) => {
        url = value['analysis_url'],
        name = value['username'],
        slope = value['slope'],
      },
    );

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
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      ' $name !',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    TendencyLabel(
                      label: AnalysisService.getTendencyLabel(slope),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        image: NetworkImage(url),
                      ),
                    ),
                    RecomendationLabel(
                      label: AnalysisService.getRecommedation(slope),
                    )
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
