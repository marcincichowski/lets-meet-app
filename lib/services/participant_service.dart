
import 'dart:convert';

import '../models/game_model.dart';
import 'package:http/http.dart' as http;

import '../models/participant_model.dart';

class ParticipantService{

  Future<List<Participant>> fetchParticipants({String? id='', String? meetingId=''}) async {
    print(id);

    var url = 'http://10.0.2.2:8000/backend/participants/$id';

    if (meetingId != '' && id !='') {
      url = 'http://10.0.2.2:8000/backend/participants/$id/?meeting=$meetingId';
    }
    else if (meetingId != '' && id ==''){
      url = 'http://10.0.2.2:8000/backend/participants/?meeting=$meetingId';
    }

    print(url);
    final response = await http
        .get(Uri.parse(url));


    if (response.statusCode == 200) {
      if (id == ''){
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((participant) => Participant.fromJson(participant)).toList();

      }
      var test = Participant.fromJson(jsonDecode(response.body));
      return [test];
    } else {
      throw Exception('Failed to load participant(s)');
    }
  }

  Future<bool> addPreferedDate(int meetingId, int userId, DateTime date) async {
    final response = await http.patch(
      Uri.parse('http://10.0.2.2:8000/backend/participants/set_prefered_date/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'prefered_date': '${date.year}-${date.month}-${date.day}',
        'user_id': userId,
        'meeting_id': meetingId,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to add prefered date to Meeting.');
    }
  }

}