import 'dart:io';
import 'package:Resmartha/pages/show_appart_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
                    Text("Publiez ici"),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.1),
                      ),
                      child: IconButton(
                        onPressed: () => _handleAddButtonPress(context, user!),
                        icon: const Icon(Iconsax.add),
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

  Future<void> _handleAddButtonPress(BuildContext context, User user) async {
    final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    if (userData.exists && userData['category'] == 'owner') {
      showAppartDialog(context, user);
    } else {
      Navigator.pushNamed(context, '/payment');
    }
  }

  void showAppartDialog(BuildContext context, User user) {
    AppartDialog(user: user).showAppartDialog(context, ImageSource.gallery);
  }
}
