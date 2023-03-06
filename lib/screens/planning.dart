import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PlanningScreen extends StatefulWidget {
  final User user;
  const PlanningScreen({super.key, required this.user});
  // const PlanningScreen({Key? key}) : super(key: key);

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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(1),
              child: Text('Calendar Timeline'),
            ),
            CalendarTimeline(
              showYears: true,
              initialDate: _selectedDate,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
              onDateSelected: (date) => setState(() => _selectedDate),
              leftMargin: 20,
              monthColor: Colors.black,
              dayColor: Colors.teal[200],
              dayNameColor: const Color(0xFF333A47),
              activeDayColor: Colors.white,
              activeBackgroundDayColor: Colors.redAccent[100],
              dotsColor: const Color(0xFF333A47),
              selectableDayPredicate: (date) => date.day != 23,
              locale: 'en',
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.teal[200],)
                ),
                onPressed: () => setState(() => _resetSelectedDate()),
                child: const Text(
                  'RESET',
                  style: TextStyle(color: Color(0xFF333A47)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Selected date is $_selectedDate',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
