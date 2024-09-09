import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';


class Appart {
  String? appartID, appartName, appartDescription, appartLocation, appartUserID, appartUserName;
  int? appartPrice, appartFavoriteCount;
  List<String>? appartUrlImgs;
  Timestamp? appartTimestamp;

  Appart({
    this.appartID,
    this.appartName,
    this.appartDescription,
    this.appartPrice,
    this.appartLocation,
    this.appartUrlImgs,
    this.appartUserID,
    this.appartUserName,
    this.appartFavoriteCount,
    this.appartTimestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'appartID': appartID,
      'appartName': appartName,
      'appartDescription': appartDescription,
      'appartPrice': appartPrice,
      'appartLocation': appartLocation,
      'appartUrlImgs': appartUrlImgs,
      'appartUserID': appartUserID,
      'appartUserName': appartUserName,
      'appartFavoriteCount': appartFavoriteCount,
      'appartTimestamp': appartTimestamp,
    };
  }
}
