import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wealthwise/screens/main/home.dart';
import 'package:wealthwise/screens/main/calendar.dart';
import 'package:wealthwise/screens/main/planning.dart';
import 'package:wealthwise/screens/main/settings.dart';


class Dashboard extends StatefulWidget {
  final User? user;
  const Dashboard({super.key, required this.user});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    _currentUser = widget.user!;
    super.initState();
  }

  bool _isSigningOut = false;
  late User _currentUser;

  int _selectedIndex = 0;
  // navigation indexes for bottomNavigationBar
  late final List<Widget> _pages = [
    HomePage(user: _currentUser),
    PlanningScreen(user: _currentUser),
    CalendarScreen(user: _currentUser),
    SettingsPage(user: _currentUser),
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
                selectedColor: const Color.fromRGBO(64, 91, 159, 1),
                ),

                /// Planning
                DotNavigationBarItem(
                icon: Icon(Icons.event_note),
                selectedColor: const Color.fromRGBO(64, 91, 159, 1),
                ),

                /// Calendar
                DotNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                selectedColor: const Color.fromRGBO(64, 91, 159, 1),
                ),

                /// Settings
                DotNavigationBarItem(
                  icon: Icon(Icons.settings),
                  selectedColor: const Color.fromRGBO(64, 91, 159, 1),
                ),

              ],
            ),
          ),

      );
  }
}
