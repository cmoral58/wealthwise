import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/fire_auth.dart';
import 'login.dart';

class Dashboard extends StatefulWidget {
  final User user;
  const Dashboard({super.key, required this.user});
  // const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  bool _isSigningOut = false;
  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'NAME: ${_currentUser.displayName}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16.0),
              Text(
                'EMAIL: ${_currentUser.email}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16.0),
              _isSigningOut
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isSigningOut = true;
                  });
                  await FirebaseAuth.instance.signOut();
                  setState(() {
                    _isSigningOut = false;
                  });
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Sign out'),
              ),
            ],
          ),
        ),
      );
  }
}
