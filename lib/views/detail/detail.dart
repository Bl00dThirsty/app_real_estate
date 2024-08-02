import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/villa_model.dart';

class AppartDetail extends StatelessWidget {
  const AppartDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final appart = ModalRoute.of(context)!.settings.arguments as Appart;
    final _userID = Provider.of<User?>(context)!.uid;
    return Scaffold(
      appBar: AppBar(
  title: Text(appart.appartName!, style:  TextStyle(),),
      ),
      body: InteractiveViewer(
    child: Hero(
    tag: appart.appartName!,
    child: Center(
    child: Container(
    decoration: BoxDecoration(
    color: Colors.grey[100],
    image: DecorationImage(
    image: NetworkImage(appart.appartUrlImg!),
    ),
    ),
      child: Text(appart.appartDescription!),
    ),
    ),
    ),
    ),
    );
  }
}
