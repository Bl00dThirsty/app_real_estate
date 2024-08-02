import 'dart:io';

import 'package:app_real_estate/pages/show_appart_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class AddAppartSection extends StatelessWidget {
  final User? user;

  const AddAppartSection({this.user});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Salut'),
                    Text(
                      user!.displayName!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300],
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.pushNamed(context, '/search'),
                        icon: Icon(Icons.search),
                        tooltip: 'Rechercher dans ImmoCamer',
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                      ),
                      child: IconButton(
                        onPressed: () => showAppartDialog(context, user!),
                        icon: const Icon(Icons.add),
                        tooltip: 'Ajouter un logement',
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  void showAppartDialog(BuildContext context, User user) {
    AppartDialog(user: user).showAppartDialog(context, ImageSource.gallery);
  }

}