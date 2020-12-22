import 'package:MeetingApp/main.dart';
import 'package:flutter/material.dart';

class MessagerPage extends StatefulWidget {
  MessagerPage({Key key}) : super(key: key);

  @override
  _MessagerPageState createState() => _MessagerPageState();
}

class _MessagerPageState extends State<MessagerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context, titleText: 'Сообщения'),
      body: Text("Сообщения"),
    );
  }
}
