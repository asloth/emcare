import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:emcare/constants.dart';
import 'package:emcare/src/presentation/screens/chat/widgets/message.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class Chat extends StatefulWidget {
  const Chat({Key key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final messageInsert = TextEditingController();
  List<Map> messsages = [];

  void response(query) async {
    DialogAuthCredentials credentials =
        await DialogAuthCredentials.fromFile("assets/df_service.json");

    DialogFlowtter instance = DialogFlowtter(
      credentials: credentials,
    );

    DetectIntentResponse response = await instance.detectIntent(
      queryInput: QueryInput(
        text: TextInput(
          text: query,
          languageCode: "es",
        ),
      ),
    );

    setState(() {
      messsages.insert(0, {
        "data": 0,
        "message": response.text,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 10),
              child: Text(
                "Hoy, ${DateFormat("Hm").format(DateTime.now())}",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Flexible(
              child: ListView.builder(
                reverse: true,
                itemCount: (messsages.length == null) ? 0 : messsages.length,
                itemBuilder: (context, index) => Messages(
                  textmessage: messsages[index]["message"].toString(),
                  data: messsages[index]["data"],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(),
            ListTile(
              title: Container(
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: kBackgroundColor2,
                ),
                padding: EdgeInsets.only(left: 15),
                child: TextFormField(
                  controller: messageInsert,
                  decoration: InputDecoration(
                    hintText: "Escribe un mensaje...",
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
                onPressed: () {
                  if (messageInsert.text.isEmpty) {
                    print("empty message");
                  } else {
                    setState(() {
                      messsages.insert(
                          0, {"data": 1, "message": messageInsert.text});
                    });
                    response(messageInsert.text);
                    messageInsert.clear();
                  }
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
