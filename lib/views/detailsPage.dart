import 'package:flutter/material.dart';

import '../models/user_model.dart';

class DetailsPage extends StatelessWidget {
  final User user;
  const DetailsPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text('${user.firstName} ${user.lastName}')),
      body: Center(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: const Text("username:"),
            ),
            Text(user.username),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text("email:"),
            ),
             Text(user.email),
          ],
        ),
      ),
    );
  }
}
