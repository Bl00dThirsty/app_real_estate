import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/default_button.dart';
import '../widgets/empty_section.dart';
import '../widgets/subtitle.dart';
import 'home.dart';

class Success extends StatefulWidget {
  Success({Key? key}) : super(key: key);

  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EmptySection(
            emptyImg: 'assets/images/success.gif',
            emptyMsg: 'Paiement réussi !!',
          ),
          SubTitle(
            subTitleText: 'Vous êtes Propriétaire',
          ),
          DefaultButton(
            btnText: 'Ok',
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
                  'category': 'owner',
                });
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
