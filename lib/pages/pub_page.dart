import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../shared_ui/appartList.dart';
import 'add_appart_section.dart';
import 'home_appbar.dart';

class PubPage extends StatelessWidget {
  const PubPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    return Scaffold(
      body: SafeArea(child: CustomScrollView(
        slivers: [
          HomeAppBar(user: _user),
          AddAppartSection(user: _user),
          AppartList(userID: _user!.uid),
        ],
      )
      ),
    );
  }
}
