import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PlanningScreen extends StatefulWidget {
  final User user;
  const PlanningScreen({super.key, required this.user});

  @override
  State<PlanningScreen> createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {

  late DateTime _selectedDate;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate(){
    _selectedDate = DateTime.now().add(const Duration(days: 2));
  }

  late User _currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Planning Screen'),
      ),
      body: const Text('This is the planning screen.')
    );
  }
}
