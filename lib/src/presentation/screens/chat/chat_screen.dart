import 'dart:convert';
import 'package:emcare/constants.dart';
import 'package:emcare/src/presentation/screens/chat/widgets/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  const Chat({Key key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final messageInsert = TextEditingController();
  List<Map> messsages = [];
  bool flag = false;
  

  void response(query) async {
    List qresult = await getResponse(query, api_url);
    if (qresult.first['intentDisplayName'] == 'SegundaPregunta') {
      setState(() {
        flag = true;
      });
    }
    printMessages(qresult);
  }

  Future<void> setFeeling(List<Map> messages, userId, String url) async {
    String userMessages = "";
    for (var e in messages) {
      if (e['data'] == 1) {
        userMessages += e['message'];
        userMessages += ". ";
      }
    }

    var endpoint = Uri.parse(url + 'emotion');
    var response = await http.post(
      endpoint,
      body: {
        'message': userMessages,
        'userid': userId,
      },
    );
    print(response.body);
  }

  Future<List> getResponse(queryText, String url) async {
    var endpoint = Uri.parse(url+'dialog');
    var response = await http.post(
      endpoint,
      body: {
        'message': queryText,
      },
    );
    List qresult = json.decode(response.body);
    return qresult;
  }

  void printMessages(qresult) {
    setState(() {
      qresult.forEach((element) {
        messsages.insert(0, {
          "data": 0,
          "message": element['text']['text'][0],
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
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
                    if (flag) {
                      response('auto');
                      setFeeling(messsages, firebaseUser.uid, api_url);
                      setState(() {
                        flag = false;
                      });
                    } else {
                      response(messageInsert.text);
                    }
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
