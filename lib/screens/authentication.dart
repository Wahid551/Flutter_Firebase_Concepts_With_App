import 'package:flutter/material.dart';
import 'package:flutter_firebase_coffe/screens/signIn.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SignIn(),
      //Text('Authenticate'),
    );
  }
}
