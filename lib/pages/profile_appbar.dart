import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:iconsax/iconsax.dart';
import 'package:Resmartha/services/authentication_services.dart';

import '../screens/widgets/login/login.dart'; // Assurez-vous d'importer votre écran de connexion

class ProfileAppbar extends StatefulWidget {
  final User? user;
  ProfileAppbar({this.user});

  @override
  _ProfileAppbarState createState() => _ProfileAppbarState();
}

class _ProfileAppbarState extends State<ProfileAppbar> {
  File? _image;
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

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      await _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    try {
      final storageRef = FirebaseStorage.instance.ref().child('profile_images/${widget.user!.uid}.jpg');
      await storageRef.putFile(_image!);
      final downloadURL = await storageRef.getDownloadURL();
      await FirebaseFirestore.instance.collection('users').doc(widget.user!.uid).update({
        'photoURL': downloadURL,
      });
      setState(() {
        _photoURL = downloadURL;
      });
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.40,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            _image == null
                ? Image.network(
              _photoURL ?? 'https://example.com/default_profile_image.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/default_profile_image.png'),
                  ),
                );
              },
            )
                : Image.file(
              _image!,
              fit: BoxFit.cover,
            ),
          ],
        ),
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: '${widget.user?.displayName ?? 'User'}\n',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
              ),
              TextSpan(
                text: '${widget.user?.email ?? 'user@example.com'}',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
        titlePadding: EdgeInsets.only(left: 46.0, bottom: 8.0),
      ),
      actions: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 8.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue.withOpacity(0.5),
          ),
          child: IconButton(
            icon: Icon(Iconsax.camera, color: Colors.white),
            onPressed: _pickImage,
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 8.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue.withOpacity(0.5),
          ),
          child: IconButton(
            onPressed: () => signOut(context),
            icon: Icon(Iconsax.logout, color: Colors.white, size: 20),
          ),
        ),
      ],
    );
  }

  void signOut(BuildContext context) {
    AuthService().signOut().then((_) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
            (Route<dynamic> route) => false,
      );
    });
  }
}
