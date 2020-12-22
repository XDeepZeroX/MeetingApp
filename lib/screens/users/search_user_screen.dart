import 'dart:convert';
import 'dart:ui';

import 'package:MeetingApp/common/config.dart';
import 'package:MeetingApp/common/session.dart';
import 'package:MeetingApp/main.dart';
import 'package:MeetingApp/models/sex.dart';
import 'package:MeetingApp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'test.dart';

class SearchUserPage extends StatefulWidget {
  SearchUserPage({Key key}) : super(key: key);

  @override
  _SearchUserPageState createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage> {
  String _city = '';
  int _sex = Sex.Girl;
  int _minAge = 0;
  int _maxAge = 100 + 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context,
          titleWidget: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Поиск"),
              FlatButton(
                minWidth: 0,
                onPressed: () => print('click'),
                shape: CircleBorder(),
                child: Image.asset(
                  'assets/images/filter.png',
                  width: 30,
                ),
                padding: EdgeInsets.all(10),
              ),
            ],
          )),
      body: FutureBuilder(
        future: getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text("Нет соединения с сетью",
                    style: TextStyle(color: Colors.red)));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: (snapshot.data as List).length,
              itemBuilder: (context, index) {
                var item = snapshot.data[index] as User;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.asset(
                      'assets/images/image.png',
                      width: 40,
                    ),
                    title: Text("${item.firstName} ${item.lastName}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Возраст: ${item.age}"),
                        Text(
                          "О себе: ${item.briefInformation ?? 'Информация не указана'}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    trailing: FlatButton(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(10),
                        onPressed: () => print('open messager'),
                        child: Icon(Icons.message),
                        minWidth: 0),
                    onTap: () => showUserInformation(item),
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<List<User>> getUsers() async {
    try {
      print('test');
      print(
          '${Config.serverUrl}api/Search?city=$_city&sex=$_sex&minAge=$_minAge&maxAge=$_maxAge');
      print(Session.authHeaders);
      var res = await http.get(
          "${Config.serverUrl}api/Search?city=$_city&sex=$_sex&minAge=$_minAge&maxAge=$_maxAge",
          headers: Session.authHeaders);
      if (res.statusCode == 200) {
        var _json = json.decode(res.body);
        var list = (_json as List).map((e) => User.fromJson(e)).toList();
        return list;
      }
    } catch (e) {
      print(e.toString() + '12');
    }
    return List<User>();
  }

  /// Выезжающая информация о пользователе
  Future showUserInformation(User user) async {
    print(user.toJson());
    double width = MediaQuery.of(context).size.width * 100;
    await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.grey.shade50,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (context1) => SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _buildHeader(context, width, user),
                  SizedBox(height: 10.0),
                  _buildInfo(context, width, user),
                ],
              ),
            ));
  }

  /// Отрисовывет имя пользователя в выезжающем меню
  Widget _buildMainInfo(BuildContext context, double width, User user) {
    return Container(
      width: width,
      margin: const EdgeInsets.all(10),
      alignment: AlignmentDirectional.center,
      child: Column(
        children: <Widget>[
          Text('${user.firstName} ${user.lastName}',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  /// Отрисовывает карточку выезжающей информации о пользователе
  Widget _buildInfoCard(context, User user) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Card(
            elevation: 5.0,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 16.0, bottom: 16.0, right: 10.0, left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        'Фото',
                        style: new TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: new Text(
                          user.photos.length.toString(),
                          style: new TextStyle(
                              fontSize: 18.0,
                              color: Color(0Xffde6262),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  new Column(
                    children: <Widget>[
                      new Text(
                        'Возраст',
                        style: new TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: new Text(
                          user.age.toString(),
                          style: new TextStyle(
                              fontSize: 18.0,
                              color: Color(0Xffde6262),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  ///Отрисовывает заголовок выезжающей информации о пользователе
  Widget _buildHeader(BuildContext context, double width, User user) {
    return Stack(
      children: [
        Ink(height: 250, color: Colors.purpleAccent[400]),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 50),
          child: Column(
            children: <Widget>[
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                color: Colors.deepOrange,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: Colors.white,
                      width: 3.0,
                    ),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: Image.asset('assets/images/image.png',
                          width: 80, height: 80, fit: BoxFit.fill)),
                ),
              ),
              _buildMainInfo(context, width, user)
            ],
          ),
        ),
        Container(
            margin: const EdgeInsets.only(top: 210),
            child: _buildInfoCard(context, user))
      ],
    );
  }

  ///Отрисовывает тело информации о пользователе
  Widget _buildInfo(BuildContext context, double width, User user) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Card(
          color: Colors.white,
          child: Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    ListTile(
                      leading:
                          Icon(Icons.email, color: Colors.deepOrangeAccent),
                      title: Text("Почта (E-mail)",
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                      subtitle: Text(user.email,
                          style:
                              TextStyle(fontSize: 15, color: Colors.black54)),
                    ),
                    Divider(),
                    ListTile(
                      leading:
                          Icon(Icons.phone, color: Colors.deepOrangeAccent),
                      title: Text("Номер телефона",
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                      subtitle: Text(
                          user.phoneNumber.substring(0, 4) + '********',
                          style:
                              TextStyle(fontSize: 15, color: Colors.black54)),
                    ),
                    Divider(),
                    ListTile(
                      leading:
                          Icon(Icons.person, color: Colors.deepOrangeAccent),
                      title: Text("О себе",
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                      subtitle: Text(
                          user.briefInformation ?? "Информация не указана",
                          style:
                              TextStyle(fontSize: 15, color: Colors.black54)),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
