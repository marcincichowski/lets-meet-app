import 'package:flutter/material.dart';
import 'package:untitled/models/authorization_model.dart';
import 'package:untitled/views/UserList.dart';

import '../models/user_model.dart';
import '../services/user_service.dart';
import 'add_user.dart';
import 'detailsPage.dart';
import 'game_list.dart';
import 'meetings_list.dart';

class HomePage extends StatefulWidget {
  final Authorization activeUser;
  const HomePage({Key? key, required this.activeUser}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

}
class _HomePageState extends State<HomePage> {
  late Future<List<User>> futureAllUsers;

  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysHide;

  @override
  void initState() {
    super.initState();
    futureAllUsers = UserService().fetchUsers();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(

          begin: Alignment.topRight,
          end: Alignment(.1, 1.5),
          colors: [Color.fromRGBO(44, 190, 230, 1), Color.fromRGBO(80, 108, 195, 1)])),

      child: Scaffold(
        backgroundColor: Colors.transparent,

        bottomNavigationBar: NavigationBar(
          surfaceTintColor: const Color.fromRGBO(90, 90, 0, 0.1),
          indicatorColor: const Color.fromRGBO(200, 200, 250, 0.25),
        backgroundColor: const Color.fromRGBO(30, 30, 180, 0.05),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
            switch(index){
              case 0:{
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => UserList(activeUser: widget.activeUser)));
              }
              case 1:{
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => GameList(activeUser: widget.activeUser)));
              }
              case 2:{
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MeetingList(activeUser: widget.activeUser)));
              }
            }
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
              color: Color.fromRGBO(230, 230, 230, 1)),
            icon: Icon(
              Icons.home_outlined,
              color: Color.fromRGBO(230, 230, 230, 1),
            ),
            label: 'Strona główna',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.videogame_asset,
              color: Color.fromRGBO(230, 230, 230, 1),
            ),
            icon: Icon(
              Icons.videogame_asset_outlined,
              color: Color.fromRGBO(230, 230, 230, 1),
            ),
            label: 'Gry',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.people,
              color: Color.fromRGBO(230, 230, 230, 1),
            ),
            icon: Icon(
              Icons.people_outline,
              color: Color.fromRGBO(230, 230, 230, 1),
            ),
            label: 'Spotkania',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 10),
            OverflowBar(
              spacing: 10.0,
              children: <Widget>[
                Center(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset('assets/images/logo.png'),
                  ),

                  ),

                  ),
                Center(
                  child: Card(
                    // clipBehavior is necessary because, without it, the InkWell's animation
                    // will extend beyond the rounded edges of the [Card] (see https://github.com/flutter/flutter/issues/109776)
                    // This comes with a small performance cost, and you should not set [clipBehavior]
                    // unless you need it.
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => GameList(activeUser: widget.activeUser)));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white70,
                              width: 2,
                            ),
                          ),
                        child: Image.asset('assets/images/game_2.jpg'),
                      ),

                    ),
                  ),
                ),
                Center(
                  child: Card(
                    // clipBehavior is necessary because, without it, the InkWell's animation
                    // will extend beyond the rounded edges of the [Card] (see https://github.com/flutter/flutter/issues/109776)
                    // This comes with a small performance cost, and you should not set [clipBehavior]
                    // unless you need it.
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => MeetingList(activeUser: widget.activeUser)));                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white70,
                            width: 2,
                          ),
                        ),
                        child: Image.asset('assets/images/meeting_2.jpg'),
                      ),

                    ),
                  ),
                ),



              ],
            ),
          ],
        ),
      ),
      ),
    );
  }

  openPage(context, User user){
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DetailsPage(user: user)));
  }
}

