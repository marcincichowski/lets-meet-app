import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/meeting_model.dart';

class MeetingService{

  Future<List<Meeting>> fetchMeetings([String? id='']) async {
    print(id);
    var url = 'http://10.0.2.2:8000/backend/meetings/$id';

    print(url);
    final response = await http
        .get(Uri.parse(url));


    if (response.statusCode == 200) {
      if (id == ''){
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((meeting) => Meeting.fromJson(meeting)).toList();

      }
      var test = Meeting.fromJson(jsonDecode(response.body));
      return [test];
      //var test = User.fromJson(jsonDecode(response.body));
      //return test;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load meeting(s)');
    }
  }

  Future<Meeting> createMeeting(Meeting meeting) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/backend/meetings/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'owner_id': meeting.ownerId,
        'game_id': meeting.gameId,
        'participants_id': meeting.participantsId,
        'name': meeting.name,
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Meeting.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create Meeting.');
    }
  }
}