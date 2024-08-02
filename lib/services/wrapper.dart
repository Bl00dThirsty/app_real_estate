import 'package:app_real_estate/pages/home.dart';
import 'package:app_real_estate/screens/widgets/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    return _user == null ? LoginScreen() : HomePage();
  }
}
