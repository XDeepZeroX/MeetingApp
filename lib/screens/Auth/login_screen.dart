import 'package:MeetingApp/common/routes.dart';
import 'package:MeetingApp/helpers/media_query_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isAuthenticating = false;
  bool isAviableFingerprint = false;

  // bool _rememberMe = false;
  String email = "test@test.ru";
  String password = "672412Aa";

  @override
  void initState() {
    super.initState();
  }

  ///Авторизация пользователя после ввода пароля или отпесчатка пальца
  Future authorize() async {
    ///Переход к приложению
    Navigator.pushReplacementNamed(context, Routes.fields);
  }

  @override
  Widget build(BuildContext context) {
    double width = MQuery.getWidth(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: getAppBar(context, titleText: 'Аавторизация'),
      drawer: getDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image(
              image: AssetImage('assets/images/logo.png'),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                    ),
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Пароль",
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                    ),
                    onChanged: (value) => password = value,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: <Widget>[
                            SwitchRememberMe(),
                            Text("Запомнить меня")
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.green[900],
                      child: Text("Войти"),
                      onPressed: () {
                        if (!_isAuthenticating) authorize();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.black38,
                      child: Text("Демо"),
                      onPressed: () {
                        Fluttertoast.showToast(
                          msg: "Кнопка демо !",
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        padding: EdgeInsets.all(0),
                        child: Text("Забыл пароль"),
                        onPressed: () {
                          Fluttertoast.showToast(
                            msg: "Кнопка забыл пароль !",
                          );
                        },
                      ),
                      FlatButton(
                        padding: EdgeInsets.all(0),
                        child: Text("Регистрация"),
                        onPressed: () {
                          Fluttertoast.showToast(
                            msg: "Кнопка зарегистрироваться !",
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SwitchRememberMe extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SwitchRememberMe();
}

class _SwitchRememberMe extends State<SwitchRememberMe> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      onChanged: (bool value) async {
        setState(() {
          Fluttertoast.showToast(
            msg: "Кнопка запомнить !",
          );
          this._rememberMe = value;
        });
      },
      value: this._rememberMe,
    );
  }
}
