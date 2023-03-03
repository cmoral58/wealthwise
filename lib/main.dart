import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'home.dart';

Future<void> main() async {
  // initializes firebase on app start up
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:
  DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'wealthwise',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // HomePage is in home.dart file
      // cleans up the main file
      home: const HomePage(),
      // removes debug banner from app bar
      debugShowCheckedModeBanner: false,
    );
  }
}


