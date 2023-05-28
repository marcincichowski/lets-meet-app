
import 'dart:convert';

import '../models/game_model.dart';
import 'package:http/http.dart' as http;

class GameService{

  Future<List<Game>> fetchGames([String? id='', String? query='']) async {
    print(id);
    var url = 'http://10.0.2.2:8000/backend/games/$id';

    print(url);
    final response = await http
        .get(Uri.parse(url));


    if (response.statusCode == 200) {
      if (id == ''){
        List jsonResponse = json.decode(response.body);
        //if (query != '' && query != null) {
        //  final output = jsonResponse.where((game) {
        //    return game.name.toLowerCase().contains(query.toLowerCase());
        //  }).toList();
        //  return output.map((game) => Game.fromJson(game)).toList();
        //}
          return jsonResponse.map((game) => Game.fromJson(game)).toList();

        return jsonResponse.map((game) => Game.fromJson(game)).toList();

      }
      var test = Game.fromJson(jsonDecode(response.body));
      return [test];
      //var test = User.fromJson(jsonDecode(response.body));
      //return test;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load game(s)');
    }
  }
}