import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:wealthwise/screens/main/dashboard.dart';
import 'package:wealthwise/utils/fire_auth.dart';
import 'package:wealthwise/utils/google_sign_in.dart';
import 'package:wealthwise/utils/validator.dart';
import '../../utils/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

/// Google Sign in function
GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
  ],
);



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// BOOL variable to determine whether the user is signed in (true) or not (false)
  bool _isProcessing = false;

  final _formkey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  late final TextEditingController _email;
  late final TextEditingController _password;
  User? user = FirebaseAuth.instance.currentUser;

  /// handles button press
  bool _isButtonDisabled = false;
  void _handleButtonTap() {
    setState(() {
      _isButtonDisabled = true;
    });
    signInWithGoogle();
  }

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }
  // dispose method used to release the memory allocated to variables when state object is removed.
  // avoid memory leakage warning later on
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Allows for transparency
      extendBodyBehindAppBar: true,
      /// Allows the ability to go back a page
      appBar: AppBar(
        /// Used to change the color of the back arrow (default color is white)
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(64, 91, 159, 1),
        ),
        /// Makes app bar transparent (default color is blue)
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 100.0,
                      ),
                      Image.asset(
                        'images/logo.png',
                      ),
                      Image.asset(
                        'images/save.png',
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Center(
                        child: SizedBox(
                          width: 300.0,
                          child: TextFormField(
                            controller: _emailTextController,
                            focusNode: _focusEmail,
                            validator: (value) => Validator.validateEmail(email: value),
                            enableSuggestions: false,
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(64, 91, 159, 1),
                                  width: 3.0,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(64, 91, 159, 1),
                                  width: 3.0,
                                ),
                              ),
                              // adds icon to the front of input field
                              prefixIcon: Icon(
                                Icons.account_circle_outlined,
                                color: Colors.grey,
                              ),
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.grey
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 300.0,
                        child: TextFormField(
                          controller: _passwordTextController,
                          focusNode: _focusPassword,
                          validator: (value) => Validator.validatePassword( password: value),
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(64, 91, 159, 1),
                                width: 3.0,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(64, 91, 159, 1),
                                width: 3.0,
                              ),
                            ),
                            prefixIcon: Icon(
                              // adds icon to the front of input field
                              Icons.lock_outline,
                              color: Colors.grey,
                            ),
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.grey
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 80.0,
                      ),
                      _isProcessing ?
                      const CircularProgressIndicator()
                          : SizedBox(
                        width: 200.0,
                        height: 50.0,
                        child: ElevatedButton(
                            onPressed: () async {
                              _focusEmail.unfocus();
                              _focusPassword.unfocus();

                              if (_formkey.currentState!.validate()) {
                                setState(() {
                                  _isProcessing = true;
                                });
                                User? user = await FireAuth.signInUsingEmailPassword(
                                  email: _emailTextController.text,
                                  password: _passwordTextController.text,

                                );

                                setState(() {
                                  _isProcessing = false;
                                });

                                if (user != null) {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(builder: (context) => Dashboard(user: user)));
                                }
                              }



                            },
                            style: ElevatedButton.styleFrom(
                              shadowColor: Color.fromARGB(255, 61, 61, 61),
                              elevation: 4.0,
                              backgroundColor: const Color.fromRGBO(64, 91, 159, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: const BorderSide(color: Color.fromRGBO(64, 91, 159, 1)),
                              ),
                            ),
                            child: const Text('Log In')),
                      ),

                      const SizedBox(
                        height: 30.0,
                      ),

                      // TODO: configure google and apple sign in with firebase (login page)

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(

                            onPressed: () async {
                              // Here goes Jorge's code
                              // it has been shortened down to fix the bug issues
                              /// calling the _handleButtonTap() function instead of the signInWithGoogle();
                              _handleButtonTap();


                            },
                            icon: Image.asset('images/google.png'),
                            iconSize: 60,
                          ),
                          const SizedBox(
                            width: 50.0,
                          ),
                          IconButton(
                            onPressed: (){},
                            icon: Image.asset('images/apple.png'),
                            iconSize: 60,
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              );
            default:
              return const Text('loading...');
          }
        },
      ),
    );

  }
  Future<void> signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    print(userCredential.user?.displayName);

    if(userCredential.user != null) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Dashboard(user: userCredential.user),
      ));
    }
  }
}