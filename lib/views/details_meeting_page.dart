import 'package:flutter/material.dart';
import 'package:untitled/models/meeting_model.dart';

import '../models/user_model.dart';

class DetailsMeetingPage extends StatelessWidget {
  final Meeting meeting;
  const DetailsMeetingPage({Key? key, required this.meeting}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text(meeting.name)),
      body: Center(
        child: Column(
          children: [
            Text(meeting.participantsId.toString()),
            Text(meeting.ownerId.toString()),
            if (meeting.meetingDate != null)
              Text(meeting.meetingDate)
            else
              const Text('Brak'),
          ],
        ),
      ),
    );
  }
}
