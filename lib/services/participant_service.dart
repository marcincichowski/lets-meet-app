
import 'dart:convert';

import '../models/game_model.dart';
import 'package:http/http.dart' as http;

import '../models/participant_model.dart';

class ParticipantService{

  Future<List<Participant>> fetchParticipants() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:8000/backend/game/all'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((participant) => Participant.fromJson(participant)).toList();
    } else {
      throw Exception('Failed to load games');
    }
  }
  Future<Game> fetchGame(int id) async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:8000/backend/meeting/get_id?id=$id'));

    if (response.statusCode == 200) {
      return Game.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load game');
    }
  }
}