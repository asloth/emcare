import 'package:flutter/material.dart';

class RecomendationLabel extends StatelessWidget {
  final String label;
  const RecomendationLabel({
    Key key,
    this.label = 's',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: Text(
        '$label',
        style: TextStyle(
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
