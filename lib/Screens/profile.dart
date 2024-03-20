import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat/Screens/login.dart';
import 'package:chat/helper/dialogs.dart';
import 'package:chat/models/user_modal.dart';
import 'package:chat/services/apis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatefulWidget {
  final UserModal user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("logout"),
        icon: const Icon(Icons.power_settings_new_outlined),
        onPressed: () async {
          Dialogs.showProgress(context);
          await APIs.auth.signOut().then((value) async {
            await GoogleSignIn().signOut().then((value) {
              Navigator.pushReplacement(context,
                  CupertinoPageRoute(builder: (_) => const LoginPage()));
            });
          });

          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        },
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * .1,
                    ),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * .5,
                      height: MediaQuery.of(context).size.height * .2,
                      imageUrl: widget.user.image,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: MaterialButton(
                      shape: const CircleBorder(),
                      color: Colors.white,
                      onPressed: () {},
                      child: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
              Text(
                widget.user.email,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: widget.user.name,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  hintText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: widget.user.about,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.info),
                  hintText: "About",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("update"))
            ],
          ),
        ),
      ),
    );
  }
}
