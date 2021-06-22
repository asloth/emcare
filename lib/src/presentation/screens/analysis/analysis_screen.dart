import 'package:emcare/constants.dart';
import 'package:emcare/src/domain/analysis_service.dart';
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
    String url;

    res.then(
      (value) => {
        url = value['analysis_url'],
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('habla causa komo stas'),
                    Image(
                      image: NetworkImage(url),
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
