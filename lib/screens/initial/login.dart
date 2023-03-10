import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wealthwise/screens/main/home.dart';
import 'package:wealthwise/screens/main/dashboard.dart';
import 'package:wealthwise/utils/fire_auth.dart';
import 'package:wealthwise/utils/validator.dart';
import '../../utils/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isProcessing = false;
  final _formkey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  late final TextEditingController _email;
  late final TextEditingController _password;
  User? user = FirebaseAuth.instance.currentUser;

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
                                // final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                //   email: email,
                                //   password: password,
                                //
                                // );

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
                              shadowColor: Colors.lightBlueAccent,
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

                            onPressed: (){},
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
}
