import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wealthwise/screens/home.dart';
import 'package:wealthwise/screens/calendar.dart';
import 'package:wealthwise/screens/planning.dart';

import '../utils/fire_auth.dart';
import 'login.dart';

class Dashboard extends StatefulWidget {
  final User user;
  const Dashboard({super.key, required this.user});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  bool _isSigningOut = false;
  late User _currentUser;

  int _selectedIndex = 0;
  // navigation indexes for bottomNavigationBar
  late final List<Widget> _pages = [
    HomePage(user: _currentUser),
    const PlanningScreen(),
    const CalendarScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.event_note),
                label: 'Planning'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: 'Calendar'
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.lightBlueAccent,
          onTap: _onItemTapped,
        ),
      );
  }
}
