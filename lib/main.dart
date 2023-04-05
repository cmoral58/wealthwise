import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:wealthwise/screens/main/dashboard.dart';
import 'package:wealthwise/utils/google_sheets_Api.dart';
import 'package:wealthwise/utils/google_sign_in.dart';
import 'utils/firebase_options.dart';
import 'screens/initial/welcome.dart';


Future<void> main() async {
  // initializes firebase on app start up
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:
  DefaultFirebaseOptions.currentPlatform);
  GoogleSheetsApi().init();
  runApp(const MyApp());

}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create:(context) => GoogleSignInProvider(),
      child:

      MaterialApp(
        title: 'wealthwise',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            if(snapshot.data == null) {
              return const WelcomePage();
            }
            else {
              return Dashboard(user: FirebaseAuth.instance.currentUser!);
            }
          },
        ),
        // removes debug banner from app bar
        debugShowCheckedModeBanner: false,
      )
  );

}

