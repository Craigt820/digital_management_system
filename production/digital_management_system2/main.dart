import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'index.dart';
import 'package:mysql_client/mysql_client.dart';
import 'dart:developer';

var selProj;
MySQLConnectionPool conn;

void main() async {

   conn = MySQLConnectionPool(
      host: '192.168.1.147',
      port: 3306,
      databaseName: 'tracking',
      userName: 'User',
      password: 'idi8@tangos88admin',
      maxConnections: 20);
  // final conn = await MySqlConnection.connect(ConnectionSettings(
  //     host: '192.168.1.147',
  //     port: 3306,
  //     user: 'User',
  //     password: 'idi8@tangos88admin',
  //     db: 'Tracking'));
  // var results = await conn.query("SELECT job_id FROM projects");
  // for (var result in results) {
  //   print('${result[0]}');
  // }

  WidgetsFlutterBinding.ensureInitialized();
  await FlutterFlowTheme.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  void setLocale(Locale value) => setState(() => _locale = value);

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Management Sysem',
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: _themeMode,
      home: HomePageWidget(),
    );
  }
}
