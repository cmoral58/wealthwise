import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  final User user;
  const CalendarScreen({super.key, required this.user});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  late User _currentUser;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Screen'),
      ),
      body: Column(children: const [
        Text('This is calendar page')
      ],
      ),
    );
  }
}
