import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wealthwise/screens/main/home.dart';
import 'package:wealthwise/screens/main/calendar.dart';
import 'package:wealthwise/screens/main/planning.dart';
import 'package:wealthwise/screens/main/settings.dart';

class Dashboard extends StatefulWidget {
  final User? user;
  final GoogleSignInAccount? googleUser;
  const Dashboard({super.key, required this.user, this.googleUser});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    _currentUser = widget.user!;
    super.initState();
  }

  final bool _isSigningOut = false;
  late User _currentUser;
  late GoogleSignInAccount _googleUser;
  late String userId = _currentUser!.uid;

  int _selectedIndex = 0;
  // navigation indexes for bottomNavigationBar
  late final List<Widget> _pages = [
    HomePage(user: _currentUser),
    PlanningScreen(user: _currentUser),
    CalendarScreen(user: _currentUser, userId: userId,),
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
        backgroundColor: Colors.grey[300],
        body: _pages[_selectedIndex],

          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: DotNavigationBar(
            margin: const EdgeInsets.only(left: 10, right: 10),
            currentIndex: _selectedIndex,
            dotIndicatorColor: Colors.grey[350],
            unselectedItemColor: Colors.grey[500],
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade500,
                  offset: const Offset(4.0, 4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
              const BoxShadow(
                  color: Colors.white,
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
            ],
            // enableFloatingNavBar: false,
            onTap: _onItemTapped,
            items: [
                /// Home
                DotNavigationBarItem(
                icon: const Icon(Icons.home),
                  selectedColor: const Color.fromRGBO(64, 91, 159, 1),
                ),

                /// Planning
                DotNavigationBarItem(
                icon: const Icon(Icons.event_note),
                  selectedColor: const Color.fromRGBO(64, 91, 159, 1),
                ),

                /// Calendar
                DotNavigationBarItem(
                icon: const Icon(Icons.calendar_month),
                  selectedColor: const Color.fromRGBO(64, 91, 159, 1),
                ),

                /// Settings
                DotNavigationBarItem(
                  icon: const Icon(Icons.settings),
                  selectedColor: const Color.fromRGBO(64, 91, 159, 1),
                ),

              ],
            ),
          ),

      );
  }
}
