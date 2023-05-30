import 'package:flutter/material.dart';
import 'package:untitled/models/authorization_model.dart';
import 'package:untitled/services/user_service.dart';

import '../models/game_model.dart';
import '../models/user_model.dart';
import '../services/game_service.dart';
import 'HomePage.dart';

class AddGame extends StatefulWidget {
  final Authorization activeUser;
  const AddGame({Key? key, required this.activeUser}) : super(key: key);

  @override
  State<AddGame> createState() => _AddGameState();
}

class _AddGameState extends State<AddGame> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController personCountController = TextEditingController();
  final TextEditingController isOnlineController = TextEditingController();
  bool isChecked = false;


  @override
  void dispose() {
    nameController.dispose();
    urlController.dispose();
    descriptionController.dispose();
    personCountController.dispose();
    isOnlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text('Add Game')),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                controller: urlController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'url',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'description',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                controller: personCountController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'max number of players',
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Is the game online?'),
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                ]
              ),
            ),
            ElevatedButton(
                onPressed: () => GameService().createGame(Game(
                    id: 0,
                    status: 1,
                    name: nameController.text,
                    addDate: DateTime.now().toString(),
                    acceptDate: DateTime.now().toString(),
                    lastUpdateDate: DateTime.now().toString(),
                    acceptedById: widget.activeUser.userId,
                    requestedById: widget.activeUser.userId,
                    url: urlController.text,
                    description: descriptionController.text,
                    personCount: int.parse(personCountController.text),
                    isOnline: isChecked,
                )).then((game) {
                  if (game.id != 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('game added'),
                      ),
                    );
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => HomePage(activeUser: widget.activeUser)));
                  }
                }),
                child: const Text('Submit')
            ),
          ],
        ),
      ),
    );
  }
}
