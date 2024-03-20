import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserCard extends StatefulWidget {
  final title;
  final leading;
  final subtitle;

  const UserCard(
      {super.key,
      required this.leading,
      required this.subtitle,
      required this.title});

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
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: CachedNetworkImage(
            imageUrl: widget.leading,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        title: Text(widget.title),
        subtitle: Text(widget.subtitle),
        trailing: Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
              color: Colors.lightGreenAccent.shade400,
              borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }
}
