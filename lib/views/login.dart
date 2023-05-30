import 'package:flutter/material.dart';
import 'package:untitled/views/HomePage.dart';
import 'package:untitled/views/UserList.dart';

import '../models/authorization_model.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';
import 'add_user.dart';
import 'detailsPage.dart';

class Login extends StatefulWidget {

  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();

}
class _LoginState extends State<Login> {
  late Future<List<User>> futureAllUsers;

  @override
  void initState() {
    super.initState();
    futureAllUsers = UserService().fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    var auth;
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    void dispose() {
      usernameController.dispose();
      passwordController.dispose();
      super.dispose();
    }

    return MaterialApp(
      title: "Lets Meet app",
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(

                    begin: Alignment.topRight,
                    end: Alignment(.1, 1.5),
                    colors: [Color.fromRGBO(44, 190, 230, 1), Color.fromRGBO(80, 108, 195, 1)])),

            child: Center(

              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 150, horizontal: 60),
                child: Column(
                  children: [
                    Image.asset('assets/images/logo.png'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                      child: TextFormField(
                        cursorColor: Colors.white70,
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                        controller: usernameController,
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(color: Colors.white70),
                          focusColor: Colors.white70,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70)
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70)
                          ),
                          labelText: 'Username',
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                        child: TextFormField(
                          cursorColor: Colors.white70,
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                          obscureText: true,
                          controller: passwordController,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: Colors.white70),
                            focusColor: Colors.white70,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70)
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70)
                            ),
                            labelText: 'Password',
                          ),
                        ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                        child: ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                            foregroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                          ),
                          onPressed:  () => {
                            auth = UserService().authUser(usernameController.text, passwordController.text).then((authorization) {
                              if ( authorization.userId != 0) {
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => HomePage(activeUser: authorization)));
                              }
                            }),

                          },
                          child: const Text("Login"),
                          ),
                        ),
                  ],
                ),
              ),
            ),
          )
      )
    );
  }

  openPage(context, User user){
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DetailsPage(user: user)));
  }

  helper(String username, String password, Authorization activeUser) {
    UserService().authUser(username, password).then((result) {
      setState(() {
        activeUser = result;
      });
    });
  }

}

