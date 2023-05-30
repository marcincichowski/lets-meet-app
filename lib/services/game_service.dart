
import 'dart:convert';

import '../models/game_model.dart';
import 'package:http/http.dart' as http;

class GameService{

  Future<List<Game>> fetchGames([String? id='', String? query='']) async {
    var url = 'http://10.0.2.2:8000/backend/games/$id';
    final response = await http
        .get(Uri.parse(url));

    if (response.statusCode == 200) {
      if (id == ''){
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((game) => Game.fromJson(game)).toList();
      }
      var test = Game.fromJson(jsonDecode(response.body));
      return [test];
    } else {
      throw Exception('Failed to load game(s)');
    }
  }

  Future<Game> createGame(Game game) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/backend/games/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': game.name,
        'url': game.url,
        'description': game.description,
        'person_count': game.personCount,
        'is_online': game.isOnline,
        'accepted_by_id': game.acceptedById,
        'requested_by_id': game.requestedById,
      }),
    );

    if (response.statusCode == 201) {
      return Game.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create Game.');
    }
  }

}