import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../models/villa_model.dart';

class AppartFeed extends StatelessWidget {
  final Appart? appart;
  final String? userID;

  const AppartFeed({this.appart, this.userID});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
    GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/detail', arguments: appart!),
      child: Container(
      height: MediaQuery.of(context).size.height * 0.35,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      color: Colors.grey[400],
      image: DecorationImage(image: NetworkImage(appart!.appartUrlImg!),
      fit: BoxFit.cover,
      ),
      
      ),
      ),
    ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0,16.0,16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appart!.appartName!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(width: 28.0),
                  Text('Publié par: '),

                  SizedBox(width: 20.0),

                  Text('${appart!.appartUserName}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.blue)),
                ],
              ),
              Text(formattingDate(appart!.appartTimestamp)),
              Text('${appart!.appartPrice}'),
            ],
          ),
        )
      ],
    );
  }

  String formattingDate(Timestamp? timestamp) {
    initializeDateFormatting('fr', null);
    DateTime? dateTime = timestamp?.toDate();
    DateFormat dateFormat = DateFormat.MMMd('fr');

    return dateFormat.format(dateTime ?? DateTime.now());

  }
}
