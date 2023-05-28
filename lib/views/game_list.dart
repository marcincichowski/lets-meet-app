import 'package:flutter/material.dart';
import 'package:untitled/models/authorization_model.dart';
import 'package:untitled/models/meeting_model.dart';
import 'package:untitled/views/add_meeting.dart';
import 'package:untitled/views/details_meeting_page.dart';

import '../models/game_model.dart';
import '../models/user_model.dart';
import '../services/game_service.dart';
import '../services/meeting_service.dart';
import '../services/user_service.dart';
import 'add_user.dart';
import 'detailsPage.dart';
import 'details_game_page.dart';

class GameList extends StatefulWidget {
  final Authorization activeUser;
  const GameList({Key? key, required this.activeUser}) : super(key: key);

  @override
  State<GameList> createState() => _GameListState();

}
class _GameListState extends State<GameList> {
  final TextEditingController searchController = TextEditingController();
  late Future<List<Game>> futureAllGames;
  late Future<List<Game>> futurePermamentAllGames;

  @override
  void initState() {
    super.initState();
    futureAllGames = GameService().fetchGames();
    futurePermamentAllGames = futureAllGames;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => print('go')
          //Navigator.push(
          //    context, MaterialPageRoute(builder: (context) => AddMeeting(activeUser: widget.activeUser)))
      ),
      appBar: AppBar(title:  const Text("Games")),
      body: RefreshIndicator(
        onRefresh: () async {
          var games = await GameService().fetchGames();
          setState(() {
            futureAllGames = Future.value(games);
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

                    var games = await futurePermamentAllGames;
                    games = games.where((game) {
                      return game.name.toLowerCase().contains(query.toLowerCase());
                    }).toList();
                    setState((){
                      futureAllGames = Future.value(games);
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
              FutureBuilder<List<Game>>(
                future: futureAllGames,
                builder: (context, snapshot) {
                  if (snapshot.hasData){
                    return ListView.separated(
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        Game game = snapshot.data![index];
                        return ListTile(
                          title: Text(game.name),
                          subtitle: Text(game.url),
                          trailing: const Icon(Icons.chevron_right_outlined),
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Text(game.name[0].toUpperCase()),
                          ),
                          onTap: () => openPage(context, game, widget.activeUser),
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

  openPage(context, Game game, Authorization activeUser){
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DetailsGamePage(game: game, activeUser: activeUser)));
  }



}

