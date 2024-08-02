import 'dart:io';
import 'dart:typed_data';

import 'package:app_real_estate/models/appart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../models/villa_model.dart';

class DatabaseService {

  // Déclaraction et Initialisation
  CollectionReference _apparts = FirebaseFirestore.instance.collection('apparts');
  FirebaseStorage _storage = FirebaseStorage.instance;

  // upload de l'image vers Firebase Storage
  Future<String> uploadFile(File file) async {
    Reference reference = _storage.ref().child('apparts/${DateTime.now()}.png');
    ///

    UploadTask uploadTask = reference.putFile(file);
        //? reference.putData(imageTosave, metaData)

    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  // ajout de la voiture dans la BDD
  void addAppart(Appart appart) {
    _apparts.add({
      "appartName": appart.appartName,
      "appartDescription": appart.appartDescription,
      "appartPrice": appart.appartPrice,
      "appartUrlImg": appart.appartUrlImg,
      "appartUserID": appart.appartUserID,
      "appartUserName": appart.appartUserName,
      "appartTimestamp": FieldValue.serverTimestamp(),
      "appartFavoriteCount": 0,
    });
  }

  // récupération des logements

  Stream<List<Appart>> get apparts {
    Query queryApparts = _apparts.orderBy('appartTimestamp', descending: true);
    return queryApparts.snapshots().map((snapshot) {
      return snapshot.docs.map((doc){
        return Appart(
          appartID: doc.id,
          appartName: doc.get('appartName'),
          appartDescription: doc.get('appartDescription'),
          appartPrice: doc.get('appartPrice'),
          appartUrlImg: doc.get('appartUrlImg'),
          appartUserID: doc.get('appartUserID'),
          appartUserName: doc.get('appartUserName'),
          appartFavoriteCount: doc.get('appartFavoriteCount'),
          appartTimestamp: doc.get('appartTimestamp'),
        );
      }).toList();
    });
  }

}
