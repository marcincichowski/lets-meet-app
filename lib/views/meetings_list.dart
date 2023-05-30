import 'package:flutter/material.dart';
import 'package:untitled/models/authorization_model.dart';
import 'package:untitled/models/meeting_model.dart';
import 'package:untitled/views/add_meeting.dart';
import 'package:untitled/views/details_meeting_page.dart';

import '../models/user_model.dart';
import '../services/meeting_service.dart';
import '../services/user_service.dart';
import 'add_user.dart';
import 'detailsPage.dart';

class MeetingList extends StatefulWidget {
  final Authorization activeUser;
  const MeetingList({Key? key, required this.activeUser}) : super(key: key);

  @override
  State<MeetingList> createState() => _MeetingListState();

}
class _MeetingListState extends State<MeetingList> {
  final TextEditingController searchController = TextEditingController();
  late Future<List<Meeting>> futureAllMeetings;
  late Future<List<Meeting>> futurePermamentAllMeetings;

  @override
  void initState() {
    super.initState();
    futureAllMeetings = MeetingService().fetchMeetings();
    futurePermamentAllMeetings = futureAllMeetings;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text("All Meetings")),
      body: RefreshIndicator(
        onRefresh: () async {
          var meetings = await MeetingService().fetchMeetings();
          setState(() {
            futureAllMeetings = Future.value(meetings);
          });
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: TextField(
                    onChanged: (query) async {
                      print(query);

                      var meetings = await futurePermamentAllMeetings;
                      meetings = meetings.where((meeting) {
                        return meeting.name.toLowerCase().contains(query.toLowerCase());
                      }).toList();
                      setState((){
                        futureAllMeetings = Future.value(meetings);
                      });
                    },
                    controller: searchController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Search',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.blue)
                        )
                    ),
                  )
              ),
              FutureBuilder<List<Meeting>>(
                future: futureAllMeetings,
                builder: (context, snapshot) {
                  if (snapshot.hasData){
                    return ListView.separated(
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        Meeting meeting = snapshot.data![index];
                        return ListTile(
                          title: Text(meeting.name),
                          subtitle: Text(meeting.gameId.toString()),
                          trailing: const Icon(Icons.chevron_right_outlined),
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Text(meeting.name[0].toUpperCase()),
                          ),
                          onTap: () => openPage(context, meeting),
                        );
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

  openPage(context, Meeting meeting){
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DetailsMeetingPage(meeting: meeting, activeUser: widget.activeUser)));
  }
}

