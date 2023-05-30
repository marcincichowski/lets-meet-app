import 'dart:convert';
import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:untitled/models/authorization_model.dart';
import 'package:untitled/models/meeting_model.dart';
import 'package:untitled/models/participant_model.dart';
import 'package:untitled/services/meeting_service.dart';
import 'package:untitled/services/participant_service.dart';
import 'package:untitled/views/add_prefered_date.dart';
import 'package:untitled/views/meetings_list.dart';

import '../models/user_model.dart';
import 'confirm_prefered_date.dart';

class DetailsMeetingPage extends StatefulWidget {
  final Meeting meeting;
  final Authorization activeUser;
  const DetailsMeetingPage({Key? key, required this.meeting, required this.activeUser}) : super(key: key);

  @override
  State<DetailsMeetingPage> createState() => _DetailsMeetingPageState();
}

class _DetailsMeetingPageState extends State<DetailsMeetingPage> {
  List<int> ids = [];
  List<String> usernames = [];

  @override
  void initState() {
    super.initState();
    ids = [];
    usernames = [];
    widget.meeting.participantsId.forEachIndexed((index, item) {
      var splitted = item.toString().split(' ');
      ids.add(int.parse(splitted[3].replaceAll('}', ' ')));
      usernames.add(splitted[1].replaceAll(',', ' '));

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Stack (
        alignment: Alignment.bottomRight,
        children: [
          if (ids.contains(widget.activeUser.userId))...[
            FloatingActionButton(
                heroTag: null,
                child: const Icon(Icons.remove),
                onPressed: () => remove(context, widget.meeting.id, ids, widget.activeUser)),
            ] else...[
              FloatingActionButton(
                heroTag: null,
                child: const Icon(Icons.add),
                onPressed: () => add(context, widget.meeting.id, ids, widget.activeUser)),
            ]
        ],
      ),
      appBar: AppBar(title:  Text(widget.meeting.name)),
      body: Center(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text("Participants:"),
            ),
            for(var username in usernames)
              Text(username),
            Container(
                alignment: Alignment.centerLeft,
                child: Text('Host id:')
            ),
            Text(widget.meeting.ownerId.toString()),
            Container(
                alignment: Alignment.centerLeft,
                child: Text('Meeting Date:')
            ),
            if (widget.meeting.meetingDate != null)
              Text(widget.meeting.meetingDate)
            else
              const Text('Nie wybrano daty spotkania'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (ids.contains(widget.activeUser.userId))...[
                  ElevatedButton(
                      onPressed: () => Navigator.push(
                          context, MaterialPageRoute(builder: (context) => AddPreferedDate(activeUser: widget.activeUser, meeting: widget.meeting,))),
                      child: const Text("Add prefered date")
                  ),
                ],
                if (widget.meeting.ownerId == widget.activeUser.userId)...[
                  ElevatedButton(
                      onPressed: () => Navigator.push(
                          context, MaterialPageRoute(builder: (context) => PreferedDates(activeUser: widget.activeUser, meeting: widget.meeting,))),
                      child: const Text("confirm date")
                  ),
                ]
              ],
            )
          ],
        ),
      ),
    );
  }

  add(context, int meetingId, List<int> participantsId, Authorization user){
    if (participantsId.contains(user.userId)){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You are already in this meeting"),
        ),
      );
    }
    else{
      participantsId.add(user.userId);
      MeetingService().addUserToMeeting(meetingId, participantsId).then((meeting) => {
        if(meeting.participantsId.contains(user.userId)){

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Added user to meeting"),
            ),
          ),
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Failed to add user to meeting"),
            ),
          ),
        }
      });
    }
    Navigator.pop(
        context, MaterialPageRoute(builder: (context) => MeetingList(activeUser: user)));
  }

  remove(context, int meetingId, List<int> participantsId, Authorization user){
    if (participantsId.contains(user.userId) == false){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("you are not participant of this meeting!"),
        ),
      );
    }
    else{
      participantsId.removeWhere((item) => item == user.userId);
      MeetingService().addUserToMeeting(meetingId, participantsId).then((meeting) => {
        if(meeting.participantsId.contains(user.userId) == false){

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("User removed from meeting"),
            ),
          ),
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Failed to remove user from meeting"),
            ),
          ),
        }
      });
    }
    Navigator.pop(
        context, MaterialPageRoute(builder: (context) => MeetingList(activeUser: user)));
  }
}


