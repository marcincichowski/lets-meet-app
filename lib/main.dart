import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:untitled/models/user_model.dart';
import 'package:untitled/services/user_service.dart';
import 'package:untitled/views/UserList.dart';
import 'package:untitled/views/login.dart';
import 'models/game_model.dart';
import 'services/game_service.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      supportedLocales: const [
        Locale('en', ''),
        Locale('pl', ''),
      ],
      home: const Login(),
    );
  }
}
