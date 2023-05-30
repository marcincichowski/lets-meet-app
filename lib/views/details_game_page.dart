import 'package:flutter/material.dart';
import 'package:untitled/models/meeting_model.dart';

import '../models/authorization_model.dart';
import '../models/game_model.dart';
import '../models/user_model.dart';
import 'add_meeting.dart';

class DetailsGamePage extends StatelessWidget {
  final Game game;
  final Authorization activeUser;
  const DetailsGamePage({Key? key, required this.game, required this.activeUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddMeeting(activeUser: activeUser, game: game,))),
      ),
      appBar: AppBar(title:  Text(game.name)),
      body: Center(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text("Description:"),
            ),
            Text(game.description),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text("URL:"),
            ),
            Text(game.url),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text("Update date:"),
            ),
            Text(game.lastUpdateDate),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text("Accepted date:"),
            ),
            Text(game.acceptDate),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text("type:"),
            ),
            if (game.isOnline)
              const Text("Online"),
            if (!game.isOnline)
              const Text("physical"),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text("number of players:"),
            ),
            Text(game.personCount.toString()),
          ],
        ),
      ),
    );
  }
}
