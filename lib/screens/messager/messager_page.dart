import 'dart:convert';

import 'package:MeetingApp/common/config.dart';
import 'package:MeetingApp/common/session.dart';
import 'package:MeetingApp/main.dart';
import 'package:MeetingApp/models/dialog.dart';
import 'package:MeetingApp/screens/messager/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MessagerPage extends StatefulWidget {
  MessagerPage({Key key}) : super(key: key);

  @override
  _MessagerPageState createState() => _MessagerPageState();
}

class _MessagerPageState extends State<MessagerPage> {
  bool isLoading = false;
  List<MDialog> dialogs = List<MDialog>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDialogs();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context, titleText: 'Сообщения'),
      body: RefreshIndicator(
        onRefresh: () async => await getDialogs(),
        child: dialogs.length == 0
            ? Center(child: Text("У вас ещё нет диалогов"))
            : ListView.separated(
                itemCount: dialogs.length,
                itemBuilder: (context, index) {
                  var dialog = dialogs[index];
                  var title = dialog.title;
                  if (title == null) {
                    var user = dialog.users
                        .firstWhere((e) => e.id == dialog.createUserId);
                    title = '${user.firstName} ${user.lastName}';
                  }
                  return ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Image.asset('assets/images/image.png'),
                    title: Text(title),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatPage(dialog.id, title))),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
              ),
      ),
    );
  }

  Future getDialogs() async {
    print('getDialogs');
    setState(() {
      isLoading = true;
    });
    try {
      var res = await http.get("${Config.serverUrl}api/Dialogs",
          headers: Session.authHeaders);
      if (res.statusCode == 200) {
        var _json = json.decode(res.body);
        dialogs = (_json as List).map((e) => MDialog.fromJson(e)).toList();
      }
    } catch (e) {
      print(e.toString());
      dialogs = List<MDialog>();
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
