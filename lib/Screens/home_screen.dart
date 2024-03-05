import 'dart:math';

import 'package:chat/services/apis.dart';
import 'package:chat/widgets/user_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.power_settings_new_outlined),
            onPressed: () async {
              await APIs.auth.signOut();
              await GoogleSignIn().signOut();
            }),
        body: StreamBuilder(
            stream: APIs.firestore.collection('Users').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data?.docs;

                if (kDebugMode) {
                  print("Data:$data");
                } else {
                  print("hello");
                }
                if (kDebugMode) {
                  print("length of data:${data!.length}");
                }
              }
              return ListView.builder(
                  padding: EdgeInsets.only(top: 10),
                  physics: BouncingScrollPhysics(),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return const UserCard();
                  });
            }),
      ),
    );
  }
}
