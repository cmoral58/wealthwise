import 'package:flutter/material.dart';

import 'event.dart';

class EventItem extends StatelessWidget {
  final Event event;
  final Function() onDelete;
  final Function()? onTap;
  const EventItem({
    Key? key,
    required this.event,
    required this.onDelete,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        event.title,
        style: const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold
        ),
      ),
      subtitle: Text(
        event.date.toString(),
        style: const TextStyle(
            fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600
        ),
      ),
      onTap: onTap,
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}