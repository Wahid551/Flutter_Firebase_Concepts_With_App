import 'package:flutter/material.dart';
import 'package:flutter_firebase_coffe/services/auth.dart';
import 'package:flutter_firebase_coffe/shared/constants.dart';
import 'package:flutter_firebase_coffe/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
// Text Field States
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Sign in to Brew Crew'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                  onPressed: () => widget.toggleView(),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputdecoration.copyWith(hintText: 'Email'),
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      validator: (_value) =>
                          _value.isEmpty ? 'Enter Email' : null,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      obscureText: true,
                      decoration:
                          textInputdecoration.copyWith(hintText: 'Password'),
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      validator: (_value) => _value.length < 6
                          ? 'Enter Password Greater than 6'
                          : null,
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            // print(password);
                            // print(email);
                            dynamic user = await _auth
                                .signInwithEmailAndPassword(email, password);
                            if (user == null) {
                              setState(() {
                                loading = false;
                                error =
                                    'Could not sign in with those credentials';
                              });
                            }
                          }
                        }),
                    SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: Text(
                        error,
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

// For Signing Anonymous

// RaisedButton(
// child: Text('sign in anon'),
// onPressed: () async {
// dynamic result = await _auth.signInAnon();
// if (result == null) {
// print('error signing in');
// } else {
// print('signed in');
// print(result.uid);
// }
// },
// ),
