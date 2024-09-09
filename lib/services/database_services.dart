import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/villa_model.dart';

class DatabaseService {
  // Déclaration et Initialisation
  CollectionReference _apparts = FirebaseFirestore.instance.collection('apparts');
  FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload de l'image vers Firebase Storage
  Future<List<String>> uploadFiles(List<File> files) async {
    List<String> downloadUrls = [];
    for (File file in files) {
      Reference reference = _storage.ref().child('apparts/${DateTime.now()}.png');
      UploadTask uploadTask = reference.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      downloadUrls.add(downloadUrl);
    }
    return downloadUrls;
  }

  // Ajout de l'appartement dans la BDD
  Future<void> addAppart(Appart appart) async {
    // Récupérer l'utilisateur actuellement connecté
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Récupérer le nom d'utilisateur à partir de Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      String username = userDoc.get('username');

      // Ajouter l'appartement avec le nom d'utilisateur
      _apparts.add({
        "appartName": appart.appartName,
        "appartDescription": appart.appartDescription,
        "appartPrice": appart.appartPrice,
        "appartLocation": appart.appartLocation,
        "appartUrlImgs": appart.appartUrlImgs,
        "appartUserID": appart.appartUserID,
        "appartUserName": username, // Utiliser le nom d'utilisateur récupéré
        "appartTimestamp": FieldValue.serverTimestamp(),
        "appartFavoriteCount": 0,
      });
    }
  }

  // Récupération des logements
  Stream<List<Appart>> get apparts {
    Query queryApparts = _apparts.orderBy('appartTimestamp', descending: true);
    return queryApparts.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Appart(
          appartID: doc.id,
          appartName: doc.get('appartName'),
          appartDescription: doc.get('appartDescription'),
          appartPrice: doc.get('appartPrice'),
          appartLocation: doc.get('appartLocation'),
          appartUrlImgs: List<String>.from(doc.get('appartUrlImgs') ?? []),
          appartUserID: doc.get('appartUserID'),
          appartUserName: doc.get('appartUserName'),
          appartFavoriteCount: doc.get('appartFavoriteCount'),
          appartTimestamp: doc.get('appartTimestamp'),
        );
      }).toList();
    });
  }
}
