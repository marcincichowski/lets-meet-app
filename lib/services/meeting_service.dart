import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/meeting_model.dart';

class MeetingService{

  Future<List<Meeting>> fetchMeetings([String? id='']) async {
    var url = 'http://10.0.2.2:8000/backend/meetings/$id';
    final response = await http
        .get(Uri.parse(url));

    if (response.statusCode == 200) {
      if (id == ''){
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((meeting) => Meeting.fromJson(meeting)).toList();
      }
      var test = Meeting.fromJson(jsonDecode(response.body));
      return [test];
    } else {
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
      return Meeting.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create Meeting.');
    }
  }

  Future<Meeting> addUserToMeeting(int meetingId, List<int> participantsId) async {
    final response = await http.patch(
      Uri.parse('http://10.0.2.2:8000/backend/meetings/${meetingId.toString()}/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'participants_id': participantsId,
      }),
    );

    if (response.statusCode == 200) {
      return Meeting.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add user to Meeting.');
    }
  }

  Future<Meeting> confirmMeetingDate(int meetingId, String date) async {
    final response = await http.patch(
      Uri.parse('http://10.0.2.2:8000/backend/meetings/${meetingId.toString()}/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'meeting_date': date,
      }),
    );

    if (response.statusCode == 200) {
      return Meeting.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed confirm meeting date.');
    }
  }

}