import 'package:flutter/material.dart';
import 'package:flutter_firebase_coffe/models/user.dart';
import 'package:flutter_firebase_coffe/screens/authentication.dart';
import 'package:provider/provider.dart';
import 'home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Usser>(context);
    print(user);
    // return either the Home or Authenticate widget
    return Authenticate();
  }
}
