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
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: const [
            Text('Calendar page')
          ],
        ),
      ),
    );
  }
}
