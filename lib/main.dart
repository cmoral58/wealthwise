import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:wealthwise/utils/google_sign_in.dart';
import 'utils/firebase_options.dart';
import 'screens/initial/welcome.dart';


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
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create:(context) => GoogleSignInProvider(),
    child: 
    
    MaterialApp(
      title: 'wealthwise',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // HomePage is in welcome.dart file
      // cleans up the main file
      home: const WelcomePage(),
      // removes debug banner from app bar
      debugShowCheckedModeBanner: false,
    )
  );
  
}



