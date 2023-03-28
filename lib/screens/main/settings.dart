import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import '../initial/login.dart';

class SettingsPage extends StatefulWidget {
  final User user;
  const SettingsPage({super.key, required this.user});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  XFile? image;

  final ImagePicker picker = ImagePicker();

  bool _hasImage = false;
  Future getImage(ImageSource media) async {
    final img = await picker.pickImage(source: media);

    setState(() {
      // image = img;
      if(_currentUser.photoURL == null) {
        _hasImage = false;
        image = img;
      } else  {
        _hasImage = true;
        image = _currentUser.photoURL as XFile?;
      }
    });
  }

  myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            title: const Text('Please choose media to select'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pop(context);
                        });
                        getImage(ImageSource.gallery);
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.image),
                          Text('From Gallery'),
                        ],
                      ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.pop(context);
                      });
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }

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
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),
            // CircleAvatar(
            //   radius: 30,
            //   // backgroundColor: Colors.blueAccent,
            //   child: Padding(
            //     padding: const EdgeInsets.all(2),
            //     child: ClipOval(
            //       child: Image.network('${_currentUser.photoURL}'),
            //     ),
            //   ),
            // ),
            // IconButton(
            //   // onPressed: myAlert(),
            //   onPressed: () {
            //     WidgetsBinding.instance.addPostFrameCallback((_) {
            //       myAlert();
            //     });
            //   },
            //   icon: _hasImage ? Image.asset(image!.path) : Image.network('${_currentUser.photoURL}'),
            // ),
            MaterialButton(
              color: Colors.blueAccent,
              onPressed: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  myAlert();
                });
              },
              padding: const EdgeInsets.all(4),
              shape: const CircleBorder(),
              // child: _hasImage ? Image.asset(image!.path) : Image.network('${_currentUser.photoURL}'),
              child: image != null ? Padding(
                  padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: _hasImage ? Image.file(
                    File(image!.path),
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 20,
                  ) : Image.network('${_currentUser.photoURL}')
                ),
              ) :
                  const Icon(Icons.account_circle, color: Colors.white, size: 30,),
            ),

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
                await GoogleSignIn().signOut();
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
