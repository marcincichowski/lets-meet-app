import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:untitled/models/authorization_model.dart';
import 'package:untitled/models/meeting_model.dart';
import 'package:untitled/services/user_service.dart';
import 'package:untitled/views/details_meeting_page.dart';

import '../models/user_model.dart';
import '../services/participant_service.dart';
import 'HomePage.dart';

class AddPreferedDate extends StatefulWidget {
  final Authorization activeUser;
  final Meeting meeting;
  const AddPreferedDate({Key? key, required this.activeUser, required this.meeting}) : super(key: key);

  @override
  State<AddPreferedDate> createState() => _AddPreferedDateState();
}

class _AddPreferedDateState extends State<AddPreferedDate> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay){
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text('Add date')),
      body: Center(
        child: Column(
          children: [
            Container(
              child: TableCalendar(
                locale: "en_US",
                availableGestures: AvailableGestures.all,
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true
                ),
                focusedDay: today,
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                onDaySelected: _onDaySelected,
                selectedDayPredicate: (day) => isSameDay(day, today),
              ),
            ),
            ElevatedButton(
                onPressed: () => ParticipantService().addPreferedDate(widget.meeting.id, widget.activeUser.userId, today).then((result) {
                  if (result != '') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('prefered date added'),
                      ),
                    );
                    Navigator.pop(
                        context, MaterialPageRoute(builder: (context) => DetailsMeetingPage(meeting: widget.meeting, activeUser: widget.activeUser)));
                  }
                }),
                child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
