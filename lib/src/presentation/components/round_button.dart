import 'package:emcare/constants.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String insideText;
  final Function customFunction;

  const RoundButton({Key key, @required this.insideText, this.customFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kPrimaryColor,
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(
            vertical: 15,
          ),
        ),
        onPressed: customFunction,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          child: Text(
            insideText.toUpperCase(),
            style: TextStyle(
                // fontSize: size.height * 0.022,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
