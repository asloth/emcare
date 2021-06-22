import 'package:emcare/constants.dart';
import 'package:flutter/material.dart';

class TendencyLabel extends StatelessWidget {
  final num score;
  const TendencyLabel({
    Key key,
    this.score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String label = score < 0 ? 'tendencia negativa' : 'tendencia positiva';
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: Text(
        'Hemos detectado una $label en nuestros análisis de tus emociones registradas',
        style: TextStyle(
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
