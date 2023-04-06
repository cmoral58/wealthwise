import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../initial/login.dart';
import 'homeUtils/loading_circle.dart';

class SettingsPage extends StatefulWidget {
  final User user;
  const SettingsPage({super.key, required this.user});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  bool _isSigningOut = false;
  late User _currentUser;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),
            Text(
              'NAME: ${_currentUser.displayName}',
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'EMAIL: ${_currentUser.email}',
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16.0),
            _isSigningOut
                // ? const CircularProgressIndicator()
                ? const LoadingCircle()
                : ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isSigningOut = true;
                });
                // Signs out of Google Account
                await GoogleSignIn().signOut();
                // Signs out of Firebase account (standard email account)
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
                backgroundColor: Colors.white,
                
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                
                ),
              
              ),
              child: const Text(
                'Sign out',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700
                ),
              ),
              
            ),
          ],
        ),
      ),
      
    );
  }
}
