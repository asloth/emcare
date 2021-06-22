import 'package:flutter/material.dart';

class RecomendationLabel extends StatelessWidget {
  final num score;
  const RecomendationLabel({
    Key key,
    this.score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String label = score < 0
        ? 'Si esto sigue así, por favor ten en cuenta acudir con un profesional de la salud'
        : 'Felicidades! De todas formas nos mantendremos atentos a tus estados de ánimo';
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
