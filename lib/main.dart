import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'common/config.dart';
import 'common/routes.dart';
import 'common/theme.dart';
import 'extensions/string_extensions.dart';
import 'screens/Auth/login_screen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // Fluttertoast.showToast(msg: 'Инициализация приложения');
  // var result = await DB.init();
  // Fluttertoast.showToast(
  //     msg: '${result ? "Успешно" : "Не успешно"} создана БД');

  runApp(MultiProvider(
    providers: [
      //Config
      Provider(
        create: (context) => Config(),
      ),
    ],
    child: App(),
  ));
  // runApp(GazonMain());
}

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        "/": (context) => LoginPage(),
      },
      // home: Scaffold(
      //   body: Container(
      //     child: Text('text'),
      //   ),
      // ),
    );
  }
}

/// Получение app bar
AppBar getAppBar(BuildContext context,
    {String titleText, Widget titleWidget, bool leadindIsBackButton = false}) {
  assert(!titleText.isEmptyOrNull || titleWidget != null);
  Widget title;

  if (titleText != null)
    title = Text(
      titleText,
      style: TextStyle(fontSize: 18),
    );
  else
    title = titleWidget;

  Widget leading;
  if (leadindIsBackButton) {
    leading = IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    );
  }

  return AppBar(
    title: title,
    // backgroundColor: Colors.green[800],
    leading: leading,
  );
}

/// Получение Drawer
Drawer getDrawer(BuildContext context) {
  return Drawer(
    elevation: 10,
    child: ListView(
      children: <Widget>[
        new DrawerHeader(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 2,
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
        ),
        _AddButton(
          pathImage: 'assets/images/icons/football_field.png',
          title: 'Главная',
          navigationPath: Routes.fields,
        ),
      ],
    ),
  );
}

/// Формирование кнопки в Drawer
class _AddButton extends StatelessWidget {
  final String pathImage;
  final String title;
  final String navigationPath;
  final IconData icon;
  final bool isReplacementRoute;
  final bool onlyAuthorized;
  final Function onTap;

  const _AddButton(
      {Key key,
      this.pathImage,
      this.icon,
      @required this.title,
      this.navigationPath,
      this.isReplacementRoute = true,
      this.onlyAuthorized = false,
      this.onTap})
      : assert(pathImage != null || icon != null),
        assert(onlyAuthorized != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: icon == null
            ? Image(
                image: AssetImage(pathImage),
                width: 30,
                color: Theme.of(context).colorScheme.defaultColor)
            : Icon(icon,
                size: 30, color: Theme.of(context).colorScheme.defaultColor),
        title: Text(title),
        onTap: onTap ??
            () {
              Fluttertoast.showToast(
                msg: "Клик ! ${this.title}",
              );

              if (isReplacementRoute)
                Navigator.pushReplacementNamed(context, navigationPath);
              else
                Navigator.pushNamed(context, navigationPath);
            });
  }
}
