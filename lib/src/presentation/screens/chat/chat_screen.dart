import 'package:emcare/constants.dart';
import 'package:emcare/src/presentation/components/input_field.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  const Chat({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController newMessage = new TextEditingController();
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Container(
        child: Column(
          children: [
            Spacer(),
            ListTile(
                title: Container(
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: kBackgroundColor2,
                  ),
                  padding: EdgeInsets.only(left: 15),
                  child: TextFormField(
                    controller: newMessage,
                    decoration: InputDecoration(
                      hintText: "Enter a Message...",
                      hintStyle: TextStyle(color: Colors.black26),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    onChanged: (value) {},
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.send,
                    size: 30.0,
                    color: kPrimaryColor,
                  ),
                  onPressed: () {},
                )),
          ],
        ),
      ),
    );
  }
}
