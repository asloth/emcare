import 'package:flutter/material.dart';

class TendencyLabel extends StatelessWidget {
  final String label;
  const TendencyLabel({
    Key key,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
