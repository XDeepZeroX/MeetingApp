import 'dart:convert';

import 'package:MeetingApp/common/config.dart';
import 'package:MeetingApp/common/session.dart';
import 'package:MeetingApp/main.dart';
import 'package:MeetingApp/models/sex.dart';
import 'package:MeetingApp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = false;
  User user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInformation();
  }

  Future getInformation() async {
    setState(() {
      isLoading = true;
    });
    try {
      var res = await http.get('${Config.serverUrl}api/Users/${Session.Id}',
          headers: Session.authHeaders);

      if (res.statusCode == 200) {
        user = User.fromJson(json.decode(res.body));
      }
    } catch (e) {
      print(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context, titleText: 'Профиль'),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : (user == null
              ? Center(child: Text("Сервер не доступен"))
              : Container(
                  child: new ListView(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          //=========================================
                          // Profile Image With Camera Icon & Name
                          //=========================================
                          Container(
                            height: 250.0,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: Stack(
                                      fit: StackFit.loose,
                                      alignment: AlignmentDirectional.center,
                                      children: <Widget>[
                                        //================
                                        //Profile Image
                                        //================
                                        _buildProfileImage(),

                                        //=============
                                        //Camera Icon
                                        //=============
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 100.0, right: 90.0),
                                            child: new Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                new CircleAvatar(
                                                  backgroundColor: Colors.grey,
                                                  radius: 20.0,
                                                  child: new Icon(
                                                    Icons.camera_alt,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                )
                                              ],
                                            )),
                                      ]),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 30),
                                  child: Text(user.fullName,
                                      style: TextStyle(fontSize: 20)),
                                ),
                              ],
                            ),
                          ),

                          Divider(
                            height: 5,
                            color: Colors.grey,
                          ),
                          //=============
                          //     Info
                          //=============
                          Container(
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 25.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  ..._buildField('Возраст', user.age.toString()),
                                  ..._buildField('Пол', Sex.getDescription(user.sex)),
                                  ..._buildField('Ник', user.nickname),
                                  ..._buildField('Город', user.city),
                                  ..._buildField('Почта (E-Mail)', user.email),
                                  ..._buildField(
                                      'Номер телефона', user.phoneNumber),
                                  ..._buildField('О себе', user.briefInformation ?? "Не указано"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
    );
  }

  List<Widget> _buildField(String name, String value) {
    return [
      Padding(
          padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
          child: Text(name,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold))),
      Padding(
          padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 6.0),
          child: Text(value))
    ];
  }

  Widget _buildProfileImage() {
    return Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 4, color: Colors.grey),
          image: DecorationImage(
            image: AssetImage('assets/images/image.png'),
            fit: BoxFit.cover,
          ),
        ));
  }
}
