import 'dart:convert';

import 'package:MeetingApp/common/config.dart';
import 'package:MeetingApp/common/session.dart';
import 'package:MeetingApp/main.dart';
import 'package:MeetingApp/models/message.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  int dialogId;
  String titile;
  ChatPage(this.dialogId, this.titile, {Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState(dialogId, titile);
}

class _ChatPageState extends State<ChatPage> {
  int dialogId;
  String titile;
  TextEditingController messageConrol = TextEditingController();

  _ChatPageState(this.dialogId, this.titile);

  bool isLoading = false;
  List<Message> messages = List<Message>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context, titleText: titile),
      body: isLoading ? Center(child: CircularProgressIndicator()) : getChat(),
    );
  }

  ///Отрисовывает сообщения
  Widget getChat() {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          messages.length == 0
              ? Expanded(
                  child: Center(
                    child: Text("Диалог пуст"),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      var message = messages[index];
                      bool isMe = message.userId == Session.Id;
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(message.text),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  message.timeCreate,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                )
                              ],
                            )
                          ],
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                        margin: EdgeInsets.only(
                            left: isMe ? 80 : 0,
                            bottom: 8,
                            top: 8,
                            right: isMe ? 0 : 80),
                        decoration: BoxDecoration(
                            color: Color(isMe ? 0xFFB1B1B1 : 0xFFD6D4D3),
                            borderRadius: getBorderRadius(isMe)),
                      );
                    },
                  ),
                ),
          buildSender()
        ],
      ),
    );
  }

  ///Отрисовывает форму отправки сообщений
  Widget buildSender() {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            textInputAction: TextInputAction.newline,
            controller: messageConrol,
            textCapitalization: TextCapitalization.sentences,
            decoration:
                InputDecoration.collapsed(hintText: "Введите сообщение..."),
            maxLines: 3,
            minLines: 1,
          )),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () => sendMessage(),
            iconSize: 25,
          ),
        ],
      ),
    );
  }

  Future sendMessage() async {
    var message = messageConrol.text;
    var date = DateTime.now();
    setState(() {
      messageConrol.text = '';
    });
    var uri = Uri.parse(
        '${Config.serverUrl}api/Messages?dialogId=$dialogId&message=$message');
    print(uri);
    try {
      var res = await http.post(uri, headers: Session.authHeaders);
      if (res.statusCode == 200) {
        setState(() {
          messages.insert(
            0,
            Message(
                id: int.parse(res.body),
                userId: Session.Id,
                text: message,
                dateCreateUnix: (date.millisecondsSinceEpoch / 1000).toInt(),
                dateCreate: date),
          );
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Не удалось отправить сообщение');
    }
  }

  ///Получение BorderRadius для сообщения
  BorderRadius getBorderRadius(bool isMe) {
    var r = (double n) => Radius.circular(n);
    return isMe
        ? BorderRadius.only(bottomLeft: r(15), topLeft: r(15))
        : BorderRadius.only(bottomRight: r(15), topRight: r(15));
  }

  ///Получение списка сообщений
  Future getMessages() async {
    print('getDialogs');
    setState(() {
      isLoading = true;
    });
    try {
      var res = await http.get("${Config.serverUrl}api/Messages/$dialogId",
          headers: Session.authHeaders);
      if (res.statusCode == 200) {
        var _json = json.decode(res.body);
        print(res.body);
        messages = (_json as List).map((e) => Message.fromJson(e)).toList();
        messages.sort((a, b) => a.dateCreateUnix < b.dateCreateUnix
            ? 1
            : (a.dateCreateUnix > b.dateCreateUnix ? -1 : 0));
      }
    } catch (e) {
      print(e.toString());
      // dialogs = List<MDialog>();
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
