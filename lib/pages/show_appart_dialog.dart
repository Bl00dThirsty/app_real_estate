import 'dart:io';

import 'package:app_real_estate/services/database_services.dart';
import 'package:app_real_estate/shared_ui/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import '../models/villa_model.dart';

class AppartDialog {
  User? user;
  AppartDialog({this.user});


  void showAppartDialog(BuildContext context, ImageSource source) async {
    XFile? _pickedFile = await ImagePicker().pickImage(source: source);
    File _file = File(_pickedFile!.path);
    final _keyForm = GlobalKey<FormState>();
    String _appartName = '';
    String _appartDescription = '';
    int _appartPrice = 0;
    String _formError = 'Veillez fournir plus d\'information';

    showDialog(
        context: context,
        builder: (BuildContext context){
      return SimpleDialog(
        contentPadding: EdgeInsets.zero,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0),),
              color: Colors.grey,
              image: DecorationImage(
                image: FileImage(_file),
                fit: BoxFit.cover,
          ),
            ),
          ),
  Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(

      children: [
        Form(
            key: _keyForm,
            child: Column(
              children: [
                TextFormField(
                          maxLength: 40,
                          onChanged: (value) => _appartName = value,
                          validator: (value) => _appartName == '' ? _formError : null,
                          decoration: InputDecoration(
                labelText: 'Nom du logement',
                border: OutlineInputBorder(),
                          ),
                        ),
                TextFormField(
                  maxLength: 250,
                  onChanged: (value) => _appartDescription = value,
                  validator: (value) => _appartDescription.isEmpty ? _formError : null,
                  decoration: InputDecoration(
                    labelText: 'Description du logement',
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  onChanged: (value) => _appartPrice = int.tryParse(value) ?? 0,
                  validator: (value) => _appartPrice <= 0 ? _formError : null,
                  decoration: InputDecoration(
                    labelText: 'Prix du logement',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Wrap(
            children: [
              TextButton(onPressed: () => Navigator.of(context).pop(),
                  child: Text('Annuler')),
              ElevatedButton(
                  onPressed: () => onSubmit(context, _keyForm, _file, _appartName, _appartDescription,_appartPrice, user),
                  child: Text('Publier'))
            ],
          ),
        )
      ],
    ),
  )
        ],
      );
        });
  }
  void onSubmit(context, keyForm, file, appartName,appartDescription,appartPrice, user) async {
    if(keyForm.currentState!.validate()) {
      Navigator.of(context).pop();
      showNotification(context, "Chargement....");
      DatabaseService db = DatabaseService();
      String _appartUrlImg = await db.uploadFile(file);
      db.addAppart(Appart(
        appartName: appartName,
        appartDescription: appartDescription,
        appartPrice: appartPrice,
        appartUrlImg: _appartUrlImg,
        appartUserID: user!.uid,
        appartUserName: user!.displayName,

      ));
    }
  }
}