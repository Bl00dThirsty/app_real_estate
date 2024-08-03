import 'package:app_real_estate/services/authentication_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileAppbar extends StatelessWidget {
  final User? user;
  ProfileAppbar({this.user});

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
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 8.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue[600],
          ),
          child: IconButton(onPressed: () => signOut(context),
            icon: Icon(Iconsax.logout, color: Colors.white, size: 33,),),
        )
      ],
    );
  }
  signOut(BuildContext context){
    Navigator.of(context).pop();
    AuthService().signOut();
  }
}
