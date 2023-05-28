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
            Text(game.description),
            Text(game.url),
            Text(game.lastUpdateDate),
            Text(game.acceptDate),
            Text(game.isOnline.toString()),
            Text(game.personCount.toString()),
            Text(game.personCount.toString()),
          ],
        ),
      ),
    );
  }
}
