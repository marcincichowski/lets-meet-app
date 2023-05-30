import 'package:flutter/material.dart';
import 'package:untitled/models/authorization_model.dart';
import 'package:untitled/services/user_service.dart';

import '../models/game_model.dart';
import '../models/meeting_model.dart';
import '../models/user_model.dart';
import '../services/meeting_service.dart';
import 'HomePage.dart';

class AddMeeting extends StatefulWidget {
  final Authorization activeUser;
  final Game game;
  const AddMeeting({Key? key, required this.activeUser, required this.game}) : super(key: key);

  @override
  State<AddMeeting> createState() => _AddMeetingState();
}

class _AddMeetingState extends State<AddMeeting> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController gameIdController = TextEditingController();


  @override
  void dispose() {
    nameController.dispose();
    gameIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text('Add Meeting')),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () => MeetingService().createMeeting(Meeting(
                    id: 0,
                    ownerId: widget.activeUser.userId,
                    gameId: widget.game.id,
                    participantsId: [],
                    name: nameController.text,
                    addDate: DateTime.now().toIso8601String(),
                    meetingDate: null)
                ).then((meeting) {
                  if (meeting.id != 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Meeting added'),
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
