import 'package:cloud_firestore/cloud_firestore.dart';
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

  final _userFeedback = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  void dispose() {
    _userFeedback.dispose();
    super.dispose();
  }

  bool _isSigningOut = false;
  late User _currentUser;


  @override
  Widget build(BuildContext context) {
    _userFeedback.text = '';
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

            ElevatedButton(
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('F E E D B A C K'),
                          content: SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 10),
                                  TextFormField(
                                      controller: _userFeedback,
                                      maxLines: 5,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        // labelText: 'Provide Feedback',
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your feedback';
                                        }
                                        return null;
                                      }
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            MaterialButton(
                              color: Colors.grey[600],
                              child: const Text('Cancel', style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                Navigator.pop(context);
                                setState(() {
                                  _userFeedback.clear();
                                });
                              },
                            ),
                            MaterialButton(
                              color: Colors.grey[600],
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('feedback')
                                    .doc(widget.user.uid)
                                    .collection('userFeedback')
                                    .add({
                                  'feedback': _userFeedback.text,
                                  'username': widget.user.displayName,
                                });
                                Navigator.pop(context);
                                setState(() {
                                  _userFeedback.clear();
                                });
                              },
                              child: const Text('Save', style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        );
                      },
                  );
                },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),

                ),
              ),
                child: const Text(
                    'Give Feedback',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700
                  ),
                ),
            ),



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
