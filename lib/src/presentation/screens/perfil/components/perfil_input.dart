
import 'package:emcare/constants.dart';
import 'package:flutter/material.dart';

class PerfilInput extends StatelessWidget {
  final IconData icon;
  final text;
  const PerfilInput({ Key key, this.icon = Icons.person, this.text = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        initialValue: text,
        enabled: false,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}