import 'package:cloud_firestore/cloud_firestore.dart';

class Appart {
  String? appartID, appartName, appartLocation, appartDescription, appartUrlImg, appartUserName, appartUserID;
  Timestamp? appartTimestamp;
  bool? isMyFavoritedAppart;
  int? appartFavoriteCount,appartPrice;
  Appart(
      {this.appartID,
        this.appartName,
        this.appartLocation,
        this.appartDescription,
        this.appartPrice,
        this.appartUrlImg,
        this.appartUserID,
        this.appartUserName,
        this.appartTimestamp,
        this.isMyFavoritedAppart,
        this.appartFavoriteCount});
}