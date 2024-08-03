import 'package:app_real_estate/pages/profile_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
            slivers: [
            ProfileAppbar(user: _user),
      ],)),
    );
  }
}
