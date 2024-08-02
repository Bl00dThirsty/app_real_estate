import 'package:app_real_estate/services/authentication_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileAppbar extends StatelessWidget {
  final User? user;
  const ProfileAppbar({this.user});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.40,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(user!.photoURL!),
            fit: BoxFit.cover
            )
          ),
        ),
        title: RichText(
          textAlign: TextAlign.center,
            text: TextSpan(children: [

          TextSpan(
            text: '${user!.displayName}\n',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white)
          ),
          TextSpan(
              text: '${user!.email}',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white)
          ),
        ])),
        titlePadding: EdgeInsets.only(left: 46.0, bottom: 8.0),
      ),
      actions: [
        IconButton(onPressed: () => signOut(context),
          icon: Icon(Icons.logout, color: Colors.white,),)
      ],
    );
  }
  signOut(BuildContext context){
    Navigator.of(context).pop();
    AuthService().signOut();
  }
}
