import 'dart:convert';
import 'dart:developer';

import 'package:chat/services/apis.dart';
import 'package:chat/widgets/user_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final users = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.power_settings_new_outlined),
          onPressed: () async {
            await APIs.auth.signOut();
            await GoogleSignIn().signOut();
          },
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
              for (var i in data!) {
                log("${jsonEncode(i.data())}");
                users.add(i.data()['name']);
              }
              log("Data $data");
              log("length${data.length}");
              return ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                physics: const BouncingScrollPhysics(),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Text(users[index]);
                },
              );
            } else {
              return Center(
                child: Text("No data available"),
              );
            }
          },
        ),
      ),
    );
  }
}
