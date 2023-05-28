import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:untitled/models/user_model.dart';
import 'package:untitled/services/user_service.dart';
import 'package:untitled/views/UserList.dart';
import 'package:untitled/views/login.dart';
import 'models/game_model.dart';
import 'services/game_service.dart';

void main() => runApp(const MyApp());

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

      home: const Login(),
        //body: RefreshIndicator(
        //  onRefresh: () async {
        //    var users = await UserService().fetchUsers();
        //    setState(() {
        //      futureAllUsers = Future.value(users);
        //    });
        //},
        //  child: FutureBuilder<List<User>>(
        //    future: futureAllUsers,
        //    builder: (context, snapshot) {
        //      if (snapshot.hasData){
        //        return ListView.separated(
        //          scrollDirection: Axis.vertical,
        //          shrinkWrap: true,
        //          itemCount: snapshot.data!.length,
        //          itemBuilder: (BuildContext context, int index) {
        //            User user = snapshot.data![index];
        //            return ListTile(
        //              title: Text(user.email),
        //              subtitle: Text(user.username),
        //              trailing: const Icon(Icons.chevron_right_outlined),
        //              onTap: () => print('test'),
        //            );
        //          }, separatorBuilder: (BuildContext context, int index) {
        //            return const Divider(color: Colors.black26);
        //        },
        //        );
        //      } else if (snapshot.hasError) {
        //          return Text('test error ${snapshot.error}');
        //      }
//
        //      return const CircularProgressIndicator();
        //    },
        //  ),
        //),
    );
  }
}
