import 'package:dot_navigation_bar/dot_navigation_bar.dart';
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
    PlanningScreen(user: _currentUser),
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

          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: DotNavigationBar(
            margin: const EdgeInsets.only(left: 10, right: 10),
            currentIndex: _selectedIndex,
            dotIndicatorColor: Colors.white,
            unselectedItemColor: Colors.grey[300],
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5
              )
            ],
            // enableFloatingNavBar: false,
            onTap: _onItemTapped,
            items: [
                /// Home
                DotNavigationBarItem(
                icon: Icon(Icons.home),
                selectedColor: Color(0xff73544C),
                ),

                /// Likes
                DotNavigationBarItem(
                icon: Icon(Icons.event_note),
                selectedColor: Color(0xff73544C),
                ),

                /// Search
                DotNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                selectedColor: Color(0xff73544C),
                ),

              ],
            ),
          ),

      );
  }
}
