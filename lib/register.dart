import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wealthwise/dashboard.dart';
import 'package:wealthwise/utils/validator.dart';
import 'utils/fire_auth.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

// TODO: improve register screen



class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    // TODO: implement initState
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
                  key: _registerFormKey,
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

                      SizedBox(
                        width: 300.0,
                        child: TextFormField(
                          controller: _nameTextController,
                          focusNode: _focusName,
                          validator: (value) => Validator.validateName(name: value),
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
                            // adds icon to the front of input field
                            prefixIcon: Icon(
                              Icons.verified_user_outlined,
                              color: Colors.grey,
                            ),
                            hintText: 'Name',
                            hintStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.grey
                            ),
                          ),
                        ),
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
                          validator: (value) => Validator.validatePassword(password: value),
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
                        height: 60.0,
                      ),
                      _isProcessing
                      ? const CircularProgressIndicator()
                      : SizedBox(
                        width: 200.0,
                        height: 50.0,
                        child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                _isProcessing = true;
                              });

                              if(_registerFormKey.currentState!.validate()) {
                                User? user = await FireAuth
                                    .registerUsingEmailPassword(
                                  name: _nameTextController.text,
                                  email: _emailTextController.text,
                                  password: _passwordTextController.text,
                                );
                                setState(() {
                                  _isProcessing = false;
                                });
                                if (user != null) {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(builder: (context) =>
                                        Dashboard(user: user),
                                    ),
                                    ModalRoute.withName('/'),
                                  );
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
                            child: const Text('Register'),),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),

                      // TODO: configure google and apple sign in with firebase (register page)

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

