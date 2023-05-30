import 'package:flutter/material.dart';
import 'package:untitled/models/authorization_model.dart';
import 'package:untitled/models/meeting_model.dart';
import 'package:untitled/services/participant_service.dart';
import 'package:untitled/views/add_meeting.dart';
import 'package:untitled/views/details_meeting_page.dart';

import '../models/game_model.dart';
import '../models/participant_model.dart';
import '../models/user_model.dart';
import '../services/game_service.dart';
import '../services/meeting_service.dart';
import '../services/user_service.dart';
import 'add_user.dart';
import 'detailsPage.dart';
import 'details_game_page.dart';

class PreferedDates extends StatefulWidget {
  final Authorization activeUser;
  final Meeting meeting;
  const PreferedDates({Key? key, required this.activeUser, required this.meeting}) : super(key: key);

  @override
  State<PreferedDates> createState() => _PreferedDatesState();

}
class _PreferedDatesState extends State<PreferedDates> {
  final TextEditingController searchController = TextEditingController();
  late Future<List<Participant>> futureAllParticipants;

  @override
  void initState() {
    super.initState();
    futureAllParticipants = ParticipantService().fetchParticipants(meetingId: widget.meeting.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  const Text("Choose meeting date")),
      body: RefreshIndicator(
        onRefresh: () async {
          var participants = await ParticipantService().fetchParticipants(meetingId: widget.meeting.id.toString());
          setState(() {
            futureAllParticipants = Future.value(participants);
          });
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<List<Participant>>(
                future: futureAllParticipants,
                builder: (context, snapshot) {
                  if (snapshot.hasData){
                    return ListView.separated(
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        Participant participant = snapshot.data![index];
                        if (participant.preferedDate != null){
                          return ListTile(
                            title: Text(participant.preferedDate),
                            onTap: () => MeetingService().confirmMeetingDate(widget.meeting.id, participant.preferedDate)
                          );
                        }
                      }, separatorBuilder: (BuildContext context, int index) {
                      return const Divider(color: Colors.black26);
                    },
                    );
                  } else if (snapshot.hasError) {
                    return Text('test error ${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  openPage(context, Game game, Authorization activeUser){
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DetailsGamePage(game: game, activeUser: activeUser)));
  }



}

