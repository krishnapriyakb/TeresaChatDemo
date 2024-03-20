import 'dart:developer';
import 'package:chat/Screens/login.dart';
import 'package:chat/Screens/profile.dart';
import 'package:chat/models/user_modal.dart';
import 'package:chat/services/apis.dart';
import 'package:chat/widgets/user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserModal> users = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.power_settings_new_outlined),
          onPressed: () async {
            await APIs.auth.signOut();
            await GoogleSignIn().signOut();
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => const LoginPage()));
          },
        ),
        appBar: AppBar(
          title: const Text("We Chat"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (ctx) => ProfileScreen(
                        user: users[0],
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.menu))
          ],
        ),
        body: StreamBuilder(
          stream: APIs.firestore.collection('Users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              log("Error: ${snapshot.error}");
              return const Center(
                child: Text("An error occurred"),
              );
            } else if (snapshot.hasData) {
              final data = snapshot.data?.docs;
              users =
                  data?.map((e) => UserModal.fromJson(e.data())).toList() ?? [];
              log("Data $data");
              log("length${data!.length}");
              return ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                physics: const BouncingScrollPhysics(),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return UserCard(
                      leading: users[index].image,
                      subtitle: users[index].about,
                      title: users[index].name);
                },
              );
            } else {
              return const Center(
                child: Text("No data available"),
              );
            }
          },
        ),
      ),
    );
  }
}
