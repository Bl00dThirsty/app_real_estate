import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppBar extends StatefulWidget {
  final User? user;
  const HomeAppBar({super.key, this.user});

  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  String? _photoURL;

  @override
  void initState() {
    super.initState();
    _loadUserPhotoURL();
  }

  Future<void> _loadUserPhotoURL() async {
    final user = widget.user;
    if (user != null) {
      final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userData.exists) {
        setState(() {
          _photoURL = userData['photoURL'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      title: Text('Resmartha', style: GoogleFonts.ubuntu(textStyle: TextStyle(color: Colors.blueAccent)),  ),
      elevation: 0.8,
      floating: true,
      forceElevated: true,
      actions: [
        if (_photoURL != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/profile'),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(_photoURL!),
              ),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/profile'),
              child: const CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.person),
              ),
            ),
          ),
      ],
    );
  }
}
