import 'package:flutter/material.dart';
import 'package:untitled/models/authorization_model.dart';
import 'package:untitled/views/add_meeting.dart';

import '../models/user_model.dart';
import '../services/user_service.dart';
import 'add_user.dart';
import 'detailsPage.dart';

class UserList extends StatefulWidget {
  final Authorization activeUser;
  const UserList({Key? key, required this.activeUser}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();

}
class _UserListState extends State<UserList> {
  final TextEditingController searchController = TextEditingController();
  late Future<List<User>> futureAllUsers;
  late Future<List<User>> futurePermamentAllUsers;

  @override
  void initState() {
    super.initState();
    futureAllUsers = UserService().fetchUsers();
    futurePermamentAllUsers = futureAllUsers;
  }

    @override
    Widget build(BuildContext context) {

      return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddUser(activeUser: widget.activeUser)))
        ),
        appBar: AppBar(title:  Text("All Users")),
        body: RefreshIndicator(
          onRefresh: () async {
            var users = await UserService().fetchUsers('');
            setState(() {
              futureAllUsers = Future.value(users);
            });
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child: TextField(
                      onChanged: (query) async {

                        var users = await futurePermamentAllUsers;
                        users = users.where((user) {
                          return user.username.toLowerCase().contains(query.toLowerCase());
                        }).toList();
                        setState((){
                          futureAllUsers = Future.value(users);
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
                FutureBuilder<List<User>>(
                  future: futureAllUsers,
                  builder: (context, snapshot) {
                    if (snapshot.hasData){
                      return ListView.separated(
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          User user = snapshot.data![index];
                          return ListTile(
                            title: Text(user.email),
                            subtitle: Text(user.username),
                            trailing: const Icon(Icons.chevron_right_outlined),
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Text(user.username[0].toUpperCase()),
                            ),
                            onTap: () => openPage(context, user),
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

    openPage(context, User user){
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DetailsPage(user: user)));
      }
}

