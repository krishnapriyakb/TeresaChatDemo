import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserCard extends StatefulWidget {
  const UserCard({super.key});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListTile(
        onTap: () {},
        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: const Text("Krishna"),
        subtitle: const Text(
          "Last message",
          maxLines: 1,
        ),
        trailing: const Text("12:00 PM"),
      ),
    );
  }
}
